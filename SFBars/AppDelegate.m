//
//  AppDelegate.m
//  SFBars
//
//  Created by JACKIE TRILLO on 1/11/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "AppDelegate.h"
#import "MFSideMenuContainerViewController.h"
#import "MenuViewController.h"
#import "SettingsViewController.h"

@interface AppDelegate ()

@property (readwrite, nonatomic, strong) BarsFacade* barsFacade;

@end

@implementation AppDelegate

- (UINavigationController *)navigationController {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:@"NavigationViewController"];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [GMSServices provideAPIKey:@"AIzaSyBwemjLYLhOFeh7NRdaiMUesp_sawcnZh0"]; // configuration
   
    
    self.barsFacade = [[BarsFacade alloc] init];
  
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    MenuViewController* leftMenuViewController = [storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    SettingsViewController *rightMenuViewController = [storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
    MFSideMenuContainerViewController *container = [MFSideMenuContainerViewController
                                                    containerWithCenterViewController:[self navigationController]
                                                    leftMenuViewController:leftMenuViewController
                                                    rightMenuViewController:rightMenuViewController];

    // Set root view controller and make windows visible
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = container;
    [self.window makeKeyAndVisible];


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
    self.barsFacade = nil;
    
}
@end
