//
//  AppDelegate.m
//  Geofence
//
//  Created by Peterlee on 7/31/13.
//  Copyright (c) 2013 Peterlee. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
      [TestFlight takeOff:@"1584a725-1797-4739-b8f2-c35f19324503"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];

    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

//    UIApplication *app = [UIApplication sharedApplication];
//    __block UIBackgroundTaskIdentifier bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (bgTask != UIBackgroundTaskInvalid) {
//                [app endBackgroundTask:bgTask];
//                bgTask = UIBackgroundTaskInvalid;
//            }
//        });
//    }];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//           NSTimer *testTimer = [NSTimer scheduledTimerWithTimeInterval:(1) target:self selector:@selector(doSomeTest) userInfo:nil repeats:YES];
//        [testTimer fire];
//        [[NSRunLoop currentRunLoop] addTimer:testTimer forMode:NSRunLoopCommonModes];
//        
//        [[NSRunLoop currentRunLoop] run];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (bgTask != UIBackgroundTaskInvalid) {
//                [app endBackgroundTask:bgTask];
//                bgTask = UIBackgroundTaskInvalid;
//            }
//        });
//    });
}
-(void) doSomeTest
{
    NSLog(@"test");
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif {
    // Handle the notificaton when the app is running
   // NSLog(@"Recieved Notification %@",notif);
    
}


@end
