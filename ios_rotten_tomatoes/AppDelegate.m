//
//  AppDelegate.m
//  ios_rotten_tomatoes
//
//  Created by Stanley Ng on 6/6/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

#import "AppDelegate.h"
#import "MoviesViewController.h"
#import "AVHexColor.h"
#import "Movies.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    // Customize status bar
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];

    // Customize navigation bar
    [self customizeNavBarAppearance];
    [self customizeBarButtonItemAppearance];
    
    // Define root view controller
    //MoviesViewController *vc = [[MoviesViewController alloc] init];
    //UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    //self.window.rootViewController = nvc;
    
    // Create tab bar controller
    UITabBarController *tbc = [[UITabBarController alloc] init];
    tbc.delegate = self;
    self.window.rootViewController = tbc;
    
    // Create view controller with navigation control
    NSMutableDictionary *views = [[NSMutableDictionary alloc] init];

    views[@"box_office"] =
        [[UINavigationController alloc]
         initWithRootViewController: [[MoviesViewController alloc] init]];
    
    views[@"top_rentals"] =
        [[UINavigationController alloc]
         initWithRootViewController: [[MoviesViewController alloc] init]];

    tbc.viewControllers = @[views[@"box_office"], views[@"top_rentals"]];
    
    // Configure tab bar items
    ((UINavigationController *)views[@"box_office"]).tabBarItem.title = @"Box Office";
    ((UINavigationController *)views[@"box_office"]).tabBarItem.image = [UIImage imageNamed:@"icon-film"];
    
    ((UINavigationController *)views[@"top_rentals"]).tabBarItem.title = @"Top Rentals";
    ((UINavigationController *)views[@"top_rentals"]).tabBarItem.image = [UIImage imageNamed:@"icon-cd"];
    
    // Select "box_office"
    [Movies instance].current = @"box_office";
    
    self.window.backgroundColor = [UIColor whiteColor];
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

- (void)customizeNavBarAppearance
{
    id navigationBarAppearance = [UINavigationBar appearance];
    [navigationBarAppearance setTitleTextAttributes:
     @{
       NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f]
       }];
    [navigationBarAppearance setTintColor:[AVHexColor colorWithHexString:@"#F7F7F7"]];
    [navigationBarAppearance setBarTintColor:[AVHexColor colorWithHexString:@"#3B5998"]];
}

- (void)customizeBarButtonItemAppearance
{
    id barButtonItemAppearance = [UIBarButtonItem appearance];
    [barButtonItemAppearance setTintColor:[UIColor whiteColor]];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"didSelectViewController");

    NSString *title = viewController.tabBarItem.title;
    
    if ([title isEqualToString:@"Box Office"]) {
        NSLog(@"title = %@", title);
        [Movies instance].current = @"box_office";
    }
    else if ([title isEqualToString:@"Top Rentals"]) {
        NSLog(@"title = %@", title);
        [Movies instance].current = @"top_rentals";
    }
    else {
        NSLog(@"title not found! %@", title);
    }
}
@end
