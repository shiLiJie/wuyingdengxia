//
//  AppDelegate.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/3.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "AppDelegate.h"
#import "PlusButton.h"
#import "TabBarControllerConfig.h"
#import "AppDelegate+YCLaunchAd.h"

@interface AppDelegate ()

@property (nonatomic, strong) TabBarControllerConfig *tabBarControllerConfig;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // window初始化
    _window = [[UIWindow alloc]init];
    _window.frame = [UIScreen mainScreen].bounds;
    
    // 添加跟控制器
    [self addTabbarVc];
    
    return YES;
}

-(void)addTabbarVc{
    
    // 中间按钮
    [PlusButton registerPlusButton];
    
    // 添加根控制器
    self.tabBarControllerConfig = [[TabBarControllerConfig alloc]init];
    _window.rootViewController = self.tabBarControllerConfig.tabBarController;
    
    [_window makeKeyAndVisible];
}

-(void)chaninde2
{
    self.tabBarControllerConfig.tabBarController.selectedIndex = 1;
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
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
