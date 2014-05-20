//
//  LocationManager.m
//  SWAP
//
//  Created by Sajith KG on 19/06/13.
//  Copyright (c) 2013 Sajith KG. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager

+ (id)sharedLocationManager {
    
    static LocationManager *sharedMyLocationManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyLocationManager = [[self alloc] init];
    });
    return sharedMyLocationManager;
}

- (void) clearLocationData {

    _latitude=@"";
    _longitude=@"";
}

/*****************   Location  *******************/

- (BOOL) checkLocationSettings {
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized) {
        [self startUpdateLocation];
        return YES;;
    }else {
        [self clearLocationData];
        return NO;
    }
}

- (BOOL) checkLocationString {
    
//    NSLog(@"checkLocationString self.latitude=%@",self.latitude);
    
    if ([self.latitude length] || [self.longitude length]) {
        return YES;
    }
    return NO;
}

-(void) startUpdateLocation {
    
//    NSLog(@"startUpdateLocation %@ %@",self.latitude,self.longitude);
    
    if ([self.latitude length] || [self.longitude length]) {
        return;
    }
    
    if (locationManager) {
        locationManager=nil;
    }
    
//    NSLog(@"locationServicesEnabled %d",[CLLocationManager locationServicesEnabled]);
//    NSLog(@"authorizationStatus %d",[CLLocationManager authorizationStatus]);
    
    if ([CLLocationManager locationServicesEnabled]) {
        
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        [locationManager startUpdatingLocation];
    }else {
        
//        NSLog(@"locationServicesEnabled else");
        
        _latitude=@"";
        _longitude=@"";
    }
}

#pragma mark -
#pragma mark CLLocationManager delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {  // < ios 6
    
//    NSLog(@"newLocation %@",newLocation);
    
    _latitude=[[NSString stringWithFormat:@"%f",newLocation.coordinate.latitude] copy];
    _longitude=[[NSString stringWithFormat:@"%f",newLocation.coordinate.longitude] copy];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:locationUpdate object:nil];
    
    [locationManager stopUpdatingLocation];
    locationManager.delegate=nil;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {  // ios 6
    
//    NSLog(@"locationManager didUpdateLocations %@",locations);
    
    CLLocation* location = [locations lastObject];
    
    _latitude=[[NSString stringWithFormat:@"%f",location.coordinate.latitude] copy];
    _longitude=[[NSString stringWithFormat:@"%f",location.coordinate.longitude] copy];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:locationUpdate object:nil];
    
    [locationManager stopUpdatingLocation];
    locationManager.delegate=nil;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	
    [locationManager stopUpdatingLocation];
    locationManager.delegate=nil;
    
//    NSLog(@"locationManager didFailWithError=%@",error);
    _latitude=@"";
    _longitude=@"";
    
    [Loading showErrorWithStatus:error.localizedDescription];
}

@end
