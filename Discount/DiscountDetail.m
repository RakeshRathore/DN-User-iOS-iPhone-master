//
//  DiscountDetail.m
//  Discount
//
//  Created by Jason Merchant on 1/13/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "DiscountDetail.h"
#import "MediaCell.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import "DiscountViewController.h"
#import "YoutubeParser.h"
#import "video.h"
#import "UILabel+Boldify.h"
#import "SavedDiscount.h"

@interface UIView (PrivateMethods)
+ (void)setAnimationPosition:(CGPoint)point;
@end

@interface DiscountDetail () {

    NSMutableArray *itemsArray;
    NSMutableArray *allAnnotations;
    NSMutableArray *mediaArray;
    int currentPage;
    
    NSString *companyName;
}

@end

@implementation DiscountDetail


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    self.bottomView.frame = CGRectMake(0, self.view.frame.size.height, self.bottomView.frame.size.width, self.bottomView.frame.size.height);
    
    [UIView animateWithDuration:0.6
                     animations:^{
                          self.bottomView.frame = CGRectMake(0, self.view.frame.size.height - self.bottomView.frame.size.height, self.bottomView.frame.size.width, self.bottomView.frame.size.height);
                         
                     }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.myScrollView addSubview:self.scrollContentView];
    [self.myScrollView setContentSize:CGSizeMake(320, self.scrollContentView.frame.size.height)];
    
    self.view.backgroundColor = VIEW_BG_COLOR;
    self.myScrollView.backgroundColor = DETAIL_BG_COLOR;
    self.topbarView.backgroundColor = TOPBAR_BG_COLOR;
    self.bottomView.backgroundColor = TOPBAR_BG_COLOR;
    self.captureBtn.backgroundColor = TOPBAR_BG_COLOR;
    
    self.lineTop.backgroundColor = RGB(30, 57, 77);
    self.lineMiddle.backgroundColor = RGB(30, 57, 77);
    self.lineBottom.backgroundColor = RGB(30, 57, 77);
    
    self.titleLbl.font = LATO_REGULAR(18);
    
    if (self.isSavedDeal)
        [self.captureBtn setTitle:@"Cash It In!" forState:0];
    else
        [self.captureBtn setTitle:@"Got Dibs!" forState:0];
    
    [self.captureBtn.titleLabel setFont:LATO_BOLD(16)];
    
    self.priceLbl.font = LATO_REGULAR(24);
    self.daysLbl.font = LATO_REGULAR(13);
    
    self.itemTitleLbl.font = LATO_BOLD(18);
    self.itemDiscountLbl.font = LATO_BOLD(14);
    self.itemOfferLbl.font = LATO_BOLD(14);
    
    self.priceLbl.backgroundColor = [UIColor whiteColor];
    self.priceLbl.textColor = [UIColor blackColor];
    self.priceLbl.layer.cornerRadius = 2;
    self.priceLbl.clipsToBounds = YES;
    
    self.addressLbl.font = LATO_REGULAR(12);
    self.openTimeLbl.font = LATO_REGULAR(12);
    
    self.whatsIncludedHdr.textColor = TOPBAR_BG_COLOR;
    self.businessName.textColor = TOPBAR_BG_COLOR;
    self.locationHdr.textColor = TOPBAR_BG_COLOR;
    
    self.whatsIncludedHdr.font = LATO_BOLD(15);
    self.locationHdr.font = LATO_BOLD(15);
    self.businessName.font = LATO_BOLD(15);
    
    self.whatsIncludedValue.font = LATO_REGULAR(14);
    self.locationValue.font = LATO_REGULAR(14);
    self.businessDetails.font = LATO_REGULAR(14);
    
    self.mapTitle.titleLabel.font = LATO_BOLD(13);
    
    self.distanceLbl.font =LATO_BOLD(14);
    
    allAnnotations=[[NSMutableArray alloc] init];
    itemsArray=[[NSMutableArray alloc] init];
    
    mediaArray=[[NSMutableArray alloc] initWithObjects:@"bbq1.jpg",@"bbq2.jpg",@"bbq3.jpg",nil];
    
    companyName = [self.currentItem objectForKey:@"companyName"];
    
    if([companyName  isEqual: @"Voodoo BBQ"]){
        mediaArray=[[NSMutableArray alloc] initWithObjects:@"bbq1.jpg",@"bbq2.jpg",@"bbq3.jpg",nil];
        
    }
    else if ([companyName  isEqual: @"Caldera Resorts"]){
        mediaArray=[[NSMutableArray alloc] initWithObjects:@"beach1.jpg",@"beach2.jpg",nil];
        
    }
    else if ([companyName  isEqual: @"Molly Green"]){
        mediaArray=[[NSMutableArray alloc] initWithObjects:@"store1.jpg",@"store2.jpg",nil];
        
    }else if ([companyName  isEqual: @"Voodoo-BBQ"]){
        mediaArray=[[NSMutableArray alloc] initWithObjects:@"bbqd1.png",@"bbqd2.png",@"bbqd3.png",nil];
        
    }
    
    
    self.mkMapView.mapType = MKMapTypeStandard;

    [self addAnnotationsOverMap];
    
