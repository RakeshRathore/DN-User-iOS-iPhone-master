//
//  DiscountViewController.h
//  Discount
//
//  Created by Jason Merchant on 1/15/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"

@class DiscountNow;

@interface DiscountViewController : UIViewController <UINavigationControllerDelegate,UITabBarControllerDelegate>

@property (nonatomic, strong) IBOutlet UIButton *sidebarButton;

@property (nonatomic, strong) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) IBOutlet UIButton *profileBtn,*backBtn;

@property (nonatomic, strong) UITabBarController *mainTabBarCtr;

@property (nonatomic, strong) UINavigationController *SearchNav,*DiscountNowNav,*MapNav,*FavoriteNav,*SavedNavi,*profileNavi,*selectedNavi;

@property (nonatomic, strong) DiscountNow *discountNow;

@property (nonatomic, strong) IBOutlet UIView *topbarView,*statusBarBg;

@property (nonatomic,strong) UIImageView *screenShotImg;


- (IBAction)sidebarTapped:(id)sender;

- (void) removeProfileScreen ;

- (void) showBackButton: (BOOL) yes;

- (void) changeSelectedTab:(int) selectedTabIndex ;

- (IBAction)backButtonTapped:(id)sender;

- (void) increaseDiscountBadge;

- (void) hideLeftButton:(BOOL) yes;

@end
