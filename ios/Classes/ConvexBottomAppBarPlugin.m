#import "ConvexBottomAppBarPlugin.h"
#if __has_include(<convex_bottom_app_bar/convex_bottom_app_bar-Swift.h>)
#import <convex_bottom_app_bar/convex_bottom_app_bar-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "convex_bottom_app_bar-Swift.h"
#endif

@implementation ConvexBottomAppBarPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftConvexBottomAppBarPlugin registerWithRegistrar:registrar];
}
@end