//    DLog(@"%@",self.currentItem);
    
    self.daysLbl.text = [NSString stringWithFormat:@"%@ left!",[[self.currentItem objectForKey:@"Expiration"] lowercaseString]];
    self.priceLbl.text = [NSString stringWithFormat:@"$%@",[self.currentItem objectForKey:@"discountPrice"]];
    
    self.itemTitleLbl.text = [self.currentItem objectForKey:@"discountTitle"];
    
    self.itemDiscountLbl.text = [NSString stringWithFormat:@"$%@ for $%@",[self.currentItem objectForKey:@"discountPrice"],[self.currentItem objectForKey:@"originalPrice"]];
    
    self.itemOfferLbl.text = [NSString stringWithFormat:@"%@ off at %@",[self.currentItem objectForKey:@"percentageSavings"],[self.currentItem objectForKey:@"companyName"]];
    
    //[self.itemPic setImage:[UIImage imageNamed:[self.currentItem objectForKey:@"imageURL"]]];
    
    self.addressLbl.text = [NSString stringWithFormat:@"%@ \n%@, %@ ",[self.currentItem objectForKey:@"companyName"],[self.currentItem objectForKey:@"city"],[self.currentItem objectForKey:@"state"]];
    
    if ([[self.currentItem objectForKey:@"phoneNo"] length]) {
        
        self.addressLbl.text = [NSString stringWithFormat:@"%@ \n%@",self.addressLbl.text,[self.currentItem objectForKey:@"phoneNo"]];
        
        self.phoneBtn = [[UIButton alloc] init];
        [self.phoneBtn setBackgroundColor:[UIColor clearColor]];
        [self.phoneBtn addTarget:self action:@selector(phoneBtnCall:) forControlEvents:UIControlEventTouchUpInside];
        [self.informationView addSubview:self.phoneBtn];
    }
    
    
