//
//  Information.h
//  Discount
//
//  Created by Sajith KG on 03/04/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Information : UIViewController

@property (strong, nonatomic) IBOutlet UIScrollView *myScrollView;

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIView *businessView;

@property (strong, nonatomic) IBOutlet UIImageView *businessImage;

@property (strong, nonatomic) IBOutlet UIButton *termsBtn;

@property (strong, nonatomic) IBOutlet UILabel *businessName;
@property (strong, nonatomic) IBOutlet UILabel *businessAddress;
@property (strong, nonatomic) IBOutlet UILabel *dealName;
@property (strong, nonatomic) IBOutlet UILabel *dealDesc;

@property (strong, nonatomic) NSDictionary *currentItem;

@property (strong, nonatomic) IBOutlet UILabel *titleLbl;

- (IBAction)dismissTapped:(id)sender;
- (IBAction)termsTapped:(id)sender ;

@end
