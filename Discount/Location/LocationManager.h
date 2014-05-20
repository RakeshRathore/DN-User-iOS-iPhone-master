//
//  LocationManager.h
//  SWAP
//
//  Created by Sajith KG on 19/06/13.
//  Copyright (c) 2013 Sajith KG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface LocationManager : NSObject <CLLocationManagerDelegate> {

    CLLocationManager *locationManager;
}

@property (nonatomic,copy) NSString *latitude,*longitude;

+ (id)sharedLocationManager;
- (void) clearLocationData;
- (BOOL) checkLocationSettings;
- (BOOL) checkLocationString;
- (void) startUpdateLocation;

- (NSString *)latitude;
- (NSString *)longitude;

@end