//    self.openTimeLbl.text = [NSString stringWithFormat:@"%@ \n%@, %@ \n%@",[self.currentItem objectForKey:@"companyName"],[self.currentItem objectForKey:@"city"],[self.currentItem objectForKey:@"state"],[self.currentItem objectForKey:@"zip"]];
    
    self.openTimeLbl.text = [NSString stringWithFormat:@"M  8-11pm \nW  9-11pm \nF  10-11pm \nSa & Su  9-11pm"];
    
    [self.openTimeLbl boldSubstring: @"M"];
    [self.openTimeLbl boldSubstring: @"W"];
    [self.openTimeLbl boldSubstring: @"F"];
    [self.openTimeLbl boldSubstring: @"Sa & Su"];
    
    self.whatsIncludedValue.text = [self.currentItem objectForKey:@"whatsIncluded"];
    
    self.locationValue.text = [NSString stringWithFormat:@"%@ \n%@, %@ \n%@",[self.currentItem objectForKey:@"address"],[self.currentItem objectForKey:@"city"],[self.currentItem objectForKey:@"state"],[self.currentItem objectForKey:@"zip"]];
    
    [self.mapTitle setTitle:[NSString stringWithFormat:@"%@, %@",[self.currentItem objectForKey:@"city"],[self.currentItem objectForKey:@"state"]] forState:0];
    [self.mapTitle setTitle:[NSString stringWithFormat:@"%@, %@",[self.currentItem objectForKey:@"city"],[self.currentItem objectForKey:@"state"]] forState:UIControlStateHighlighted];
    
    self.businessName.text = [self.currentItem objectForKey:@"companyName"];
    
    self.businessDetails.text = [self.currentItem objectForKey:@"description"];
    
    [self resetScrollViewHeight];
    
    [self.favoriteBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.shareBtn.imageView setContentMode:UIViewContentModeScaleAspectFill];
    
    self.pictureTable.showsVerticalScrollIndicator = NO;
    self.pictureTable.transform=CGAffineTransformMakeRotation(-M_PI/2);
    self.pictureTable.rowHeight = 320;
    self.pictureTable.pagingEnabled=YES;
    self.pictureTable.frame= CGRectMake(0, 0, 320, 193);

    [self.pictureTable reloadData];
    [self updatePreviousNextBtnStatus:0];
    
    [self.favoriteBtn setImage:[UIImage imageNamed:@"favorite.png"] forState:UIControlStateNormal];
    [self.favoriteBtn setImage:[UIImage imageNamed:@"favorite_sel.png"] forState:UIControlStateSelected];
    [self.favoriteBtn setImage:[UIImage imageNamed:@"favorite_sel.png"] forState:UIControlStateSelected | UIControlStateHighlighted];
    
    self.bottomView.frame = CGRectMake(0, self.view.frame.size.height, self.bottomView.frame.size.width, self.bottomView.frame.size.height);

    self.favoriteBtn.selected=NO;
}

