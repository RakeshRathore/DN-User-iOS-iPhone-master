//
//  AppDelegate.h
//  Discount
//
//  Created by Jason Merchant on 1/13/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscountViewController.h"
#import "ViewController.h"
#import "RootVC.h"
#import "FBConnect.h"
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>
#import "PickerSheet.h"


@class GTMOAuth2Authentication;

@interface AppDelegate : UIResponder <UIApplicationDelegate,pickerDelegate,FBSessionDelegate,FBRequestDelegate> {

    ACAccountStore *account;
    ACAccount *twitterAccount;
    NSMutableArray *arrayOfAccounts;
    PickerSheet *picker;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DiscountViewController *discountViewController;
@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) RootVC *rootVC;

@property (nonatomic, strong) Facebook *facebook;
@property (assign,nonatomic) NSObject *facebookHandler;

@property (strong,nonatomic) ACAccount *twitterAccount;
@property (assign,nonatomic) NSObject *twitterHandler;

- (void) showDevelopmentMessage;




- (void) allocateFacebook;
- (void) checkFacebookLoginCall : (NSObject*) handler;
- (void) clearFBCache;

- (void) checkTwitterLogin : (NSObject*) handler;
+(void)showWithTitle:(NSString *)title message:(NSString *)msg;

@end
