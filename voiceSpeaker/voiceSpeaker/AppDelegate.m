//
//  AppDelegate.m
//  voiceSpeaker
//
//  Created by 金玉衡 on 16/8/10.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "AppDelegate.h"
#import "RXLSideSlipViewController.h"
#import "UIViewController+RXLSideMenu.h"
#import "leftViewController.h"
#import "rightViewController.h"
#import "ViewController.h"
#import "WWSideslipViewController.h"
#import "DDMenuController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    UIWindow *window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window = window;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.
//    
//    leftViewController *left = [[leftViewController alloc] init];
//    rightViewController *right = [[rightViewController alloc] init];
//    
    
//    
//    RXLSideSlipViewController *RXL = [[RXLSideSlipViewController alloc] initWithContentViewController:viewContro leftMenuViewController:left rightMenuViewController:right];
//    
//    
//    //RXL.backgroundImage = [UIImage imageNamed:@"aaa.png"];
//    //RXL.delegate = self;
//    
//    RXL.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
//    RXL.contentViewShadowColor = [UIColor whiteColor];
//    RXL.contentViewShadowOffset = CGSizeMake(0, 0);
//    RXL.contentViewShadowOpacity = 0.6;
//    RXL.contentViewShadowRadius = 12;
//    RXL.contentViewShadowEnabled = NO; // 是否显示阴影
//    RXL.contentPrefersStatusBarHidden = NO;//是否隐藏主视图的状态条
    
    ViewController *viewContro = [[ViewController alloc] init];
//    
    UINavigationController *navigate = [[UINavigationController alloc] initWithRootViewController:viewContro];
    
    
    self.window.rootViewController = navigate;
    
//    WWSideslipViewController * slide = [[WWSideslipViewController alloc]initWithLeftView:left andMainView:viewContro andRightView:right andBackgroundImage:[UIImage imageNamed:@"background"]];
//    
//    //滑动速度系数
//    [slide setSpeedf:0.7];
//    
//    //点击视图是是否恢复位置
//    slide.sideslipTapGes.enabled = YES;
//    
//    self.window.rootViewController = slide;
    
    
    
//    DDMenuController*ddMenu = [[DDMenuController alloc] initWithRootViewController:viewContro];
//    
//    //SideslipViewController *left = [[SideslipViewController alloc] init];
//    ddMenu.leftViewController = left;
//    
//    //SideslipRightViewController *right = [[SideslipRightViewController alloc] init];
//    ddMenu.rightViewController = right;
//    
//    UINavigationController *navigate = [[UINavigationController alloc] initWithRootViewController:ddMenu];
//    
//    self.window.rootViewController = navigate;
    
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