- (void) resetScrollViewHeight {
    
    // Information
    
    [self.itemTitleLbl setFrame:CGRectMake(self.itemTitleLbl.frame.origin.x, self.itemTitleLbl.frame.origin.y, self.itemTitleLbl.frame.size.width, [self.itemTitleLbl sizeThatFits:CGSizeMake(self.itemTitleLbl.frame.size.width, CGFLOAT_MAX)].height)];
    
    // WhatsIncluded
    [self.whatsIncludedValue setFrame:CGRectMake(self.whatsIncludedValue.frame.origin.x, self.whatsIncludedValue.frame.origin.y, self.whatsIncludedValue.frame.size.width, [self.whatsIncludedValue sizeThatFits:CGSizeMake(self.whatsIncludedValue.frame.size.width, CGFLOAT_MAX)].height)];
    
    self.whatsIncludedView.frame = CGRectMake(self.whatsIncludedView.frame.origin.x, self.itemTitleLbl.frame.origin.y + self.itemTitleLbl.frame.size.height+10, self.whatsIncludedView.frame.size.width, self.whatsIncludedValue.frame.size.height+35);
    
    self.lineTop.frame = CGRectMake(self.lineTop.frame.origin.x, 0, self.lineTop.frame.size.width, 1);
    
    [self.addressLbl setFrame:CGRectMake(self.addressLbl.frame.origin.x, self.lineTop.frame.origin.y+self.lineTop.frame.size.height +5, self.addressLbl.frame.size.width, [self.addressLbl sizeThatFits:CGSizeMake(self.addressLbl.frame.size.width, CGFLOAT_MAX)].height)];
   
    
    if ([[self.currentItem objectForKey:@"phoneNo"] length]) {
        
        self.phoneBtn.frame = CGRectMake(0, self.addressLbl.frame.origin.y+self.addressLbl.frame.size.height-20, 150, 30);
    }
    
    
    [self.openTimeLbl setFrame:CGRectMake(self.openTimeLbl.frame.origin.x, self.lineTop.frame.origin.y+self.lineTop.frame.size.height +5, self.openTimeLbl.frame.size.width, [self.openTimeLbl sizeThatFits:CGSizeMake(self.openTimeLbl.frame.size.width, CGFLOAT_MAX)].height)];
    
    CGFloat textMaxHeight = self.addressLbl.frame.size.height;
    
    if (textMaxHeight < self.openTimeLbl.frame.size.height) {
        textMaxHeight = self.openTimeLbl.frame.size.height;
    }
    
    self.lineMiddle.frame = CGRectMake(self.lineMiddle.frame.origin.x,self.lineTop.frame.origin.y + 1, 1, textMaxHeight+10);
    
    self.lineBottom.frame = CGRectMake(self.lineBottom.frame.origin.x,self.lineTop.frame.origin.y + textMaxHeight +11, self.lineBottom.frame.size.width, 1);
    
    self.informationView.frame = CGRectMake(self.informationView.frame.origin.x,self.whatsIncludedView.frame.origin.y + self.whatsIncludedView.frame.size.height+10, self.informationView.frame.size.width, self.lineBottom.frame.origin.y +10);
    
    self.videoTable.frame = CGRectMake(self.videoTable.frame.origin.x, self.informationView.frame.origin.y + self.informationView.frame.size.height+10, self.videoTable.frame.size.width, self.videoTable.frame.size.height);
    
    [self.locationValue setFrame:CGRectMake(self.locationValue.frame.origin.x, self.locationValue.frame.origin.y, self.locationValue.frame.size.width, [self.locationValue sizeThatFits:CGSizeMake(self.locationValue.frame.size.width, CGFLOAT_MAX)].height)];
    
    self.locationView.frame = CGRectMake(self.locationView.frame.origin.x, self.videoTable.frame.origin.y + self.videoTable.frame.size.height +15, self.locationView.frame.size.width, self.locationValue.frame.size.height+35);
    
    self.distanceView.frame = CGRectMake(177, (self.locationView.frame.size.height - 30)/2, self.distanceView.frame.size.width, 30);
    
    self.mapView.frame = CGRectMake(self.mapView.frame.origin.x, self.locationView.frame.origin.y + self.locationView.frame.size.height +15, self.mapView.frame.size.width, self.mapView.frame.size.height);
    
    [self.businessDetails setFrame:CGRectMake(self.businessDetails.frame.origin.x, self.businessDetails.frame.origin.y, self.businessDetails.frame.size.width, [self.businessDetails sizeThatFits:CGSizeMake(self.businessDetails.frame.size.width, CGFLOAT_MAX)].height)];

    self.businessView.frame = CGRectMake(self.businessView.frame.origin.x, self.mapView.frame.origin.y + self.mapView.frame.size.height +20, self.businessView.frame.size.width, self.self.businessDetails.frame.size.height+35);
    
    self.scrollContentView.frame = CGRectMake(0, 0, self.businessView.frame.size.width, self.businessView.frame.origin.y + self.businessView.frame.size.height +60);

    [self.myScrollView setContentSize:CGSizeMake(320, self.scrollContentView.frame.size.height)];
    
    self.videoTable.showsVerticalScrollIndicator = NO;
    self.videoTable.transform=CGAffineTransformMakeRotation(-M_PI/2);
    self.videoTable.rowHeight = 320;
    self.videoTable.pagingEnabled=YES;
    self.videoTable.frame= CGRectMake(0, self.informationView.frame.origin.y + self.informationView.frame.size.height+10, 320, 175);
    [self.videoTable reloadData];
    
    [self updateMap];

}

#pragma mark -
#pragma mark  IBAction

#pragma mark  Phone
- (IBAction) phoneBtnCall:(UIButton*) sender {
    
    UIDevice *device = [UIDevice currentDevice];
    if ([[device model] isEqualToString:@"iPhone"] ) {
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]]) {
            
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirm"
                                                            message:[self.currentItem objectForKey:@"phoneNo"]
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Call",nil];
            alert.tag=1111;
            [alert show];

        }else {
        
             [Global showErrorWithMessage:@"Your can not make call now"];
        }
      
    } else {
        
        [Global showErrorWithMessage:@"Your device doesn't support this feature."];
    }
}

