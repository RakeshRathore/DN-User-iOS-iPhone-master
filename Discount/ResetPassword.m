//
//  ResetPassword.m
//  Discount
//
//  Created by Sajith KG on 29/01/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "ResetPassword.h"
#import "UIImage+customColor.h"

@interface ResetPassword ()

@end

@implementation ResetPassword

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSUInteger) supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	 self.view.backgroundColor = RGB(27, 34, 48);
    
    self.topView.backgroundColor = TOPBAR_BG_COLOR;
    
    [self.submitBtn.titleLabel setFont:LATO_BOLD(18)];
    self.submitBtn.backgroundColor = TOPBAR_BG_COLOR;
    
    [self.submitBtn setTitleColor:[UIColor whiteColor] forState:0];
    [self.submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [self.resetPassHdr setFont:LATO_BOLD(20)];
    [self.enterEmailHdr setFont:LATO_REGULAR(16)];
    
    [self.resetPassHdr setTextColor:[UIColor whiteColor]];
    [self.enterEmailHdr setTextColor:[UIColor whiteColor]];
    
    [self.resetPassHdr setText:@"Reset Password"];
    [self.enterEmailHdr setText:@"Please enter your email address"];
    
     [self.logoImg setImage:[[UIImage imageNamed:@"logo.png"] imageWithOverlayColor:[UIColor whiteColor]]];
}

- (IBAction)backButtonTapped:(id)sender
{
    [self.navigationController  popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
