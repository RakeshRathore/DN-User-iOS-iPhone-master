//
//  AppDelegate.m
//  Discount
//
//  Created by Jason Merchant on 1/13/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "AppDelegate.h"
#import "SignUp.h"
#import "SocialMedia.h"
#import <Parse/Parse.h>

@implementation AppDelegate

@synthesize facebook;
@synthesize facebookHandler,twitterHandler;
@synthesize twitterAccount;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
//    for (NSString *familyName in [UIFont familyNames]) {
//        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
//            DLog(@"%@", fontName);
//        }
//    }
    
    DLog(@"%@",launchOptions);
    
    [Parse setApplicationId:@"MUVMfOebQgWdLwZYZ08YqJq1LnCikmooq0u7HWht"
                  clientKey:@"zMUC2jFMnKltqvZIf0ct6CVyG6ufWBDyjgwWU6bR"];
    
    [Global registerDefaultValues];
    
    [self clearFBCache];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|
     UIRemoteNotificationTypeAlert|
     UIRemoteNotificationTypeSound];
    
    return YES;
}
#pragma mark Show alert with message
+(void)showWithTitle:(NSString *)title message:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}
- (void) showDevelopmentMessage {
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:appName
                              message:@"Under Development"
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil,
                              nil];
    [alertView show];
}

#pragma mark - TWITTER
#pragma mark

