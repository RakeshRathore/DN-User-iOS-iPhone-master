//
//  SwapGlobals.m
//  SWAP
//
//  Created by Sajith KG on 22/05/13.
//  Copyright (c) 2013 Sajith KG. All rights reserved.
//

#import "Global.h"

@implementation Global

NSString *const IS_FIRST_RUN = @"IS_FIRST_RUN";
NSString *const IS_LOGGED_IN = @"IS_LOGGED_IN";

// User Info
NSString *const USER_ID = @"USER_ID";
NSString *const USER_NAME = @"USER_NAME";
NSString *const EMAIL_ID = @"EMAIL_ID";

// Social
NSString *const SOCIAL_FACEBOOK = @"SOCIAL_FACEBOOK";
NSString *const SOCIAL_TWITTER = @"SOCIAL_TWITTER";

NSString *const POST_DIBS_FACEBOOK = @"POST_DIBS_FACEBOOK";
NSString *const POST_DIBS_TWITTER = @"POST_DIBS_TWITTER";

NSString *const POST_FAVS_FACEBOOK = @"POST_FAVS_FACEBOOK";
NSString *const POST_FAVS_TWITTER = @"POST_FAVS_TWITTER";

// Location Info
NSString *const LOCATION_UPDATED = @"LOCATION_UPDATED";

#pragma mark -
#pragma mark UserDefault

+ (NSString*) getWebPageUrlString:(WebPageType) webPage {
    
    NSString *urlStr;
    
    switch (webPage) {
        case kHelp:
            urlStr = @"http://dnow.acapellaglobal.com/help";
            break;
            
        case kPrivacyPolicy:
            urlStr = @"http://www.google.co.in/intl/en/policies/privacy/";
            break;
            
        case kTerms:
            urlStr = @"http://www.google.co.in/intl/en/policies/terms/regional.html";
            break;
            
        case kMobileTerms:
            urlStr = @"https://www.google.com/intl/en/chrome/browser/privacy/";
            break;
            
        default:
            break;
    }
    
    return urlStr;
    
}


+ (void)registerDefaultValues {
    
    NSMutableDictionary *defaults=[NSMutableDictionary dictionary];
    
    [defaults setObject:[NSNumber numberWithBool:YES] forKey:IS_FIRST_RUN];
    [defaults setObject:[NSNumber numberWithBool:NO] forKey:IS_LOGGED_IN];

    [defaults setObject:@"" forKey:USER_ID];
    [defaults setObject:@"" forKey:USER_NAME];
    [defaults setObject:@"" forKey:EMAIL_ID];
    
    [defaults setObject:[NSNumber numberWithBool:NO] forKey:SOCIAL_FACEBOOK];
    [defaults setObject:[NSNumber numberWithBool:NO] forKey:SOCIAL_TWITTER];
    [defaults setObject:[NSNumber numberWithBool:NO] forKey:POST_DIBS_FACEBOOK];
    [defaults setObject:[NSNumber numberWithBool:NO] forKey:POST_DIBS_TWITTER];
    [defaults setObject:[NSNumber numberWithBool:NO] forKey:POST_FAVS_FACEBOOK];
    [defaults setObject:[NSNumber numberWithBool:NO] forKey:POST_FAVS_TWITTER];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
}

+(BOOL) checkLoggedIn {
    
    return [self getDefaultBool:IS_LOGGED_IN];
}

+(NSString *) getLoggedInUser {
	return [NSString stringWithFormat:@"%@",[self getDefaultObject:USER_ID]];
}

+(void) markLoggedIn : (NSString*) userId {
    
    [self saveDefaultBool:YES forKey:IS_LOGGED_IN];
    [self saveDefaultObject:userId forKey:IS_LOGGED_IN];
}

+(void) markLoggedOut{
    
    [self saveDefaultBool:NO forKey:IS_LOGGED_IN];
    [self saveDefaultObject:@"" forKey:USER_ID];
    [self saveDefaultValue:@"" forKey:USER_NAME];
    [self saveDefaultValue:@"" forKey:EMAIL_ID];
}

#pragma mark Value

+(void) saveDefaultValue : (NSString *)val forKey:(NSString * )key {
    
	[[NSUserDefaults standardUserDefaults] setValue:val forKey:key];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *) getDefaultValue :(NSString *)key {
    
	return [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:key]];
}

#pragma mark Object

+(void) saveDefaultObject : (id)val forKey:(NSString * )key {
    
	[[NSUserDefaults standardUserDefaults] setObject:val forKey:key];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

+(id) getDefaultObject :(NSString *)key {
    
	return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

#pragma mark Bool

+(void) saveDefaultBool : (BOOL)yesOrNo forKey:(NSString * )key {
    
	[[NSUserDefaults standardUserDefaults] setBool:yesOrNo forKey:key];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

+(BOOL) getDefaultBool :(NSString *)key {
    
	return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

#pragma mark -
#pragma mark Common

+ (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	
    return [emailTest evaluateWithObject:candidate];
}

+ (BOOL) validatePhoneNo: (NSString *) number {
    
    NSString *mobileNumberPattern = @"[789][0-9]{9}";
    NSPredicate *mobileNumberPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNumberPattern];
    return [mobileNumberPred evaluateWithObject:number];
}


+ (void) animateView:(UIView*) view1 : (BOOL) up :(int)md {
	
	const int movementDistance =md;
	const float movementDuration = 0.3f;
	
	int movement = (up ? -movementDistance : movementDistance);
	
	[UIView beginAnimations: @"anim" context: nil];
	[UIView setAnimationBeginsFromCurrentState: YES];
	[UIView setAnimationDuration: movementDuration];
    
    view1.frame = CGRectOffset(view1.frame, 0, movement);
	[UIView commitAnimations];
}

+ (BOOL) isIPhone5 {
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            return NO;
        }
    }
    return YES;
}

#pragma mark -
#pragma mark Image Scall/Crop

+(UIImage*)getCropImage:(CGRect)cropRect imageToCrop:(UIImage*)imageTocrop
{
    CGImageRef image = CGImageCreateWithImageInRect([imageTocrop CGImage],cropRect);
    UIImage *cropedImage = [UIImage imageWithCGImage:image];
    CGImageRelease(image);
    return cropedImage;
}

+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
	
	UIGraphicsBeginImageContext(newSize );
	[image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
    // NSLog(@"Image Captured");
    // NSLog(@"OriginalImage width=%f",newImage.size.width);
    // NSLog(@"OriginalImage height=%f",newImage.size.height);
	return newImage;
}

+(UIImage*)imageWithImage: (UIImage*) sourceImage scaledToWidth: (float) newWidth
{
    float oldWidth = sourceImage.size.width;
    float scaleFactor = newWidth / oldWidth;
    
    float newHeight = sourceImage.size.height * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIColor *) colorWithHex:(UInt32)col {
    
    unsigned char r, g, b;
    b = col & 0xFF;
    g = (col >> 8) & 0xFF;
    r = (col >> 16) & 0xFF;
    return [UIColor colorWithRed:(double)r/255.0f green:(double)g/255.0f blue:(double)b/255.0f alpha:1];
}


#pragma mark -
#pragma mark Image Show Alert

+ (void) showAlertWithMessage:(NSString*) message {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:appName
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

+ (void) showErrorWithMessage:(NSString*) message {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}


@end
