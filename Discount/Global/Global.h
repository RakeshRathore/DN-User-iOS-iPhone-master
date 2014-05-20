//
//  SwapGlobals.h
//  SWAP
//
//  Created by Sajith KG on 22/05/13.
//  Copyright (c) 2013 Sajith KG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Global : NSObject

extern NSString *const IS_FIRST_RUN;
extern NSString *const IS_LOGGED_IN;

extern NSString *const USER_ID;
extern NSString *const USER_NAME;
extern NSString *const EMAIL_ID;

extern NSString *const SOCIAL_FACEBOOK;
extern NSString *const SOCIAL_TWITTER;
extern NSString *const POST_DIBS_FACEBOOK;
extern NSString *const POST_DIBS_TWITTER;
extern NSString *const POST_FAVS_FACEBOOK;
extern NSString *const POST_FAVS_TWITTER;

extern NSString *const LOCATION_UPDATED;


typedef NS_ENUM(NSUInteger, WebPageType) {
    
    kHelp,
    kPrivacyPolicy,
    kTerms,
    kMobileTerms
};



+(void)registerDefaultValues;

+(BOOL) checkLoggedIn;
+(void) markLoggedIn : (NSString*) userId;
+(void) markLoggedOut;
+(NSString *) getLoggedInUser;

+(void) saveDefaultValue : (NSString *)val forKey:(NSString * )key;
+(void) saveDefaultObject : (id)val forKey:(NSString * )key;

+(NSString *) getDefaultValue :(NSString *)key;
+(id) getDefaultObject :(NSString *)key;

+(void) saveDefaultBool : (BOOL)yesOrNo forKey:(NSString * )key;
+(BOOL) getDefaultBool :(NSString *)key;

+(BOOL) validateEmail: (NSString *) candidate;
+(BOOL) validatePhoneNo: (NSString *) number;

+(void) animateView:(UIView*) view1 : (BOOL) up :(int)md;

+(BOOL) isIPhone5;

+(UIImage*)getCropImage:(CGRect)cropRect imageToCrop:(UIImage*)imageTocrop;
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
+(UIImage*)imageWithImage: (UIImage*) sourceImage scaledToWidth: (float) newWidth;
+(UIColor *) colorWithHex:(UInt32)col;

+ (void) showAlertWithMessage:(NSString*) message;
+ (void) showErrorWithMessage:(NSString*) message;

+ (NSString*) getWebPageUrlString:(WebPageType) webPage;

@end
