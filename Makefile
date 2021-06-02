PACKAGE_VERSION = 1.0.0
TARGET = iphone:clang:latest:11.0

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = PredictiveKeyboardFS
PredictiveKeyboardFS_FILES = Switch.xm
PredictiveKeyboardFS_LIBRARIES = flipswitch
PredictiveKeyboardFS_FRAMEWORKS = UIKit
PredictiveKeyboardFS_INSTALL_PATH = /Library/Switches

include $(THEOS_MAKE_PATH)/bundle.mk
