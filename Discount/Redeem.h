//
//  Redeem.h
//  Discount
//
//  Created by Sajith KG on 27/01/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Redeem : UIViewController

@property (strong, nonatomic) IBOutlet UIScrollView *myScrollView;

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIView *businessView;

@property (strong, nonatomic) IBOutlet UIImageView *qrImage;
@property (strong, nonatomic) IBOutlet UIImageView *businessImage;

@property (strong, nonatomic) IBOutlet UIButton *qrCode;
@property (strong, nonatomic) IBOutlet UIButton *redeemBtn;
@property (strong, nonatomic) IBOutlet UIButton *termsBtn;
@property (strong, nonatomic) IBOutlet UIButton *shareBtn;

@property (strong, nonatomic) IBOutlet UILabel *businessName;
@property (strong, nonatomic) IBOutlet UILabel *businessAddress;
@property (strong, nonatomic) IBOutlet UILabel *dealName;
@property (strong, nonatomic) IBOutlet UILabel *dealDesc;

@property (strong, nonatomic) NSDictionary *currentItem;

@property (strong, nonatomic) IBOutlet UILabel *titleLbl;

- (IBAction)redeemTapped:(id)sender;
- (IBAction)shareTapped:(id)sender;
- (IBAction)dismissTapped:(id)sender;
- (IBAction)termsTapped:(id)sender ;

@end
