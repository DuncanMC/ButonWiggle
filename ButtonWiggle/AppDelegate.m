//
//  AppDelegate.m
//  ButtonWiggle
//
//  Created by Duncan Champney on 3/14/14.
//  Copyright (c) 2014 WareTo. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
  CAMediaTimingFunction *function =   [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  float c0[2], c1[2], c2[2], c3[3];
  
  c0[0] = 1000;
  c0[1] = 1000;
  
  c1[0] = 1000;
  c1[1] = 1000;
  
  c2[0] = 1000;
  c2[1] = 1000;
  
  c3[0] = 1000;
  c3[1] = 1000;
  
  [function getControlPointAtIndex: 0 values: c0];
  [function getControlPointAtIndex: 1 values: c1];
  [function getControlPointAtIndex: 2 values: c2];
  [function getControlPointAtIndex: 3 values: c3];
  
  NSLog(@"For kCAMediaTimingFunctionEaseInEaseOut timing function, c0 = (%.2f,%.2f)", c0[0], c0[1]);
  NSLog(@"For kCAMediaTimingFunctionEaseInEaseOut timing function, c1 = (%.2f,%.2f)", c1[0], c1[1]);
  NSLog(@"For kCAMediaTimingFunctionEaseInEaseOut timing function, c2 = (%.2f,%.2f)", c2[0], c2[1]);
  NSLog(@"For kCAMediaTimingFunctionEaseInEaseOut timing function, c3 = (%.2f,%.2f)", c3[0], c3[1]);
  
  NSLog(@"Done");
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

@end
