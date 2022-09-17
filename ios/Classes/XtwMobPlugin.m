#import "XtwMobPlugin.h"
#if __has_include(<xtw_mob/xtw_mob-Swift.h>)
#import <xtw_mob/xtw_mob-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "xtw_mob-Swift.h"
#endif

@implementation XtwMobPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftXtwMobPlugin registerWithRegistrar:registrar];
}
@end
