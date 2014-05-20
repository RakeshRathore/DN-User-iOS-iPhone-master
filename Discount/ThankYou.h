//
//  ThankYou.h
//  Discount
//
//  Created by Sajith KG on 08/04/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThankYou : UIViewController

@property (nonatomic, strong) IBOutlet UIView *popView,*headerView,*informationView,*shareView;
@property (nonatomic, strong) IBOutlet UIView *contentView;

@property (strong, nonatomic) IBOutlet UIScrollView *myScrollView;

@property (strong, nonatomic) IBOutlet UIView *blackBG;

@property (strong, nonatomic) NSDictionary *currentItem;

@property (strong, nonatomic) IBOutlet UILabel *messsageLbl;

@property (strong, nonatomic) IBOutlet UILabel *summaryHdrLbl;
@property (strong, nonatomic) IBOutlet UILabel *itemTitleLbl;
@property (strong, nonatomic) IBOutlet UILabel *itemDiscountLbl;
@property (strong, nonatomic) IBOutlet UILabel *itemOfferLbl;

@property (strong, nonatomic) IBOutlet UILabel *shareHdrLbl;

@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;

- (void) resetContent;

@end
