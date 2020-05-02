#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import "FlutterDeveloper.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    int flutter_native_splash = 1;
    UIApplication.sharedApplication.statusBarHidden = false;
    
    FlutterDeveloper *developer = [[FlutterDeveloper alloc] initWith:@"wy" andAge:31];
    [developer say:@"我不容易啊!"];

    [GeneratedPluginRegistrant registerWithRegistry:self];
    // Override point for customization after application launch.
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
