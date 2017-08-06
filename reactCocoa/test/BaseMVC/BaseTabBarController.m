//
//  BaseTabBarController.m
//  test
//
//  Created by zzc-13 on 2017/8/6.
//  Copyright © 2017年 bigiron. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "MapMainViewController.h"
#import "UserMainViewController.h"

@interface BaseTabBarController ()

@property (strong, nonatomic) NSArray *tabBarTitleArray;
@property (strong, nonatomic) NSArray *tabBarImageArray;
@property (strong, nonatomic) NSArray *tabBarSelectImageArray;
@property (strong, nonatomic) NSArray *tabBarControllerArray;
@property (strong, nonatomic) NSArray *tabBarItems;


@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (int i = 0; i < self.tabBarControllerArray.count; i ++ ) {
        UIViewController *controller = self.tabBarControllerArray[i];
        controller.tabBarItem = self.tabBarItems[i];
        BaseNavigationController *naVC = [[BaseNavigationController alloc] initWithRootViewController:controller];
        [self addChildViewController:naVC];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark set/get
- (NSArray *)tabBarTitleArray{
    if (!_tabBarTitleArray) {
        _tabBarTitleArray = @[@"地图",@"登录"];
    }
    return _tabBarTitleArray;
}

- (NSArray *)tabBarImageArray{
    if (!_tabBarImageArray) {
        _tabBarImageArray = @[@"tabbar_map_default",@"tabbar_personal_defalut"];
    }
    return _tabBarImageArray;
}

- (NSArray *)tabBarSelectImageArray{
    if (!_tabBarImageArray) {
        _tabBarImageArray = @[@"tabbar_map_selected",@"tabbar_personal_selected"];
    }
    return _tabBarSelectImageArray;
}

- (NSArray *)tabBarControllerArray{
    if (!_tabBarControllerArray) {
        MapMainViewController *mapMainVC = [[MapMainViewController alloc] init];
        UserMainViewController *userMainVC = [[UserMainViewController alloc] init];
        _tabBarControllerArray = @[mapMainVC,userMainVC];
    }
    return _tabBarControllerArray;
}

- (NSArray *)tabBarItems {
    if (!_tabBarItems) {
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSInteger i = 0; i < self.tabBarTitleArray.count; i++) {
            UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:self.tabBarTitleArray[i] image:[UIImage imageNamed:self.tabBarImageArray[i]] selectedImage:[UIImage imageNamed:self.tabBarSelectImageArray[i]]];
            [tempArray addObject:tabBarItem];
        }
        _tabBarItems = [tempArray copy];
    }
    return _tabBarItems;
}

@end
