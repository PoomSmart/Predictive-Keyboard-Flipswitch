#import <Flipswitch/FSSwitchDataSource.h>
#import <Flipswitch/FSSwitchPanel.h>

@interface UIKeyboardPreferencesController : NSObject
+ (UIKeyboardPreferencesController *)sharedPreferencesController;
- (id)valueForKey:(NSInteger)key;
- (void)setValue:(id)value forKey:(NSInteger)key;
- (void)synchronizePreferences;
@end

#define KeyboardPrediction 35 // value in iOS 8+

@interface PredictiveKeyboardSwitch : NSObject <FSSwitchDataSource>
@end

static void PreferencesChanged() {
    [[FSSwitchPanel sharedPanel] stateDidChangeForSwitchIdentifier:@"com.PS.PredictiveKeyboard"];
}

@implementation PredictiveKeyboardSwitch

- (id)init {
    if (self == [super init])
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)PreferencesChanged, CFSTR("AppleKeyboardsSettingsChangedNotification"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    return self;
}

- (void)dealloc {
    CFNotificationCenterRemoveObserver(CFNotificationCenterGetDarwinNotifyCenter(), self, NULL, NULL);
    [super dealloc];
}

- (FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier {
    return [[[UIKeyboardPreferencesController sharedPreferencesController] valueForKey:KeyboardPrediction] boolValue] ? FSSwitchStateOn : FSSwitchStateOff;
}

- (void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier {
    if (newState == FSSwitchStateIndeterminate)
        return;
    [[UIKeyboardPreferencesController sharedPreferencesController] setValue:@(newState == FSSwitchStateOn) forKey:KeyboardPrediction];
    [[UIKeyboardPreferencesController sharedPreferencesController] synchronizePreferences];
}

@end
