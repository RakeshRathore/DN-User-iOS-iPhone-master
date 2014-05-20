//
//  Home.h
//  Discount
//
//  Created by Sajith KG on 13/02/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MyLocation.h"

@interface Map : UIViewController<MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *myMapView;

@property (strong, nonatomic) IBOutlet UILabel *titleLbl;
@property (nonatomic, strong) IBOutlet UIView *topbarView;

@property (strong, nonatomic) NSMutableArray *itemsArray;


- (void) updateAnnotations;

@end
