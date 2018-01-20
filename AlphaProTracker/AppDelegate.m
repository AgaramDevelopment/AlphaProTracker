//
//  AppDelegate.m
//  AlphaProTracker
//
//  Created by Mac on 21/08/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "AppDelegate.h"
#import "ExcierseDetailVC.h"


@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize window,storyBoard,navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"];
    
    
    UIViewController * initViewController = [storyBoard instantiateViewControllerWithIdentifier:(isLogin ? @"HomeVC" : @"LoginVC")];
    
    //ExcierseDetailVC *initViewController = [ExcierseDetailVC new];
    
    
    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    navigationController = [[UINavigationController alloc] initWithRootViewController:initViewController];
    navigationController.navigationBarHidden = YES;
    window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}
-(void)redirectSelectview:(NSString *)selectViewcontroller
{
    UIViewController *initViewController = [appDel.storyBoard instantiateViewControllerWithIdentifier:selectViewcontroller];
    
    for (UIViewController* VC in appDel.navigationController.viewControllers) {
        if ([initViewController isKindOfClass:VC.classForCoder]) {
            return;
        }
        else{
            [appDel.navigationController popViewControllerAnimated:NO];
        }
    }
    
    [appDel.navigationController pushViewController:initViewController animated:YES];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    }


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




@end
