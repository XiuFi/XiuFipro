//
//  MapMainViewController.m
//  test
//
//  Created by zzc-13 on 2017/8/6.
//  Copyright © 2017年 bigiron. All rights reserved.
//

#import "MapMainViewController.h"
#import "Masonry.h"
#import "UIColor+Category.h"
#import "MapMainViewController+drawInMapView.h"

@interface MapMainViewController ()

@property (strong, nonatomic) UIButton *plusZoomLevelBtn;
@property (strong, nonatomic) UIButton *reduceZoomLevelBtn;
@property (strong, nonatomic) UIButton *userPositionBtn;
//line四个方法
@property(nonatomic,strong)UIButton *makelineBtn;
@property(nonatomic,strong)MGLPolyline *routeLine;
@property(nonatomic,assign)BOOL isMakeLine;
@property(nonatomic,strong)NSMutableArray *lineArr;

@end

#define USERDEFAULT [NSUserDefaults standardUserDefaults]

@implementation MapMainViewController

#pragma mark lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.makelineBtn];
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.plusZoomLevelBtn];
    [self.view addSubview:self.reduceZoomLevelBtn];
    [self.view addSubview:self.userPositionBtn];
    [self.view addSubview:self.makelineBtn];
    self.isMakeLine = NO;

    [self initConstraints];
    [self drawPolyline];
    [self drawTestLine];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tapGesture];
    
}
#pragma mark - 画直线
-(void)makeline{
    self.isMakeLine = !self.isMakeLine;
}
- (void)drawTestLine
{
    CLLocation *location0 = [[CLLocation alloc] initWithLatitude:23 longitude:113];
    CLLocation *location1 = [[CLLocation alloc] initWithLatitude:24 longitude:115];
    NSArray *array = [NSArray arrayWithObjects:location0, location1, nil];
    [self drawLineWithLocationArray:array];
}
- (void)drawLineWithLocationArray:(NSArray *)locationArray
{
    long pointCount = [locationArray count];
    CLLocationCoordinate2D *coordinateArray = (CLLocationCoordinate2D *)malloc(pointCount * sizeof(CLLocationCoordinate2D));
    
    for (int i = 0; i < pointCount; ++i) {
        CLLocation *location = [locationArray objectAtIndex:i];
        coordinateArray[i] = [location coordinate];
    }
    
    self.routeLine = [MGLPolyline polylineWithCoordinates:coordinateArray count:pointCount];
    [self.mapView addOverlay:self.routeLine];
    
    free(coordinateArray);
    coordinateArray = NULL;
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
    [_makelineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-10);
        
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

- (void)tap:(UITapGestureRecognizer *)tapGesture{
    if (self.isMakeLine == NO) {
        CGPoint tapPoint = [_mapView anchorPointForGesture:tapGesture];
        
        CLLocationCoordinate2D touchCoordinate = [self.mapView convertPoint:tapPoint toCoordinateFromView:_mapView];
        MGLPointAnnotation *pointAnnotation = [[MGLPointAnnotation alloc] init];
        pointAnnotation.coordinate = touchCoordinate;
        pointAnnotation.title = @"shadiao";
        pointAnnotation.subtitle = @"zhizhang";
        
        [_mapView addAnnotation:pointAnnotation];
    }else{
        CGPoint tapPoint = [_mapView anchorPointForGesture:tapGesture];
        
        CLLocationCoordinate2D touchCoordinate = [self.mapView convertPoint:tapPoint toCoordinateFromView:_mapView];
        CLLocation *location = [[CLLocation alloc] initWithLatitude:touchCoordinate.latitude longitude:touchCoordinate.longitude];
        [self.lineArr addObject:location];
        if (_lineArr.count == 2) {
            [self drawLineWithLocationArray:_lineArr];
            [_lineArr removeAllObjects];
            self.isMakeLine = NO;
        }
      
    }
    
}

#pragma mark set/get
- (MGLMapView *)mapView{
    if (!_mapView) {
        _mapView = [[MGLMapView alloc] init];
        _mapView.showsUserLocation = true;
        _mapView.delegate = self;
        _mapView.logoView.hidden = true;
        _mapView.attributionButton.hidden = true;
        
        [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(45.5076, -122.6736)
                                zoomLevel:11
                                 animated:NO];

        _mapView.styleURL = [MGLStyle streetsStyleURLWithVersion:MGLStyleDefaultVersion];
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
-(UIButton *)makelineBtn{
    if (!_makelineBtn) {
        _makelineBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_makelineBtn setTitle:@"画直线" forState:UIControlStateNormal];
        [_makelineBtn setBackgroundColor:[UIColor colorWithHexString:@"#4588F5"]];
        [_makelineBtn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
        [_makelineBtn addTarget:self action:@selector(makeline) forControlEvents:UIControlEventTouchUpInside];
    }
    return _makelineBtn;
}
-(NSMutableArray *)lineArr{
    if (!_lineArr) {
        _lineArr = [[NSMutableArray alloc]init];
    }
    return _lineArr;
}
@end
