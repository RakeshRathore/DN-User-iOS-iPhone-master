//
//  Redeem.m
//  Discount
//
//  Created by Sajith KG on 27/01/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "Redeem.h"
#import "DiscountViewController.h"
#import "AppDelegate.h"
#import "SavedDiscount.h"

@interface Redeem ()

@end

@implementation Redeem

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
    self.myScrollView.backgroundColor = RGB(21, 25, 36);
    self.topView.backgroundColor = TOPBAR_BG_COLOR;
    [self.redeemBtn setBackgroundColor:TOPBAR_BG_COLOR];
    [self.qrCode setBackgroundColor:TOPBAR_BG_COLOR];
    
    self.businessImage.layer.cornerRadius = 25;
    self.businessImage.clipsToBounds = YES;
    
    self.businessName.textColor = VIEW_BG_COLOR;
    self.businessAddress.textColor = VIEW_BG_COLOR;
    self.dealName.textColor = VIEW_BG_COLOR;
    self.dealDesc.textColor = RGB(156, 156, 156);
    
    self.businessName.font = LATO_REGULAR(18);
    self.businessAddress.font = LATO_REGULAR(14);
    
    self.dealName.font = LATO_REGULAR(18);
    self.dealDesc.font = LATO_REGULAR(13);
    
    [self.redeemBtn.titleLabel setFont:LATO_BOLD(18)];
    [self.termsBtn.titleLabel setFont:LATO_REGULAR(12)];
    [self.shareBtn.titleLabel setFont:LATO_REGULAR(16)];
    
    [self.termsBtn setTintColor:TOPBAR_BG_COLOR];
    
    self.titleLbl.font = LATO_REGULAR(18);
}

- (void) viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self resetScrollViewHeight];
    DLog(@"%@",self.currentItem);
}

- (void) resetScrollViewHeight {
    
    [self.qrCode setTitle:@"2 J T Y 7 K 0 D 2 2 L" forState:0];
    
    [self.businessImage setImage:[UIImage imageNamed:[self.currentItem objectForKey:@"imageURL"]]];
    
    self.businessName.text = [self.currentItem objectForKey:@"companyName"];
    self.businessAddress.text = [NSString stringWithFormat:@"%@ \n%@,%@ %@",[self.currentItem objectForKey:@"address"],[self.currentItem objectForKey:@"city"],[self.currentItem objectForKey:@"state"],[self.currentItem objectForKey:@"zip"]];
    self.dealName.text = [self.currentItem objectForKey:@"discountTitle"];
    self.dealDesc.text = [NSString stringWithFormat:@"$%@",[self.currentItem objectForKey:@"whatsIncluded"]];
    
    [self.businessAddress setFrame:CGRectMake(self.businessAddress.frame.origin.x, self.businessAddress.frame.origin.y, self.businessAddress.frame.size.width, [self.businessAddress sizeThatFits:CGSizeMake(self.businessAddress.frame.size.width, CGFLOAT_MAX)].height)];
    
    self.businessView.frame = CGRectMake(0, 204, 320, self.businessAddress.frame.origin.y + self.businessAddress.frame.size.height+20);
    
    self.dealName.frame = CGRectMake(20, self.businessView.frame.origin.y + self.businessView.frame.size.height, 300,44);
    
    [self.dealDesc setFrame:CGRectMake(self.dealDesc.frame.origin.x, self.dealName.frame.origin.y + self.dealName.frame.size.height, self.dealDesc.frame.size.width, [self.dealDesc sizeThatFits:CGSizeMake(self.dealDesc.frame.size.width, CGFLOAT_MAX)].height)];
    
    self.redeemBtn.frame = CGRectMake(0, self.dealDesc.frame.origin.y + self.dealDesc.frame.size.height+20, 320,44);
    
    self.termsBtn.frame = CGRectMake(self.termsBtn.frame.origin.x, self.redeemBtn.frame.origin.y + self.redeemBtn.frame.size.height+10, self.termsBtn.frame.size.width,self.termsBtn.frame.size.height);
    
    [self.contentView setFrame:CGRectMake(0, 0, 320, self.termsBtn.frame.origin.y + self.termsBtn.frame.size.height +20)];
    
    [self.myScrollView setContentSize:CGSizeMake(320, self.termsBtn.frame.origin.y + self.termsBtn.frame.size.height +20)];
}

- (IBAction)redeemTapped:(id)sender {
    
    DiscountViewController *discountViewController = (DiscountViewController*) MY_APP_DELEGATE.discountViewController;
    [discountViewController dismissViewControllerAnimated:YES completion:^{
        SavedDiscount *savedDiscount = [MY_APP_DELEGATE.discountViewController.SavedNavi.viewControllers objectAtIndex:0];
        [savedDiscount showThankYouPage:self.currentItem];
    }];
    
    [MY_APP_DELEGATE.discountViewController.SavedNavi popToRootViewControllerAnimated:NO];
    
    
    
}

- (IBAction)shareTapped:(id)sender {
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[[NSString stringWithFormat:@"Check this %@",[self.currentItem objectForKey:@"discountTitle"]],[NSURL URLWithString:@"http://www.google.com"],self.qrImage.image] applicationActivities:nil];
    activityViewController.excludedActivityTypes = [[NSArray alloc] initWithObjects:
                                                    
                                                    UIActivityTypeCopyToPasteboard,
                                                    UIActivityTypePostToWeibo,
                                                    UIActivityTypeSaveToCameraRoll,
                                                    UIActivityTypeAssignToContact,
                                                    UIActivityTypePrint,
                                                    UIActivityTypeAirDrop,
                                                    UIActivityTypePostToTencentWeibo,
                                                    UIActivityTypePostToVimeo,
                                                    UIActivityTypePostToFlickr,
                                                    UIActivityTypeAddToReadingList,
                                                    nil];
    [activityViewController setCompletionHandler:^(NSString *activityType, BOOL completed) {
        NSLog(@"completed dialog - activity: %@ - finished flag: %d", activityType, completed);
    }];
    
    [self presentViewController:activityViewController animated:YES completion:nil];
}

- (IBAction)dismissTapped:(id)sender {

    DiscountViewController *discountViewController = (DiscountViewController*) MY_APP_DELEGATE.discountViewController;
    [discountViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)termsTapped:(id)sender {
    [MY_APP_DELEGATE showDevelopmentMessage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
