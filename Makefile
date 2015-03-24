SDKVERSION = 7.0
ARCHS = armv7 arm64

include theos/makefiles/common.mk

BUNDLE_NAME = PredictiveKeyboard
PredictiveKeyboard_FILES = Switch.xm
PredictiveKeyboard_LIBRARIES = flipswitch
PredictiveKeyboard_FRAMEWORKS = UIKit
PredictiveKeyboard_INSTALL_PATH = /Library/Switches

include $(THEOS_MAKE_PATH)/bundle.mk