- (void) checkTwitterLogin : (NSObject*) handler {
    
    if (!arrayOfAccounts) {
        arrayOfAccounts=[[NSMutableArray alloc]init];
    }
    
    if (!picker) {
        picker=[[PickerSheet alloc]init];
        picker.pickerdelegate=self;
        [picker setPicker:defaultType : @"Choose an Account":kBarStyleBlackOpaque];
    }
    
    if (twitterHandler) {
        twitterHandler=nil;
    }
    self.twitterHandler = handler;
    
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 5.0) {
        
        BOOL access=NO;
        
        if (version >= 6.0) {
            
            if ([SLComposeViewController  isAvailableForServiceType:SLServiceTypeTwitter])
            {
                access=YES;
            }
        }
        
//        else if (version >= 5.0) {
//            
//            if ([TWTweetComposeViewController canSendTweet])
//            {
//                access=YES;
//            }
//        }
        
        if (access)
        {
            account = [[ACAccountStore alloc] init];
            ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
            
            [account requestAccessToAccountsWithType:accountType withCompletionHandler:^(BOOL granted, NSError *error)
             {
                   NSLog(@"error.code=%@  granted=%d",error.description ,granted);
                 
                 if (error) {
                     [self performSelectorOnMainThread:@selector(showTwitterError:) withObject:[@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup" capitalizedString] waitUntilDone:NO];
                     return;
                 }
                 
                 if (granted == YES)
                 {
                     if (self.twitterAccount != nil) {
                         
                         // NSLog(@"self.twitterAccount NOT nil");
                         [self performSelectorOnMainThread:@selector(twitterDidLogin) withObject:nil waitUntilDone:NO];
                     }else {
                         
                         //  NSLog(@"self.twitterAccount nil");
                         [arrayOfAccounts removeAllObjects];
                         [arrayOfAccounts addObjectsFromArray:[account accountsWithAccountType:accountType]];
                         
                          NSLog(@"arrayOfAccounts=%@",arrayOfAccounts);
                         
                         if ([arrayOfAccounts count] > 0)
                             [self performSelectorOnMainThread:@selector(updateTableview) withObject:nil waitUntilDone:NO];
                     }
                     return;
                 }
                 else{
                     
                     NSLog(@"granted=No Twitter is Disabled for Tag & Flag.");
                     [self performSelectorOnMainThread:@selector(showTwitterError:) withObject:[NSString stringWithFormat:@"Access denied for %@ in Twitter Settings",appName] waitUntilDone:NO];
                     return;
                 }
             }];
        }
        else
        {
            [self showTwitterError:[@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup" capitalizedString]];
        }
    }
    else {
        
        [self showTwitterError:@"Twitter sharing has been disabled in your device, Please update your OS version."];
    }
}

- (void) showTwitterError: (NSString*) errorMessage {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!"
                                                        message:errorMessage
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    alertView.tag=101;
    [alertView show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag ==101) {
        [self twitterDidNotLogin];
    }
}

-(void)updateTableview
{
    int numberOfTwitterAccounts = (int)[arrayOfAccounts count];
    if (numberOfTwitterAccounts>1) {
        NSMutableArray *usernames=[[NSMutableArray alloc]init];
        for (ACAccount *twitterAccount1 in arrayOfAccounts) {
            [usernames addObject:twitterAccount1.username];
        }
        [picker setPickerItems:usernames];
        picker.pickerdelegate=self;
        [picker reloadItems];
        
        DLog(@"self.viewController.view=%@",self.viewController.view);
        
        UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
//        if ([window.subviews containsObject:self.view]) {
//            [emailSheet showInView:self.view];
//        } else {
//            [emailSheet showInView:window];
//        }
        UIView *viewToPresent;
        
        for (UIView *subview in window.subviews) {
            DLog(@"subview=%@",subview);
            viewToPresent = subview;
        }
        
        [picker showPicker:viewToPresent animated:YES];
    }
    else{
        self.twitterAccount=[arrayOfAccounts objectAtIndex:0];
        NSDictionary *tempDict = [[NSMutableDictionary alloc] initWithDictionary:[twitterAccount dictionaryWithValuesForKeys:[NSArray arrayWithObject:@"properties"]]];
         NSLog(@"twitterAccount.username %@",twitterAccount.username);
         NSLog(@"user_id %@",[[tempDict objectForKey:@"properties"] objectForKey:@"user_id"]);
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[[tempDict objectForKey:@"properties"] objectForKey:@"user_id"] forKey:@"twitter_id"];
        [defaults setObject:twitterAccount.username forKey:@"twitter_username"];
        [defaults synchronize];
        
       
        
        [self twitterDidLogin];
    }
}

-(void)PickerCancelled {
    
    [self twitterDidNotLogin];
}

-(void)pickerSelectedRow:(int)row {
    
    //NSLog(@"pickerSelectedRow");
    
    self.twitterAccount=[arrayOfAccounts objectAtIndex:row];
	NSDictionary *tempDict = [[NSMutableDictionary alloc] initWithDictionary:[twitterAccount dictionaryWithValuesForKeys:[NSArray arrayWithObject:@"properties"]]];
    
    // NSLog(@"properties %@",twitterAccount.username);
    // NSLog(@"user_id %@",[[tempDict objectForKey:@"properties"] objectForKey:@"user_id"]);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[[tempDict objectForKey:@"properties"] objectForKey:@"user_id"] forKey:@"twitter_id"];
    [defaults setObject:twitterAccount.username forKey:@"twitter_username"];
    [defaults synchronize];
    
    [self twitterDidLogin];
}

- (void)twitterDidLogin {
    
    if ([twitterHandler respondsToSelector:@selector(successTwitterLogin)]){
        [twitterHandler performSelector:@selector(successTwitterLogin)];
    }
}

- (void)twitterDidNotLogin{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"" forKey:@"twitter_id"];
    [defaults synchronize];
    
    if ([twitterHandler respondsToSelector:@selector(failureTwitterLogin)]){
        [twitterHandler performSelector:@selector(failureTwitterLogin)];
    }
}


#pragma mark -
#pragma mark  Facebook methods

-(void) allocateFacebook {
    
    if (facebook) {
        [facebook logout];
        facebook=nil;
        facebook=NULL;
    }
    
    facebook=[[Facebook alloc] initWithAppId:FACEBOOK_APP_ID andDelegate:self];
    
    // Check and retrieve authorization information
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:@"FBAccessTokenKey"] && [defaults objectForKey:@"FBExpirationDateKey"]) {
        
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }

}

