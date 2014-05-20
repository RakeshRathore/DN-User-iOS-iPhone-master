//
//  SignUp.h
//  Discount
//
//  Created by Sajith KG on 30/01/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "SignTextField.h"

@class AppDelegate;
@interface SignUp : UIViewController <FBRequestDelegate,UITextFieldDelegate>{
    
    
    AppDelegate *delegateMain;
    
}


@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIView *contentView;
@property (nonatomic, strong) IBOutlet UIImageView *logoImageView;
@property (nonatomic, strong) IBOutlet SignTextField *firstName,*lastName,*emailAddress,*passWord,*confirmPassword;
@property (nonatomic, strong) IBOutlet UIButton *signUpBtn;
@property (nonatomic, strong) IBOutlet UIButton *facebookBtn;
@property (nonatomic, strong) IBOutlet UIButton *twitterBtn;
@property (nonatomic, strong) IBOutlet UIButton *loginBtn;


- (IBAction)loginTapped;
@property (nonatomic,copy)  NSString *facebookEmailID;

- (void) successFacebookLogin;
- (void) failureFacebookLogin;

- (void) successTwitterLogin;
- (void) failureTwitterLogin;

@end
