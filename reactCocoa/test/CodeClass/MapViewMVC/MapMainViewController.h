//
//  MapMainViewController.h
//  test
//
//  Created by zzc-13 on 2017/8/6.
//  Copyright © 2017年 bigiron. All rights reserved.
//

#import "BaseViewController.h"
#import <Mapbox/Mapbox.h>

@interface MapMainViewController : BaseViewController<MGLMapViewDelegate>

@property (strong, nonatomic) MGLMapView *mapView;

@end
