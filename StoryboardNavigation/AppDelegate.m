//
//  AppDelegate.m
//  StoryboardNavigation
//
//  Created by 김사랑 on 13. 12. 27..
//  Copyright (c) 2013년 김사랑. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize fontS;
@synthesize imageHiding;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    fontS = 20;
    imageHiding = true;
    
    self.tabBarController = (UITabBarController*) self.window.rootViewController;
    NSArray* items = [self.tabBarController.tabBar items];
    
    UIImage *image1_a = [UIImage imageNamed:@"newspaper_normal.png"];
    UIImage *image1_b = [UIImage imageNamed:@"newspaper_click.png"];
    UIImage *image2_a = [UIImage imageNamed:@"category_normal.png"];
    UIImage *image2_b = [UIImage imageNamed:@"category_click.png"];
    UIImage *image3_a = [UIImage imageNamed:@"search_normal.png"];
    UIImage *image3_b = [UIImage imageNamed:@"search_click.png"];
    UIImage *image4_a = [UIImage imageNamed:@"setting_normal.png"];
    UIImage *image4_b = [UIImage imageNamed:@"setting_click.png"];
    
    
    UITabBarItem *item1 = [items objectAtIndex:0];
    [item1 setFinishedSelectedImage:image1_a withFinishedUnselectedImage:image1_b];
    
    UITabBarItem *item2 = [items objectAtIndex:1];
    [item2 setFinishedSelectedImage:image2_a withFinishedUnselectedImage:image2_b];
    
    UITabBarItem *item3 = [items objectAtIndex:2];
    [item3 setFinishedSelectedImage:image3_a withFinishedUnselectedImage:image3_b];
    
    UITabBarItem *item4 = [items objectAtIndex:3];
    [item4 setFinishedSelectedImage:image4_a withFinishedUnselectedImage:image4_b];

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
