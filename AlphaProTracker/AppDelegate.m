//
//  AppDelegate.m
//  AlphaProTracker
//
//  Created by Mac on 21/08/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "AppDelegate.h"
#import "ExcierseDetailVC.h"
#import "Reachability.h"
#import "Utitliy.h"
#import "DBMANAGERSYNC.h"
#import "AppCommon.h"
#import "Config.h"
#import "WebService.h"




@interface AppDelegate ()
{
    UIActivityIndicatorView *indicator;
    UINavigationController *navigationController;
    BOOL IsTimer;
    BOOL isBackGroundTaskRunning;
    NSTimer* _timer;
}

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
    UIApplication *app = [UIApplication sharedApplication];
    
    //create new uiBackgroundTask
    __block UIBackgroundTaskIdentifier bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];
    
    //and create new timer with async call:
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSTimer * t = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(methodRunAfterBackground) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:t forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    });
    IsTimer=NO;
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
   
    
    IsTimer=YES;
    UIApplication *app = [UIApplication sharedApplication];
    
    //create new uiBackgroundTask
    __block UIBackgroundTaskIdentifier bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];
    
    //and create new timer with async call:
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //run function methodRunAfterBackground
        //        NSTimer* t = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(methodRunAfterBackground) userInfo:nil repeats:NO];
        //        [[NSRunLoop currentRunLoop] addTimer:t forMode:NSDefaultRunLoopMode];
        //        [[NSRunLoop currentRunLoop] run];
    });

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    
    IsTimer=YES;
    UIApplication *app = [UIApplication sharedApplication];
    
    //create new uiBackgroundTask
    __block UIBackgroundTaskIdentifier bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];
    
    
    //and create new timer with async call:
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //run function methodRunAfterBackground
        NSTimer* t = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(methodRunAfterBackground) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:t forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    });
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(void)SynenableanddisbleMethod
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults boolForKey:@"onlineSyn"])
    {
        IsTimer=YES;
        UIApplication *app = [UIApplication sharedApplication];
        
        //create new uiBackgroundTask
        __block UIBackgroundTaskIdentifier bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
            [app endBackgroundTask:bgTask];
            bgTask = UIBackgroundTaskInvalid;
        }];
        
        
        //and create new timer with async call:
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //run function methodRunAfterBackground
            NSTimer* t = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(methodRunAfterBackground) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:t forMode:NSDefaultRunLoopMode];
            [[NSRunLoop currentRunLoop] run];
        });
    }
    else
    {
        
        UIApplication *app = [UIApplication sharedApplication];
        //create new uiBackgroundTask
        __block UIBackgroundTaskIdentifier bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
            [app endBackgroundTask:bgTask];
            bgTask = UIBackgroundTaskInvalid;
        }];
        
        //and create new timer with async call:
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSTimer * t = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(methodRunAfterBackground) userInfo:nil repeats:NO];
            //[[NSRunLoop currentRunLoop] addTimer:t forMode:NSDefaultRunLoopMode];
            //[[NSRunLoop currentRunLoop] run];
        });
        IsTimer=NO;
        
    }
    
}

-(void)methodRunAfterBackground
{
    
    {
        
        //   return ;
        
        
        NSLog(@"background process method");
        if(IsTimer == YES)
        {
            
            //-----------------------------------
            
                //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"];
                
                if(isLogin)
                {
                    if(self.checkInternetConnection && !isBackGroundTaskRunning){
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            
                            DBMANAGERSYNC * objCaptransactions = [[DBMANAGERSYNC alloc]init];
                            //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                            
                            NSString *SequenceNo = @"0";
                            
                            if(![SequenceNo isEqualToString:@""] && ![SequenceNo isEqualToString:@"(null)"] ){
                                
                                NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                                dic = [objCaptransactions AssessmentEntrySyncBackground];
                                
                                //NSMutableArray *reqList = [[NSMutableArray alloc]init];
                                //reqList = [dic valueForKey:@"LstAssessmententry"];
                                if(dic.count>0 ){
                                    [self PushWebservice:dic];
                                }else{
                                    
                                }
                                
                            }
                        });
                    });
                }
                
                
                else{
                    //           IsTimer=NO;
                    //            UIAlertView *altert =[[UIAlertView alloc]initWithTitle:@"Score Engine" message:@"Network Error. " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    //            [altert show];
                    //            [altert setTag:10405];
                    
                }
            }
            
            //-----------------------------------
            
        }
        else if( IsTimer== NO)
        {
            //NSTimer* _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(methodRunAfterBackground) userInfo:nil repeats:NO];
            if ([_timer isValid]) {
                [_timer invalidate];
            }
            _timer = nil;
            
        }
        
        
    }
}

-(void)PushWebservice :(NSMutableDictionary *)reqdic
{
    
    if([COMMON isInternetReachable])
    {
        
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",pushServiceKey]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
       // NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        
        //if([reqdic valueForKey:@"LstAssessmententry"])   [dic    setObject:[reqdic valueForKey:@"LstAssessmententry"]     forKey:@"LstAssessmententry"];
        
        //NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:reqdic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                //if([[responseObject valueForKey:@"Message"] isEqualToString:@"PSUCCESS"])
                
//                if([[responseObject valueForKey:@"Message"] isEqualToString:@"PSUCCESS"] && [responseObject valueForKey:@"Message"] != NULL)
//                {
//
//                }
//                else
//                {
//
//                }
            }
            
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed");
        }];
    }
    
}



- (BOOL)checkInternetConnection
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}



@end