#pragma mark Alert

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex != alertView.cancelButtonIndex) {
        
        if (buttonIndex==1) {
            
            if (alertView.tag==1111) {  //logout
                
                //            NSString *PhoneNo = [[self.currentItem objectForKey:@"phoneNo"] stringByTrimmingCharactersInSet:
                //                                                 [NSCharacterSet whitespaceCharacterSet]];
                NSString *PhoneNo = [self.currentItem objectForKey:@"phoneNo"] ;
                
                PhoneNo = [PhoneNo stringByReplacingOccurrencesOfString:@" " withString:@"-"];
                PhoneNo = [PhoneNo stringByReplacingOccurrencesOfString:@"(" withString:@""];
                PhoneNo = [PhoneNo stringByReplacingOccurrencesOfString:@")" withString:@""];
                PhoneNo = [PhoneNo stringByReplacingOccurrencesOfString:@"-" withString:@""];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",PhoneNo]]];
            }
        }
    }
}

#pragma mark  Favorite

- (IBAction) favoriteBtnCall:(UIButton*) sender {
    
//    self.favoriteBtn.selected=!self.favoriteBtn.isSelected;
//    if (self.favoriteBtn.isSelected) {
//        
//        self.favoriteBtn.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
//        
//        [UIView animateWithDuration:0.3/1.5 animations:^{
//            self.favoriteBtn.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.3, 1.3);
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.3/2 animations:^{
//                self.favoriteBtn.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
//            } completion:^(BOOL finished) {
//                [UIView animateWithDuration:0.3/2 animations:^{
//                    self.favoriteBtn.transform = CGAffineTransformIdentity;
//                    
//                }];
//            }];
//        }];
//    }
    
    
    
    if (!self.favoriteBtn.isSelected) {
        
        self.favoriteBtn.selected=!self.favoriteBtn.isSelected;
        
        self.favoriteBtn.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
        
        [UIView animateWithDuration:0.3/1.5 animations:^{
            self.favoriteBtn.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.4, 1.4);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                self.favoriteBtn.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3/2 animations:^{
                    self.favoriteBtn.transform = CGAffineTransformIdentity;
                    
                }];
            }];
        }];
    }else {
        
        self.favoriteBtn.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0 , 1.0);
        
        [UIView animateWithDuration:0.3/1.5 animations:^{
            self.favoriteBtn.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
        } completion:^(BOOL finished) {
            self.favoriteBtn.selected=!self.favoriteBtn.isSelected;
            [UIView animateWithDuration:0.3/2 animations:^{
                self.favoriteBtn.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3/2 animations:^{
                    self.favoriteBtn.transform = CGAffineTransformIdentity;
                    
                    
                }];
            }];
        }];
    
    }
}

#pragma mark  Share
- (IBAction) shareBtnCall:(UIButton*) sender {
    
    [[SocialKit sharedSocialKit] setMessage:[NSString stringWithFormat:@"Check this %@",[self.currentItem objectForKey:@"discountTitle"]]];
    [[SocialKit sharedSocialKit] setUrlStr:@"http://acapellaglobal.com/clients/Discount_Now_Admin/admin/index.html"];
    [[SocialKit sharedSocialKit] ShowShareOptions];
}

- (IBAction)dismissTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark  Capture

- (IBAction)captureTapped:(id)sender
{
    if (self.isSavedDeal) {
        
        if (!self.redeemNavi) {
            
            self.redeemVC = [[Redeem alloc] init];
            self.redeemNavi = [[UINavigationController alloc] initWithRootViewController:self.redeemVC];
            self.redeemNavi.navigationBar.hidden=YES;
            self.redeemNavi.view.backgroundColor = STATUS_BAR_COLOR;
        }
        
        DiscountViewController *discountViewController = (DiscountViewController*) MY_APP_DELEGATE.discountViewController;
        self.redeemVC.currentItem = self.currentItem;
        [discountViewController presentViewController:self.redeemNavi animated:YES completion:NULL];
    }
    else {
        
        DiscountViewController *discountViewController = (DiscountViewController*) MY_APP_DELEGATE.discountViewController;
        
//        UINavigationController *navi = [self.tabBarController.viewControllers objectAtIndex:2];
        
        [UIView beginAnimations:@"suck" context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationCompleted)];
        [UIView setAnimationTransition:103 forView:discountViewController.view cache:NO];
        [UIView setAnimationDuration:0.8f];
        [UIView setAnimationPosition:CGPointMake(288, 545)];
        [UIView commitAnimations];
        
        [self.navigationController popToRootViewControllerAnimated:NO];
        
        [MY_APP_DELEGATE.discountViewController changeSelectedTab:4];
    }
}

