//
//  ThankYou.m
//  Discount
//
//  Created by Sajith KG on 08/04/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "ThankYou.h"
#import "SocialKit.h"
#import "AppDelegate.h"

@interface ThankYou () {

    NSString *shareMessage;
}

@end

@implementation ThankYou

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.messsageLbl.font = LATO_REGULAR(13);
    self.messsageLbl.textColor = RGB(57, 57, 57);
    
    self.summaryHdrLbl.font = LATO_REGULAR(16);
    self.summaryHdrLbl.textColor = STATUS_BAR_COLOR;
    
     self.itemTitleLbl.textColor = STATUS_BAR_COLOR;
   
    self.itemTitleLbl.font = LATO_BOLD(22);
    self.itemDiscountLbl.font = LATO_BOLD(14);
    self.itemOfferLbl.font = LATO_REGULAR(14);

    self.shareHdrLbl.font = LATO_REGULAR(13);
    self.shareHdrLbl.textColor = STATUS_BAR_COLOR;
    
    [_cancelBtn setTitleColor:STATUS_BAR_COLOR forState:0];
}


- (void) resetContent{
    //Thank you for Dibb'ing this showcase at Voodoo BBQ. Call us if you have any questions. Look forward to seeing you there.
    
    self.messsageLbl.text = [NSString stringWithFormat:@"Thank you for Dibb'ing this showcase at %@. Call us if you have any questions. Look forward to seeing you there.",[self.currentItem objectForKey:@"companyName"]];
    
    //self.messsageLbl.text = [NSString stringWithFormat:@"Thank you for purchasing our discount at %@ AAAAAAA BBBBB CCCC DDDDD",[self.currentItem objectForKey:@"companyName"]];
    
    self.itemDiscountLbl.text = [NSString stringWithFormat:@"$%@ for $%@",[self.currentItem objectForKey:@"discountPrice"],[self.currentItem objectForKey:@"originalPrice"]];
    
    self.itemOfferLbl.text = [NSString stringWithFormat:@"%@ off at %@",[self.currentItem objectForKey:@"percentageSavings"],[self.currentItem objectForKey:@"companyName"]];
    
    
     self.itemTitleLbl.text = [self.currentItem objectForKey:@"discountTitle"];
    
    shareMessage = [self.currentItem objectForKey:@"companyName"];
    
    [self.messsageLbl setFrame:CGRectMake(self.messsageLbl.frame.origin.x, self.messsageLbl.frame.origin.y, self.messsageLbl.frame.size.width, [self.messsageLbl sizeThatFits:CGSizeMake(self.messsageLbl.frame.size.width, CGFLOAT_MAX)].height)];
    
    // Information
    
    [self.itemTitleLbl setFrame:CGRectMake(self.itemTitleLbl.frame.origin.x, self.itemTitleLbl.frame.origin.y, self.itemTitleLbl.frame.size.width, [self.itemTitleLbl sizeThatFits:CGSizeMake(self.itemTitleLbl.frame.size.width, CGFLOAT_MAX)].height)];
    
    [self.itemDiscountLbl setFrame:CGRectMake(self.itemDiscountLbl.frame.origin.x, self.itemTitleLbl.frame.origin.y+self.itemTitleLbl.frame.size.height +10, self.itemDiscountLbl.frame.size.width, [self.itemDiscountLbl sizeThatFits:CGSizeMake(self.itemDiscountLbl.frame.size.width, CGFLOAT_MAX)].height)];
    
    [self.itemOfferLbl setFrame:CGRectMake(self.itemOfferLbl.frame.origin.x, self.itemDiscountLbl.frame.origin.y+self.itemDiscountLbl.frame.size.height , self.itemDiscountLbl.frame.size.width, [self.itemOfferLbl sizeThatFits:CGSizeMake(self.itemOfferLbl.frame.size.width, CGFLOAT_MAX)].height)];
    
    self.informationView.frame = CGRectMake(self.informationView.frame.origin.x, self.messsageLbl.frame.origin.y+self.messsageLbl.frame.size.height+5, self.informationView.frame.size.width, self.itemOfferLbl.frame.origin.y + self.itemOfferLbl.frame.size.height +10);
    
    self.shareView.frame = CGRectMake(self.shareView.frame.origin.x, self.informationView.frame.origin.y + self.informationView.frame.size.height, self.shareView.frame.size.width, self.shareView.frame.size.height);
    
    self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y , self.contentView.frame.size.width,  self.shareView.frame.origin.y + self.shareView.frame.size.height);
    
    //self.whatsIncludedView.backgroundColor=[UIColor redColor];
    //self.shareView.backgroundColor=[UIColor greenColor];
    //self.contentView.backgroundColor=[UIColor blueColor];
    
    [self.myScrollView setContentSize:CGSizeMake(self.contentView.frame.size.width, self.contentView.frame.size.height)];
    
    CGFloat maxHeight = self.contentView.frame.size.height+43;
    
    if (maxHeight > 360) {
        maxHeight= 360;
    }
    
    [self.popView setFrame:CGRectMake(self.popView.frame.origin.x, self.popView.frame.origin.y,self.popView.frame.size.width, maxHeight)];
    
}

- (IBAction) fbBtnCall {
    
    [[SocialKit sharedSocialKit] setMessage:shareMessage];
    [[SocialKit sharedSocialKit] setUrlStr:@"http://acapellaglobal.com/clients/Discount_Now_Admin/admin/index.html"];
    [[SocialKit sharedSocialKit] shareWithFacebook];
}

- (IBAction) twitterBtnCall {
    
    [[SocialKit sharedSocialKit] setMessage:shareMessage];
     [[SocialKit sharedSocialKit] setUrlStr:@"http://acapellaglobal.com/clients/Discount_Now_Admin/admin/index.html"];
    [[SocialKit sharedSocialKit] shareWithTwitter];
}



@end
