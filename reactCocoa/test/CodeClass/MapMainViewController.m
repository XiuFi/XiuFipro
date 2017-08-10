//
//  MapMainViewController.m
//  test
//
//  Created by zzc-13 on 2017/8/6.
//  Copyright © 2017年 bigiron. All rights reserved.
//

#import "MapMainViewController.h"
#import <Mapbox/Mapbox.h>
#import "Masonry.h"
#import "UIColor+Category.h"

@interface MapMainViewController ()

@property (strong, nonatomic) MGLMapView *mapView;
@property (strong, nonatomic) UIButton *plusZoomLevelBtn;
@property (strong, nonatomic) UIButton *reduceZoomLevelBtn;
@property (strong, nonatomic) UIButton *userPositionBtn;
@property (strong, nonatomic) UILabel *aaasdasda;

@end

#define USERDEFAULT [NSUserDefaults standardUserDefaults]

@implementation MapMainViewController

#pragma mark lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.plusZoomLevelBtn];
    [self.view addSubview:self.reduceZoomLevelBtn];
    [self.view addSubview:self.userPositionBtn];
    
    [self initConstraints];
}

#pragma mark private method
- (void)initConstraints{
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.with.equalTo(self.view);
    }];
    
    [_plusZoomLevelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).mas_offset(-10);
        make.bottom.equalTo(self.view).mas_offset(-100);
        make.height.with.mas_equalTo(24);
    }];
    
    [_reduceZoomLevelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.plusZoomLevelBtn.mas_bottom).mas_offset(10);
        make.right.equalTo(self.view).mas_offset(-10);
        make.height.with.mas_equalTo(24);
    }];
    
    [_userPositionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.plusZoomLevelBtn.mas_top).mas_offset(-10);
        make.right.equalTo(self.view).mas_offset(-10);
        make.height.with.mas_equalTo(24);
    }];
    
    
}

//改变地图level
- (void)plusZoomLevel{
    [_mapView setZoomLevel:_mapView.zoomLevel+1 animated:true];
}

- (void)reduceZoomLevel{
    [_mapView setZoomLevel:_mapView.zoomLevel-1 animated:true];
}

- (void)centerUserPosition{
    CLLocationCoordinate2D userLocaltion2D = _mapView.userLocation.location.coordinate;
    [_mapView setCenterCoordinate:userLocaltion2D zoomLevel:8 animated:true];
}

#pragma mark set/get

- (MGLMapView *)mapView{
    if (!_mapView) {
        _mapView = [[MGLMapView alloc] init];
        _mapView.showsUserLocation = true;
        _mapView.styleURL = [MGLStyle darkStyleURLWithVersion:MGLStyleDefaultVersion];
    }
    return _mapView;
}

- (UIButton *)plusZoomLevelBtn{
    if (!_plusZoomLevelBtn) {
        _plusZoomLevelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_plusZoomLevelBtn setTitle:@"+" forState:UIControlStateNormal];
        [_plusZoomLevelBtn setBackgroundColor:[UIColor colorWithHexString:@"#4588F5"]];
        [_plusZoomLevelBtn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
        [_plusZoomLevelBtn addTarget:self action:@selector(plusZoomLevel) forControlEvents:UIControlEventTouchUpInside];
    }
    return _plusZoomLevelBtn;
}

- (UIButton *)reduceZoomLevelBtn{
    if (!_reduceZoomLevelBtn) {
        _reduceZoomLevelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_reduceZoomLevelBtn setTitle:@"-" forState:UIControlStateNormal];
        [_reduceZoomLevelBtn setBackgroundColor:[UIColor colorWithHexString:@"#4588F5"]];
        [_reduceZoomLevelBtn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
        [_reduceZoomLevelBtn addTarget:self action:@selector(reduceZoomLevel) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reduceZoomLevelBtn;
}

- (UIButton *)userPositionBtn{
    if (!_userPositionBtn) {
        _userPositionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_userPositionBtn setTitle:@"@" forState:UIControlStateNormal];
        [_userPositionBtn setBackgroundColor:[UIColor colorWithHexString:@"#4588F5"]];
        [_userPositionBtn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
        [_userPositionBtn addTarget:self action:@selector(centerUserPosition) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userPositionBtn;
}

@end
