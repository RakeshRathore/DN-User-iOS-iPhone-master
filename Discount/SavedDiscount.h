//
//  SavedDiscount.h
//  Discount
//
//  Created by Sajith KG on 23/01/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThankYou.h"

@interface SavedDiscount : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UISegmentedControl *searchSegment;
@property (strong, nonatomic) IBOutlet UITableView *listTable;
@property (strong, nonatomic) IBOutlet UILabel *titleLbl;

@property (nonatomic, strong) IBOutlet UIView *topbarView,*sortView,*sortBGView;
@property (strong, nonatomic) IBOutlet UIButton *myDiscountBtn,*nearbyBtn,*AtoZbtn,*lightningBtn,*sortBtn;

@property (nonatomic, assign) NSInteger lastContentOffset;

- (void) showThankYouPage:(NSDictionary*) dict;

@end
