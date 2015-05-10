//
//  AppDelegate.m
//  RightCycle
//
//  Created by Atomicflare on 2015-05-09.
//  Copyright (c) 2015 RightCycle. All rights reserved.
//

#import "AppDelegate.h"
#import <MyoKit/MyoKit.h>
#import "RightCycleGestureReconizer.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
{
    RightCycleGestureReconizer * rightCycleGestureReconizer;

}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Instantiate the hub using the singleton accessor, and set the applicationIdentifier of our application.
    [[TLMHub sharedHub] setApplicationIdentifier:@"com.RightCycle.RightCycle"];
    [[TLMHub sharedHub] setShouldNotifyInBackground:YES];
    [[TLMHub sharedHub] setShouldSendUsageData:NO];
    [TLMHub sharedHub].lockingPolicy = TLMLockingPolicyNone;

    
    rightCycleGestureReconizer = [[RightCycleGestureReconizer alloc]init];
    
    // Instantiate our view controller
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.window.rootViewController = [[TLHMViewController alloc] init];
//    [self.window makeKeyAndVisible];
    
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:(9.0f/255.f) green:(14.0f/255.f) blue:(23.0f/255.f) alpha:1.0f]];
    // Assign tab bar item with titles
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UITabBar *tabBar = tabBarController.tabBar;
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
    UITabBarItem *tabBarItem5 = [tabBar.items objectAtIndex:4];
    
    tabBarItem1.title = @"";
    tabBarItem2.title = @"";
    tabBarItem3.title = @"";
    tabBarItem4.title = @"";
    tabBarItem5.title = @"";
    
    [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"menuicon_sync_on.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"menuicon_sync_off.png"]];
    [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"menuicon_gestures_on.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"menuicon_gestures_off.png"]];
    [tabBarItem3 setFinishedSelectedImage:[UIImage imageNamed:@"menuicon_map_on.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"menuicon_map_off.png"]];
    [tabBarItem4 setFinishedSelectedImage:[UIImage imageNamed:@"menuicon_signals_on.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"menuicon_signals_off.png"]];
    [tabBarItem5 setFinishedSelectedImage:[UIImage imageNamed:@"menuicon_settings_on.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"menuicon_settings_off.png"]];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
