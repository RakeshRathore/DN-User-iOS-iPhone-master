//
//  DiscountDetail.h
//  Discount
//
//  Created by Jason Merchant on 1/13/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MyLocation.h"
#import "Redeem.h"
#import "PictureFullView.h"
#import "MapFullView.h"
#import "Information.h"

@interface DiscountDetail : UIViewController <MKMapViewDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>


@property (strong, nonatomic) NSDictionary *currentItem;

@property (strong, nonatomic) IBOutlet UILabel *titleLbl;

@property (strong, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (nonatomic, strong) IBOutlet UIView *scrollContentView;

@property (nonatomic, strong) IBOutlet UIView *topbarView,*pictureView,*informationView,*whatsIncludedView,*bottomView,*locationView,*mapView,*businessView;

@property (strong, nonatomic) IBOutlet UITableView *pictureTable,*videoTable;

@property (strong, nonatomic) IBOutlet UILabel *daysLbl;
@property (strong, nonatomic) IBOutlet UILabel *priceLbl;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn,*prevBtn;

@property (strong, nonatomic) IBOutlet UILabel *itemTitleLbl;
@property (strong, nonatomic) IBOutlet UILabel *itemDiscountLbl;
@property (strong, nonatomic) IBOutlet UILabel *itemOfferLbl;

@property (strong, nonatomic) IBOutlet UILabel *addressLbl;
@property (strong, nonatomic) IBOutlet UILabel *openTimeLbl;

@property (strong, nonatomic) IBOutlet UIView *lineTop;
@property (strong, nonatomic) IBOutlet UIView *lineBottom;
@property (strong, nonatomic) IBOutlet UIView *lineMiddle;

@property (strong, nonatomic) IBOutlet UIButton *phoneBtn;

@property (strong, nonatomic) IBOutlet UILabel *whatsIncludedHdr;
@property (strong, nonatomic) IBOutlet UILabel *whatsIncludedValue;

@property (strong, nonatomic) IBOutlet UILabel *locationHdr;
@property (strong, nonatomic) IBOutlet UILabel *locationValue;
@property (strong, nonatomic) IBOutlet UIView *distanceView;
@property (strong, nonatomic) IBOutlet UILabel *distanceLbl;

@property (strong, nonatomic) IBOutlet UIButton *mapTitle;

@property (strong, nonatomic) IBOutlet MKMapView *mkMapView;

@property (strong, nonatomic) IBOutlet UILabel *businessName;
@property (strong, nonatomic) IBOutlet UILabel *businessDetails;

// Bottom View
@property (nonatomic, strong) IBOutlet UIButton *favoriteBtn;
@property (nonatomic, strong) IBOutlet UIButton *shareBtn;
@property (nonatomic, strong) IBOutlet UIButton *captureBtn;

// Redeem
@property (nonatomic, readwrite) BOOL isSavedDeal;
@property (strong, nonatomic) UINavigationController *redeemNavi;
@property (strong, nonatomic) Redeem *redeemVC;

// Information
@property (strong, nonatomic) UINavigationController *informationNavi;
@property (strong, nonatomic) Information *information;

- (IBAction)captureTapped:(id)sender;
- (IBAction)dismissTapped:(id)sender;

@end
