//
//  AppDelegate.m
//  test
//
//  Created by bigiron on 2017/3/29.
//  Copyright © 2017年 bigiron. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIWindow *window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
     BaseTabBarController *rootVC = [[BaseTabBarController alloc]init];
    window.rootViewController = rootVC;
    [window makeKeyAndVisible];
    self.window = window;
    
    return YES;
}



@end