- (void) animationCompleted {

    SavedDiscount *savedDiscount = [MY_APP_DELEGATE.discountViewController.SavedNavi.viewControllers objectAtIndex:0];
    [savedDiscount showThankYouPage:self.currentItem];
    
    [MY_APP_DELEGATE.discountViewController increaseDiscountBadge];
}

#pragma mark -
#pragma mark  MAP

- (IBAction)mapBtnTapped:(UIButton*)sender {
    
    MapFullView *mapFullView = [[MapFullView alloc] init];
    
    mapFullView.currentItem = self.currentItem;
    
    [MY_APP_DELEGATE.rootVC presentViewController:mapFullView animated:YES completion:nil];
}

- (IBAction)moveToCurrentLocationTapped:(id)sender
{
    [self.mkMapView setCenterCoordinate:self.mkMapView.userLocation.location.coordinate animated:YES];
}

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
    
    [itemsArray removeAllObjects];
    [itemsArray addObject:@""];  // After implementing the webservices, values will be given
    
    [self.mkMapView removeAnnotations:allAnnotations];
    [allAnnotations removeAllObjects];
    
//    for (int i=0;i<[itemsArray count];i++) {
//        
//        NSMutableDictionary *currentDict = [itemsArray objectAtIndex:i];
//        
//        CLLocationCoordinate2D coordinate;
//        coordinate.latitude = 41.5255;
//        coordinate.longitude = -87.3740;
//        
//        MyLocation *myLocation = [[MyLocation alloc] initWithCoordinate:coordinate andTag:[NSString stringWithFormat:@"%d",i] andName:@"Better Burgers" andSubName:@"337, rush st"];
//        [allAnnotations addObject:myLocation];
//    }
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [[self.currentItem objectForKey:@"latitude"] floatValue];
    coordinate.longitude = [[self.currentItem objectForKey:@"longitude"] floatValue];
    
    MyLocation *myLocation = [[MyLocation alloc] initWithCoordinate:coordinate andTag:[NSString stringWithFormat:@"0"] andName:[self.currentItem objectForKey:@"companyName"] andSubName:@""];
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
                
//                MyLocation *current = (MyLocation*) annotation;
                UIImage *pinImage = [UIImage imageNamed:[self.currentItem objectForKey:@"pinType"]];
                pinView.image = pinImage;
                
        
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
    
    
}

#pragma mark -
#pragma mark  Media

