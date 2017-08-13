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
#import "AnnotationV.h"

@interface MapMainViewController ()<MGLMapViewDelegate,MGLAnnotation>

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
    self.mapView.delegate = self;
    
    [self initConstraints];
    [self addAnnotationCoordinate];

    UITapGestureRecognizer *tap =  [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(currentP:)];
   
    [self.mapView addGestureRecognizer:tap];

}
-(void)polyline{
    
    
}
//点击增加大头针
-(void)currentP:(UITapGestureRecognizer *)tap{
    CGPoint p = [self.mapView anchorPointForGesture:tap];
    NSLog(@"%@,%@",tap,[NSValue valueWithCGPoint:p]);
  CLLocationCoordinate2D lop =   [self.mapView convertPoint:p toCoordinateFromView:self.mapView];
    NSLog(@"%@",[NSValue valueWithMGLCoordinate:lop ]);
    MGLPointAnnotation *annocup = [[MGLPointAnnotation alloc]init];
    annocup.coordinate = lop ;
    [self.mapView addAnnotation:annocup];
}

-(void)addAnnotationCoordinate{
   
   // anno.frame = CGRectMake(0, 0, 100, 100);
//    anno.backgroundColor = [UIColor blueColor];
//    [anno setDragState:MGLAnnotationViewDragStateDragging animated:YES];
//    anno.centerOffset =   CGVectorMake(0.6, 0.8);
    MGLPointAnnotation *anno = [[MGLPointAnnotation alloc]init];
    anno.coordinate = CLLocationCoordinate2DMake(23, 113);
    MGLPointAnnotation *anno1 = [[MGLPointAnnotation alloc]init];
    anno1.coordinate = CLLocationCoordinate2DMake(24, 113);
    [self.mapView addAnnotation:anno];
    [self.mapView addAnnotation:anno1];
  //  [[MGLSource alloc]initWithSourceIdentifier:@"source"];
  
   CLLocationCoordinate2D l1 = CLLocationCoordinate2DMake(23,114);
    CLLocationCoordinate2D l2 =CLLocationCoordinate2DMake(23, 115);
//   NSArray *pointarr= [NSArray arrayWithObjects:(__bridge id _Nonnull)(&l1),&l2, nil];
     MGLPolygon *polygon1 = [MGLPolygon polygonWithCoordinates:&l1 count:1];
     MGLPolygon *polygon2 = [MGLPolygon polygonWithCoordinates:&l2 count:1];
  NSArray *polygonArr=  [NSArray arrayWithObjects:polygon1, polygon2,nil];
 //   NSArray *clcoorArr = [NSArray arrayWithObjects:&l1,&l2, nil];
   MGLMultiPolyline *mulipolyLine = [MGLMultiPolyline multiPolylineWithPolylines:polygonArr];
//    for (MGLPolygon lc in polygonArr) {
//        <#statements#>
//    }
    MGLPolyline *polyLine = [MGLPolyline polylineWithCoordinates:(__bridge CLLocationCoordinate2D * _Nonnull)(polygon1) count:1];
    
    [self.mapView addOverlay:polyLine];
   // [self.mapView.annotations arrayByAddingObject:anno];
  
}

-(UIColor *)mapView:(MGLMapView *)mapView strokeColorForShapeAnnotation:(MGLShape *)annotation{
    
    return [UIColor greenColor];
}
-(CGFloat)mapView:(MGLMapView *)mapView lineWidthForPolylineAnnotation:(MGLPolyline *)annotation{
    NSLog(@"%@",annotation);
    return 100.0;
}
//-(MGLAnnotationImage *)mapView:(MGLMapView *)mapView imageForAnnotation:(id<MGLAnnotation>)annotation{
//     MGLAnnotationImage *anno = [MGLAnnotationImage annotationImageWithImage:[UIImage imageNamed:@"anno"] reuseIdentifier:@"reust"];
//    return anno;
//}
//-(MGLAnnotationView *)mapView:(MGLMapView *)mapView viewForAnnotation:(id<MGLAnnotation>)annotation{
//    
//    AnnotationV *annoV = [[AnnotationV alloc]initWithReuseIdentifier:@"annotationV"];
//    annoV.frame= CGRectMake(0, 0, 100, 100);
//    annoV.backgroundColor = [UIColor greenColor];
//   
//    [annoV setDragState:MGLAnnotationViewDragStateStarting animated:YES];
////    [self addAnnotationCoordinate];
//    return annoV;
//}
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
//- (nullable MGLAnnotationView *)mapView:(nonnull MGLMapView *)mapView
//                      viewForAnnotation:(nonnull id<MGLAnnotation>)annotation{
//  
////    MGLAnnotationView *annotationview = [[MGLAnnotationView alloc]initWithReuseIdentifier:@"annotation"];
//    
//    NSLog(@"%f,%f",annotation.coordinate.latitude,annotation.coordinate.longitude);
////    MGLPointAnnotation *anno = [[MGLPointAnnotation alloc]init];
////    anno.coordinate = CLLocationCoordinate2DMake(23, 113);
////    MGLAnnotationView *annoV = [self.mapView viewForAnnotation:anno];
////    [self.mapView addAnnotation:anno];
//    return nil;
//}


- (void)mapView:(nonnull MGLMapView *)mapView
didAddAnnotationViews:
(nonnull NSArray<MGLAnnotationView *> *)annotationViews{
    NSLog(@"didadd");
}
- (void)mapView:(nonnull MGLMapView *)mapView
tapOnCalloutForAnnotation:(nonnull id<MGLAnnotation>)annotation{
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  
    NSLog(@"touch");
}
@end
