//
//  SecondVC.h
//  test
//
//  Created by bigiron on 2017/5/10.
//  Copyright © 2017年 bigiron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveCocoa.h"
@interface SecondVC : UIViewController
//步骤一：在第二个控制器.h，添加一个RACSubject代替代理。


@property (nonatomic, strong) RACSubject *delegateSignal;
@end
