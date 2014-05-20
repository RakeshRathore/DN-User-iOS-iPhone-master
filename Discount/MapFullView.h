//
//  MapFullView.h
//  Discount
//
//  Created by Sajith KG on 20/02/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MyLocation.h"

@interface MapFullView : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mkMapView;
@property (strong, nonatomic) NSDictionary *currentItem;

@property (strong, nonatomic) IBOutlet UILabel *titleLbl;

@property (strong, nonatomic) IBOutlet UIButton *cancelBtn,*directionBtn;

@property (assign) NSObject *handler;

@end
