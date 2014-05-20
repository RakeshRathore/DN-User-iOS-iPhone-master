//
//  ShareKit.h
//  Cary
//
//  Created by Sajith KG on 04/10/13.
//  Copyright (c) 2013 Sajith KG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Twitter/Twitter.h>
#import <Social/Social.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MessageUI.h>

@interface SocialKit : NSObject <UIActionSheetDelegate,MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>

@property (nonatomic,strong) NSString *message,*urlStr,*mailSubject,*mailToAddress;
@property (nonatomic,strong) UIImage *picture;


+ (id)sharedSocialKit;
- (void) ShowShareOptions;
- (void) shareWithMail;
- (void) shareWithFacebook;
- (void) shareWithTwitter;
- (void) shareWithMessage;

@end
