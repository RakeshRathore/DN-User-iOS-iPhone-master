//
//  DiscountNow.h
//  Discount
//
//  Created by Sajith KG on 06/02/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MyLocation.h"
#import "AppDelegate.h"


typedef enum ScrollDirection {
    ScrollDirectionNone,
    ScrollDirectionUp,
    ScrollDirectionDown,
} ScrollDirection;

@interface DiscountNow : UIViewController <UITableViewDataSource,UITableViewDelegate,MKMapViewDelegate,FBRequestDelegate>

@property (nonatomic, strong) IBOutlet UIView *topbarView,*listView,*holderView,*sortView,*sortBGView;
@property (strong, nonatomic) IBOutlet UITableView *listTable;
@property (strong, nonatomic) IBOutlet UILabel *titleLbl;
@property (strong, nonatomic) IBOutlet UIButton *nearbyBtn,*trendingBtn,*AtoZbtn,*favouritesBtn,*sortBtn;

@property (strong, nonatomic) NSMutableArray *itemsArray;

@property (strong, nonatomic) IBOutlet MKMapView *myMapView;

- (void) subCategoriesSelected: (NSArray*) ary ;

@property (nonatomic, assign) NSInteger lastContentOffset;

- (void) toggleCurrentView;
- (void) hideSortView;

- (void) reloadDataWithSearchQueries: (NSDictionary*) dict;

- (void) showDiscountDetails;

@end
