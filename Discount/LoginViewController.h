//
//  LoginViewController.h
//  Discount
//
//  Created by Jason Merchant on 1/13/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "SignTextField.h"

@interface LoginViewController : UIViewController <FBRequestDelegate,UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UIImageView *logoImageView;
@property (nonatomic, strong) IBOutlet SignTextField *emailAddress,*passWord;
@property (nonatomic, strong) IBOutlet UIButton *loginBtn;
@property (nonatomic, strong) IBOutlet UIButton *facebookBtn;
@property (nonatomic, strong) IBOutlet UIButton *twitterBtn;
@property (nonatomic, strong) IBOutlet UIButton *forgetPasswordBtn;
@property (nonatomic, strong) IBOutlet UIButton *signUpBtn;


@property (nonatomic,copy)  NSString *facebookEmailID;

- (IBAction)loginTapped:(id)sender;



@end
