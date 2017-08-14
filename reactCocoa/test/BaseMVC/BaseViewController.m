//
//  BaseViewController.m
//  test
//
//  Created by zzc-13 on 2017/8/6.
//  Copyright © 2017年 bigiron. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

//统一设置状态栏颜色
-(UIStatusBarStyle)preferredStatusBarStyle
{
    if (self.navigationController.viewControllers.count == 1) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

@end
