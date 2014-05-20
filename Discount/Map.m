//
//  Home.m
//  Discount
//
//  Created by Sajith KG on 13/02/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "Map.h"
#import "AppDelegate.h"
#import "DiscountDetail.h"
#import "DiscountViewController.h"
#import "FavoriteDetail.h"

@interface Map (){

    NSMutableArray *allAnnotations;
    DiscountViewController *discountViewController;
}

@end

@implementation Map

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

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.topbarView.backgroundColor = TOPBAR_BG_COLOR;
    self.titleLbl.font = LATO_REGULAR(16);
    
    self.myMapView.mapType = MKMapTypeStandard;
    [self updateMap];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    discountViewController = (DiscountViewController*) MY_APP_DELEGATE.discountViewController;
    
}

- (void) updateAnnotations {
    
    [self view];
    
    discountViewController = (DiscountViewController*) MY_APP_DELEGATE.discountViewController;

    if (!allAnnotations) {
        allAnnotations=[[NSMutableArray alloc] init];
    }
    
    DLog(@"self.itemsArray %@",self.itemsArray);
    
    [self addAnnotationsOverMap];
}


#pragma mark -
#pragma mark MAP

#pragma mark Add annotations

- (void) updateMap {
    
    MKCoordinateSpan span;
    //    span.latitudeDelta=0.5;
    //    span.longitudeDelta=0.5;
    span.latitudeDelta=1;
    span.longitudeDelta=1;
    MKCoordinateRegion region;
    region.span=span;
    region.center=CLLocationCoordinate2DMake(41.5255, -87.3740);
    [self.myMapView setRegion:region animated:YES];
    [self.myMapView regionThatFits:region];
}

- (void) addAnnotationsOverMap {
    
    //[itemsArray removeAllObjects];  // webservice
    
    [self.myMapView removeAnnotations:allAnnotations];
    [allAnnotations removeAllObjects];
    
    for (int i=0;i<[self.itemsArray count];i++) {
        
        NSMutableDictionary *currentDict = [self.itemsArray objectAtIndex:i];
        
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = [[currentDict objectForKey:@"latitude"] floatValue];
        coordinate.longitude = [[currentDict objectForKey:@"longitude"] floatValue];
        
//        MyLocation *myLocation = [[MyLocation alloc] initWithCoordinate:coordinate andTag:[NSString stringWithFormat:@"%d",i] andName:[currentDict objectForKey:@"discountTitle"] andSubName:[currentDict objectForKey:@"whatsIncluded"]];
        
        MyLocation *myLocation = [[MyLocation alloc] initWithCoordinate:coordinate andTag:[NSString stringWithFormat:@"%d",i] andName:[NSString stringWithFormat:@"%@ (5)",[currentDict objectForKey:@"companyName"]] andSubName:[currentDict objectForKey:@""]];
        
        [allAnnotations addObject:myLocation];
    }
    
    [self.myMapView addAnnotations:allAnnotations];
}

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
                
                MyLocation *current = (MyLocation*) annotation;
                UIImage *pinImage = [UIImage imageNamed:[[self.itemsArray objectAtIndex:[current.Id intValue]] objectForKey:@"pinType"]];
                pinView.image = pinImage;
                
                UIImageView *leftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Burger.jpg"]];
                leftImage.frame=CGRectMake(4, 4, 40, 36);
                leftImage.contentMode = UIViewContentModeScaleAspectFill;
                leftImage.clipsToBounds=YES;
                pinView.leftCalloutAccessoryView = leftImage;
                
                
                UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
                
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
            }
            
            pinView.rightCalloutAccessoryView.tag = [location.Id intValue];
            
            UIView *view =[[UIView alloc] init];
            view.backgroundColor = RGB(255, 59, 48);
            view.frame = CGRectMake(30, 0, 16, 16);
            view.layer.cornerRadius=8;
            view.layer.borderColor = [UIColor whiteColor].CGColor;
            view.layer.borderWidth = 0.4;
            
            UILabel *badgeLbl = [[UILabel alloc] initWithFrame:view.bounds];
            badgeLbl.text = [NSString stringWithFormat:@"%d",arc4random_uniform(20)];
            badgeLbl.textColor = [UIColor whiteColor];
            badgeLbl.textAlignment = NSTextAlignmentCenter;
            badgeLbl.font = LATO_BOLD(12);
            badgeLbl.layer.cornerRadius=8;
            badgeLbl.layer.borderColor = [UIColor clearColor].CGColor;
            badgeLbl.layer.borderWidth = 0.4;
            [view addSubview:badgeLbl];
            
            [pinView addSubview:view];
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
        if (!MKMapRectContainsPoint(self.myMapView.visibleMapRect, point)) {
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
    
    [self pushDetailView:(int)control.tag];
}

- (void) pushDetailView :(int) index {
    
    [discountViewController showBackButton:YES];
    
    FavoriteDetail *favoriteDetail = [[FavoriteDetail alloc] init];
    favoriteDetail.isFavoriteMode=NO;
    favoriteDetail.hidesBottomBarWhenPushed=NO;
    [self.navigationController pushViewController:favoriteDetail animated:YES];
    
 
    
}

@end