- (void) clearFBCache {
    
    // NSLog(@"clearFBCache");
    [self allocateFacebook];
    [self.facebook logout:self];
    
    NSHTTPCookieStorage* cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    NSArray* facebookCookies = [cookies cookiesForURL:
                                [NSURL URLWithString:@"http://login.facebook.com"]];
    
    for (NSHTTPCookie* cookie in facebookCookies) {
        // NSLog(@"login.facebook %@",cookie.description);
        [cookies deleteCookie:cookie];
    }
    
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        NSString* domainName = [cookie domain];
        NSRange domainRange = [domainName rangeOfString:@"facebook"];
        if(domainRange.length > 0)
        {
            //  NSLog(@"facebook %@",cookie.description);
            [storage deleteCookie:cookie];
        }
    }
}

- (void) checkFacebookLoginCall : (NSObject*) handler {
    
    if (facebookHandler) {
        facebookHandler=nil;
    }
    self.facebookHandler = handler;
    
    if (!facebook) {
        [MY_APP_DELEGATE allocateFacebook];
    }
    
    //    facebook.accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"FBAccessTokenKey"];
    //    facebook.expirationDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"FBExpirationDateKey"];
    
    if ([[MY_APP_DELEGATE facebook] isSessionValid]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults objectForKey:@"FBAccessTokenKey"] && [defaults objectForKey:@"FBExpirationDateKey"]) {
            if ([facebookHandler respondsToSelector:@selector(successFacebookLogin)]){
                [facebookHandler performSelector:@selector(successFacebookLogin)];
                return;
            }
        }
    }
    
    [[MY_APP_DELEGATE facebook] authorize:[NSArray arrayWithObjects:@"publish_actions",@"share_item",@"status_update",@"publish_stream",@"offline_access",@"email" ,nil]];
}

#pragma mark  FBSessionDelegate Methods
/**
 * Called when the user has logged in successfully.
 */
- (void)fbDidLogin {
    
    //    NSLog(@"fbDidLogin");
    
    if ([facebookHandler respondsToSelector:@selector(successFacebookLogin)]){
        [facebookHandler performSelector:@selector(successFacebookLogin)];
    }
    [self storeAuthData:[[MY_APP_DELEGATE facebook] accessToken] expiresAt:[[MY_APP_DELEGATE facebook] expirationDate]];
}

- (void)fbDidNotLogin:(BOOL)cancelled {
    
    //     NSLog(@"fbDidNotLogin cancelled=%d",cancelled);
    if ([facebookHandler respondsToSelector:@selector(failureFacebookLogin)]){
        [facebookHandler performSelector:@selector(failureFacebookLogin)];
    }
}

-(void)fbDidExtendToken:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
    //////NSLog(@"token extended");
    [self storeAuthData:accessToken expiresAt:expiresAt];
}

- (void)fbDidLogout {
    
    // Remove saved authorization information if it exists and it is
    // ok to clear it (logout, session invalid, app unauthorized)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"FBAccessTokenKey"];
    [defaults removeObjectForKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}

- (void)fbSessionInvalidated {
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Auth Exception"
                              message:[@"Your session has expired."capitalizedString]
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil,
                              nil];
    [alertView show];
    [self fbDidLogout];
}

- (void)storeAuthData:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
    
    // NSLog(@"expiresAt=%@",expiresAt);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:accessToken forKey:@"FBAccessTokenKey"];
    [defaults setObject:expiresAt forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}


#pragma mark - Application delegate

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [self allocateFacebook];
    [[self facebook] extendAccessTokenIfNeeded];
    
//    [[GPPSignIn sharedInstance] trySilentAuthentication];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//    
//    DLog(@"url=%@",url);
//    return [self.facebook handleOpenURL:url];
//}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    DLog(@"url=%@",url);
    DLog(@"sourceApplication=%@",sourceApplication);
    
    if ([[url absoluteString] rangeOfString:APP_ID].location == NSNotFound)// check
    {
        return [self.facebook handleOpenURL:url];
    }

    return NO;
}


#pragma mark - Push Notification

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    if (error.code == 3010) {
        NSLog(@"Push notifications are not supported in the iOS Simulator.");
    } else {
        // show some alert or otherwise handle the failure to register.
        NSLog(@"application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
    
}


@end
