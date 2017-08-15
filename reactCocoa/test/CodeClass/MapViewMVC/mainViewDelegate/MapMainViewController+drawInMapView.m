//
//  MapMainViewController+drawInMapView.m
//  test
//
//  Created by zzc-13 on 2017/8/13.
//  Copyright © 2017年 bigiron. All rights reserved.
//

#import "MapMainViewController+drawInMapView.h"

@implementation MapMainViewController (drawInMapView)

- (void)drawPolyline {
    // Perform GeoJSON parsing on a background thread
    dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(backgroundQueue, ^(void) {
        // Get the path for example.geojson in the app's bundle
        NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"example" ofType:@"geojson"];
        
        // Convert the file contents to a shape collection feature object
        NSData *data = [[NSData alloc] initWithContentsOfFile:jsonPath];
        MGLShapeCollectionFeature *shapeCollectionFeature = (MGLShapeCollectionFeature *)[MGLShape shapeWithData:data encoding:NSUTF8StringEncoding error:NULL];
        
        MGLPolylineFeature *polyline = (MGLPolylineFeature *)shapeCollectionFeature.shapes.firstObject;
        
        // Optionally set the title of the polyline, which can be used for:
        //  - Callout view
        //  - Object identification
        // In this case, set it to the name included in the GeoJSON
        polyline.title = polyline.attributes[@"name"]; // "Crema to Council Crest"
        
        // Add the polyline to the map, back on the main thread
        // Use weak reference to self to prevent retain cycle
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [weakSelf.mapView addAnnotation:polyline];
        });
    });
}

- (CGFloat)mapView:(MGLMapView *)mapView alphaForShapeAnnotation:(MGLShape *)annotation {
    // Set the alpha for all shape annotations to 1 (full opacity)
    return 1.0f;
}

- (CGFloat)mapView:(MGLMapView *)mapView lineWidthForPolylineAnnotation:(MGLPolyline *)annotation {
    // Set the line width for polyline annotations
    return 10.0f;
}
-(UIColor *)mapView:(MGLMapView *)mapView strokeColorForShapeAnnotation:(MGLShape *)annotation{
    return [UIColor grayColor];
}
<<<<<<< HEAD
=======

>>>>>>> e9488e3bd5aac5849fd24175b3860f7817c8884a
//- (UIColor *)mapView:(MGLMapView *)mapView strokeColorForShapeAnnotation:(MGLShape *)annotation {
//    // Set the stroke color for shape annotations
//    // ... but give our polyline a unique color by checking for its `title` property
//    if ([annotation.title isEqualToString:@"Crema to Council Crest"]) {
//        // Mapbox cyan
//        return [UIColor colorWithRed:59.0f/255.0f green:178.0f/255.0f blue:208.0f/255.0f alpha:1.0f];
//    } else {
//        return [UIColor redColor];
//    }
//}

@end
