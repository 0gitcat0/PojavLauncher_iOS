# This one is only used for local compile on developer iphone, do not execute if
# - You don't know what will it does.
# - No SDK and clang installed.

#!/bin/bash
set -e

CFLAGS="\
  -Wl,-rpath,/Applications/PojavLauncher.app/Frameworks \
  -fobjc-arc \
  -x objective-c \
  -isysroot /var/mobile/theos/sdks/iPhoneOS13.4.sdk \
  -Fresources/Frameworks \
    -Iexternal_include \
  -Lresources/Frameworks \
"
#  -L/Applications/PojavLauncher.app/Frameworks \

# Build PojavLauncher (executable)
clang -framework UIKit $CFLAGS -o PojavLauncher \
  main.c log.m JavaLauncher.c \
  -DUSE_GL_OVERRIDE \

# Build libOSMesaOverride.dylib
clang -dynamiclib -o libOSMesaOverride.dylib -lOSMesa.8 $CFLAGS \
  gl_mesa3d_patch.c

# Build libpojavexec.dylib
clang -framework UIKit -framework CoreGraphics -framework AuthenticationServices -dynamiclib $CFLAGS -o libpojavexec.dylib \
  log.m AppDelegate.m SceneDelegate.m UILauncher.m LauncherViewController.m LoginViewController.m SurfaceViewController.m egl_bridge_ios.m ios_uikit_bridge.m customcontrols/ControlButton.m \
  egl_bridge.c input_bridge_v3.c utils.c \
  -Wl,-undefined,dynamic_lookup \
  -lOSMesa.8

# Sign them
ldid -S../entitlements.xml PojavLauncher
ldid -S../entitlements.xml libpojavexec.dylib

# Copy override existing installed binaries
cp PojavLauncher /Applications/PojavLauncher.app/PojavLauncher
cp *.dylib /Applications/PojavLauncher.app/Frameworks/

echo "BUILD SUCCESSFUL"