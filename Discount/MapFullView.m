//
//  MapFullView.m
//  Discount
//
//  Created by Sajith KG on 20/02/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "MapFullView.h"
#import "AppDelegate.h"
#import "DiscountNow.h"

@interface MapFullView () {

    NSMutableArray *allAnnotations;
}

@end

@implementation MapFullView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger) supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = TOPBAR_BG_COLOR;
    
    self.titleLbl.font = LATO_REGULAR(20);
    self.cancelBtn.titleLabel.font = LATO_BOLD(16);
    self.directionBtn.titleLabel.font = LATO_BOLD(16);
    
    [self updateMap];
    
    allAnnotations=[[NSMutableArray alloc] init];
    self.mkMapView.mapType = MKMapTypeStandard;
    
    [self addAnnotationsOverMap];
}


- (IBAction)cancelBtnTapped:(id)sender {
    
    [MY_APP_DELEGATE.rootVC dismissViewControllerAnimated:YES completion:nil];
    
}


-(IBAction)directionBtnCall:(id)sender {

    Class mapItemClass = [MKMapItem class];
    if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)])
    {
        CLLocationCoordinate2D endingCoord = CLLocationCoordinate2DMake([[self.currentItem objectForKey:@"latitude"] floatValue], [[self.currentItem objectForKey:@"longitude"] floatValue]);
        MKPlacemark *endLocation = [[MKPlacemark alloc] initWithCoordinate:endingCoord addressDictionary:nil];
        MKMapItem *endingItem = [[MKMapItem alloc] initWithPlacemark:endLocation];
        [endingItem setName:[self.currentItem objectForKey:@"companyName"]];
        
        NSMutableDictionary *launchOptions = [[NSMutableDictionary alloc] init];
        [launchOptions setObject:MKLaunchOptionsDirectionsModeDriving forKey:MKLaunchOptionsDirectionsModeKey];
        
        [endingItem openInMapsWithLaunchOptions:launchOptions];
    }
 
}

#pragma mark -
#pragma mark  MAP

- (void) updateMap {
    
    MKCoordinateSpan span;
    span.latitudeDelta=0.05;
    span.longitudeDelta=0.05;
    MKCoordinateRegion region;
    region.span=span;
    region.center=CLLocationCoordinate2DMake([[self.currentItem objectForKey:@"latitude"] floatValue], [[self.currentItem objectForKey:@"longitude"] floatValue]);
    [self.mkMapView setRegion:region animated:YES];
    [self.mkMapView regionThatFits:region];
}

#pragma mark Add annotations

- (void) addAnnotationsOverMap {

    [self.mkMapView removeAnnotations:allAnnotations];
    [allAnnotations removeAllObjects];
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [[self.currentItem objectForKey:@"latitude"] floatValue];
    coordinate.longitude = [[self.currentItem objectForKey:@"longitude"] floatValue];
    
    MyLocation *myLocation = [[MyLocation alloc] initWithCoordinate:coordinate andTag:[NSString stringWithFormat:@"0"] andName:[self.currentItem objectForKey:@"companyName"] andSubName:[self.currentItem objectForKey:@"discountTitle"]];
    [allAnnotations addObject:myLocation];
    
    //NSLog(@"allAnnotations=%@",allAnnotations);
    
    [self.mkMapView addAnnotations:allAnnotations];
    [self.mkMapView setDelegate:self];
}

#pragma mark -
#pragma mark MapView delegate

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    MKAnnotationView *pinView = nil;
    MyLocation *location = (MyLocation *) annotation;
    if(annotation != mapView.userLocation)
    {
        if([annotation isKindOfClass:[MyLocation class]]) {
            
            static NSString *defaultPinID = @"groupPin";
            pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
            
            if (pinView == nil ) {
                pinView = [[MKAnnotationView alloc]
                           initWithAnnotation:annotation reuseIdentifier:defaultPinID];
                
                //                pinView.image = [UIImage imageNamed:@"map_pin.png"];
                
                MyLocation *current = (MyLocation*) annotation;
                UIImage *pinImage = [UIImage imageNamed:[self.currentItem objectForKey:@"pinType"]];
                pinView.image = pinImage;
                
                UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
                //rightButton.backgroundColor = [UIColor redColor];
                
                if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7")) {
                    rightButton.frame=CGRectMake(0, 0, 40, 44);
                    [rightButton setImage:[UIImage imageNamed:@"map_arrow.png"] forState:UIControlStateNormal];
                    [rightButton setImage:[UIImage imageNamed:@"map_arrow.png"] forState:UIControlStateHighlighted];
                }else {
                    rightButton.frame=CGRectMake(0, 0, 44, 32);
                    [rightButton setImage:[UIImage imageNamed:@"map_arrow.png"] forState:UIControlStateNormal];
                    [rightButton setImage:[UIImage imageNamed:@"map_arrow.png"] forState:UIControlStateHighlighted];
                }
                
                rightButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                
                
                [rightButton setContentMode:UIViewContentModeScaleAspectFit];
                pinView.rightCalloutAccessoryView = rightButton;
                pinView.calloutOffset = CGPointMake(-3, 3);
                pinView.canShowCallout = YES;
                
                rightButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                
                
                [rightButton setContentMode:UIViewContentModeScaleAspectFit];
                pinView.rightCalloutAccessoryView = rightButton;
                pinView.calloutOffset = CGPointMake(-3, 3);
                pinView.canShowCallout = YES;
            }
            
            pinView.rightCalloutAccessoryView.tag = [location.Id intValue];
        }
    }
    
    return pinView;
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    MKAnnotationView *aV;
    
    for (aV in views) {
        
        // Don't pin drop if annotation is user location
        if ([aV.annotation isKindOfClass:[MKUserLocation class]]) {
            continue;
        }
        
        // Check if current annotation is inside visible map rect, else go to next one
        MKMapPoint point =  MKMapPointForCoordinate(aV.annotation.coordinate);
        if (!MKMapRectContainsPoint(self.mkMapView.visibleMapRect, point)) {
            continue;
        }
        
        CGRect endFrame = aV.frame;
        
        // Move annotation out of view
        aV.frame = CGRectMake(aV.frame.origin.x, aV.frame.origin.y - self.view.frame.size.height, aV.frame.size.width, aV.frame.size.height);
        
        // Animate drop
        [UIView animateWithDuration:0.5 delay:0.04*[views indexOfObject:aV] options:UIViewAnimationOptionCurveLinear animations:^{
            
            aV.frame = endFrame;
            
            // Animate squash
        }completion:^(BOOL finished){
            if (finished) {
                [UIView animateWithDuration:0.05 animations:^{
                    aV.transform = CGAffineTransformMakeScale(1.0, 0.8);
                    
                }completion:^(BOOL finished){
                    [UIView animateWithDuration:0.1 animations:^{
                        aV.transform = CGAffineTransformIdentity;
                    }];
                }];
            }
        }];
    }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    
    if (self.handler) {
        
        if ([self.handler respondsToSelector:@selector(showDiscountDetails)]) {
            [self.handler performSelector:@selector(showDiscountDetails)];
        }
    }
    
    [self cancelBtnTapped:nil];
    
}

@end
