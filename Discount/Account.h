//
//  AccountInformation.h
//  Discount
//
//  Created by Sajith KG on 24/02/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileNameField.h"
#import "ProfileNameLabel.h"
#import "ProfileNameView.h"


typedef NS_ENUM(NSUInteger, AccountType) {

    kNormal,
    kFacebook,
    kTwitter
};

@interface Account : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UIView *topbarView;
@property (nonatomic, strong) IBOutlet UILabel *viewHdr;
@property (nonatomic, assign) AccountType accountType;

- (void) successPicture:(UIImage*) selectedPic;
- (void) failurePicture;

@end