#pragma mark table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  (tableView == self.pictureTable)?[mediaArray count]:1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"MediaCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
        UIImageView *itemPic = [[UIImageView alloc] init];
        itemPic.transform=CGAffineTransformMakeRotation(M_PI / 2); // rotating
        itemPic.frame = CGRectMake(0, 0, 194, 320);
        [itemPic setBackgroundColor:[UIColor clearColor]];
        itemPic.tag = 11;
        //dealImage.contentMode = UIViewContentModeScaleAspectFit;
        itemPic.contentMode = UIViewContentModeScaleAspectFill;
        itemPic.clipsToBounds = YES;
        [cell.contentView addSubview:itemPic];
        
        UIImageView *playPic = [[UIImageView alloc] init];
        [playPic setImage:[UIImage imageNamed:@"detail_play.png"]];
        playPic.transform=CGAffineTransformMakeRotation(M_PI / 2); // rotating
        playPic.frame = CGRectMake(0, 0, 175, 320);
        [playPic setBackgroundColor:[UIColor clearColor]];
        playPic.tag = 22;
        playPic.contentMode = UIViewContentModeCenter;
        playPic.clipsToBounds = YES;
        [cell.contentView addSubview:playPic];
        
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    UIImageView *cellImageView = (UIImageView*)[cell.contentView viewWithTag:11];
    UIImageView *cellPlayView = (UIImageView*)[cell.contentView viewWithTag:22];
    
   // NSDictionary *currentDict=[mediaArray objectAtIndex:indexPath.row];
    
    if (tableView==self.pictureTable) {
        cellPlayView.hidden=YES;
        cellImageView.frame = CGRectMake(0, 0, 194, 320);
        cellImageView.image = [UIImage imageNamed:[mediaArray objectAtIndex:indexPath.row]];
    }else {
        cellPlayView.hidden=NO;
        cellImageView.frame = CGRectMake(0, 0, 175, 320);
//        cellImageView.image = [UIImage imageNamed:@"beach.jpg"];
        
        NSString *youtubeVideo = [self.currentItem objectForKey:@"youtube_link"];
        
        NSString *videoID = [YoutubeParser getYoutubeVideoID:youtubeVideo];
        NSString *imageUrlString=[NSString stringWithFormat:@"http://img.youtube.com/vi/%@/0.jpg",videoID ];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        
            NSData   *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrlString]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                cellImageView.image = [UIImage imageWithData:data];
                [cell setNeedsLayout];
            });
        });
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView==self.videoTable) {
        
        NSString *stringURL;
        
        stringURL = [self.currentItem objectForKey:@"youtube_link"];
        
        NSString *videoId = [YoutubeParser getYoutubeVideoID:stringURL];
        video *video1 = [[video alloc] init];
        [video1 setVideoId:videoId];
        
        [MY_APP_DELEGATE.rootVC presentViewController:video1 animated:YES completion:nil];
        
    }else {
    
        PictureFullView *pictureFullView = [[PictureFullView alloc] initWithImageArray:mediaArray andSelectedIndex:(int)indexPath.row];
        [MY_APP_DELEGATE.rootVC presentViewController:pictureFullView animated:YES completion:nil];
    }
}

#pragma mark -
#pragma mark  Info

- (IBAction)infoBtnTapped:(UIButton*)sender {
    
    if (!self.informationNavi) {
        
        self.information = [[Information alloc] init];
        self.informationNavi = [[UINavigationController alloc] initWithRootViewController:self.information];
        self.informationNavi.navigationBar.hidden=YES;
        self.informationNavi.view.backgroundColor = STATUS_BAR_COLOR;
    }
    
    DiscountViewController *discountViewController = (DiscountViewController*) MY_APP_DELEGATE.discountViewController;
    self.information.currentItem = self.currentItem;
    [discountViewController presentViewController:self.informationNavi animated:YES completion:NULL];
}

#pragma mark -
#pragma mark  Scroll Page

- (IBAction)nextBtnTapped:(UIButton*)sender {
    
    [self.pictureTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:currentPage+1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    [self updatePreviousNextBtnStatus:currentPage+1];
}

- (IBAction)previousBtnTapped:(UIButton*)sender {
    
    [self.pictureTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:currentPage-1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    [self updatePreviousNextBtnStatus:currentPage-1];
}

- (void) updatePreviousNextBtnStatus: (int) page {

    self.prevBtn.hidden=NO;
    self.nextBtn.hidden=NO;
    
    if (page < 1) {
        self.prevBtn.hidden=YES;
    }
    if (page == [mediaArray count]-1) {
        self.nextBtn.hidden=YES;
    }
    
    currentPage = page;
}

#pragma mark  UIScrollView

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (scrollView==self.pictureTable) {
        CGFloat pageWidth = 320;
        int page = floor((scrollView.contentOffset.y - pageWidth / 2) / pageWidth) + 1;
        
        DLog(@"%d %@ %@",page,scrollView,self.pictureTable.visibleCells);
        
        [self updatePreviousNextBtnStatus:page];
    }
}

#pragma mark -
#pragma mark  Memory

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
