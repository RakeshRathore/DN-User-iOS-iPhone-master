//
//  LoginViewController.m
//  Discount
//
//  Created by Jason Merchant on 1/13/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "LoginViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"

@interface LoginViewController (){

    UIImageView *animationImageView;
    ViewController *viewController;

}

@end

@implementation LoginViewController



-(void)LoginCalled
{
    if ([_emailAddress.text length]==0  || ![self validateEmailAddress:_emailAddress.text])
    {
        if ([_emailAddress.text length]==0)
            [AppDelegate showWithTitle:appName message:@"Please enter an email."];
        
        else if(![self validateEmailAddress:_emailAddress.text])
            [AppDelegate showWithTitle:appName message:@"Please enter an valid email."];
        [animationImageView removeFromSuperview];
    }
    else if (_passWord.text.length  == 0)
    {
        [AppDelegate showWithTitle:appName message:@"Please enter password."];
        [animationImageView removeFromSuperview];
    }
    else if (_passWord.text.length < 8)
    {
        [AppDelegate showWithTitle:appName message:@"Please enter password having minimum 8 characters."];
        [animationImageView removeFromSuperview];
    }
    else
    {
        
        
        NSString *str1              = [NSString stringWithFormat:@"user[email]=%@&user[password]=%@",_emailAddress.text,_passWord.text];
        
        NSString *str               =   [[NSString alloc]initWithFormat:@"%@/users/sign_in.json",MAIN_URL];
        
        NSURL *url                  =   [NSURL URLWithString:str];
        
        NSMutableURLRequest *req    = [NSMutableURLRequest requestWithURL:url];
        req.timeoutInterval = 30;
        
        [req setHTTPMethod:@"POST"];
        
        NSString *requestBodyString = [NSString stringWithFormat:@"%@",str1];
        
        NSData *requestBody         = [requestBodyString dataUsingEncoding:NSUTF8StringEncoding];
        
        [req setHTTPBody:requestBody];
        
        
        
        NSURLResponse* response;
        NSError* error;
        
        NSData* result = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error];
        
        NSString * rsltStr;
        
        
        rsltStr = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
        
        
        
        NSLog(@"RESULT ##### :: %@",rsltStr);
        
        
        
        if (error)
        {
            NSDictionary *dict  =   [rsltStr JSONValue];
            
            
            if ([[dict valueForKeyPath:@"success"] boolValue]==0)
                [AppDelegate showWithTitle:appName message:[dict valueForKeyPath:@"message"]];
            else
                [AppDelegate showWithTitle:appName message:@"login Failed"];
            [animationImageView removeFromSuperview];
        }
        else
        {
            
            NSDictionary *dict  =   [rsltStr JSONValue];
            
            
            if ([[dict valueForKeyPath:@"success"] boolValue]==1)
            {
                
                [self performSelector:@selector(loginSuccess) withObject:self afterDelay:1];
            }
            else
            {
                
                [AppDelegate showWithTitle:appName message:@"Error with your login or password"];
                [animationImageView removeFromSuperview];
                
                
                
            }
        }
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    
    [self.loginBtn.titleLabel setFont:LATO_BOLD(18)];
    self.loginBtn.backgroundColor = TOPBAR_BG_COLOR;
    
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:0];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [self.facebookBtn setBackgroundColor:[UIColor clearColor]];
    [self.twitterBtn setBackgroundColor:[UIColor clearColor]];
    
    [self.facebookBtn.titleLabel setFont:LATO_REGULAR(13)];
    [self.twitterBtn.titleLabel setFont:LATO_REGULAR(13)];
    [self.forgetPasswordBtn.titleLabel setFont:LATO_REGULAR(13)];
    [self.signUpBtn.titleLabel setFont:LATO_REGULAR(13)];
    
    [self.signUpBtn setTitleColor:TOPBAR_BG_COLOR forState:0];
    
    viewController = MY_APP_DELEGATE.viewController;
    
    [self ChangeFrames];
    
}

- (void) viewWillAppear:(BOOL)animated
{
//    CATransition *animation = [CATransition animation];
//    
//    [animation setDelegate:self];
//    [animation setType:kCATransitionPush];
//    [animation setSubtype:kCATransitionFromRight];
//    
//    [animation setDuration:0.40];
//    [animation setTimingFunction:
//     [CAMediaTimingFunction functionWithName:
//      kCAMediaTimingFunctionEaseInEaseOut]];
//    
//    
//    [self.view.layer addAnimation:animation forKey:kCATransition];
}

- (IBAction)loginTapped:(id)sender
{
    [self.view endEditing:YES];
    
    self.loginBtn.backgroundColor = TOPBAR_BG_COLOR;
    
    NSArray *imageNames = @[@"loading1.png", @"loading2.png", @"loading3.png", @"loading4.png",
                            @"loading5.png", @"loading6.png", @"loading7.png", @"loading8.png"];
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 0; i < imageNames.count; i++) {
        [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
    }
    
    // Normal Animation
    animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(290, 12, 19, 19)];
    animationImageView.alpha = 0.0;
    animationImageView.animationImages = images;
    animationImageView.animationDuration = 0.5;
    [self.loginBtn addSubview:animationImageView];
    [animationImageView startAnimating];
  
    [self.loginBtn setTitle:@"Logging in" forState:0];
    animationImageView.alpha = 1.0;
   [self LoginCalled];
    //[self performSelector:@selector(loginSuccess) withObject:nil afterDelay:3];

}

- (void) loginSuccess {
    
    [self.loginBtn setTitle:@"Login Successful!" forState:0];
    self.loginBtn.backgroundColor = RGB(26, 193, 20);
    [animationImageView removeFromSuperview];

    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        if([viewController respondsToSelector:@selector(ShowHomePage)])
        {
            [viewController ShowHomePage];
        }
    });
}

-(IBAction)signUpTapped
{
    if([viewController respondsToSelector:@selector(signUpCall)])
    {
        [viewController signUpCall];
    }
}

-(IBAction)skipBtnTapped
{
    if([viewController respondsToSelector:@selector(ShowHomePage)])
    {
        [viewController ShowHomePage];
    }
}

- (void) ChangeFrames {
    
    if (![Global isIPhone5]) {
        
        self.logoImageView.frame = CGRectMake(self.logoImageView.frame.origin.x, 51, self.logoImageView.frame.size.width, self.logoImageView.frame.size.height);
        self.emailAddress.frame = CGRectMake(self.emailAddress.frame.origin.x, 126, self.emailAddress.frame.size.width, self.emailAddress.frame.size.height);
        self.passWord.frame = CGRectMake(self.passWord.frame.origin.x, self.emailAddress.frame.origin.y+self.emailAddress.frame.size.height+1, self.passWord.frame.size.width, self.passWord.frame.size.height);
        self.loginBtn.frame = CGRectMake(self.loginBtn.frame.origin.x, 228, self.loginBtn.frame.size.width, self.loginBtn.frame.size.height);
        self.facebookBtn.frame = CGRectMake(self.facebookBtn.frame.origin.x, 288, self.facebookBtn.frame.size.width, self.facebookBtn.frame.size.height);
        self.twitterBtn.frame = CGRectMake(self.twitterBtn.frame.origin.x, 346, self.twitterBtn.frame.size.width, self.twitterBtn.frame.size.height);
        self.forgetPasswordBtn.frame = CGRectMake(self.forgetPasswordBtn.frame.origin.x, 408, self.forgetPasswordBtn.frame.size.width, self.forgetPasswordBtn.frame.size.height);
        self.signUpBtn.frame = CGRectMake(self.signUpBtn.frame.origin.x, 440, self.signUpBtn.frame.size.width, self.signUpBtn.frame.size.height);
    }
}

#pragma mark  UITextfield

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark
#pragma mark TWITTER

- (IBAction) twitterBtnCall {
    
    [MY_APP_DELEGATE checkTwitterLogin:self];
}

- (void) successTwitterLogin {
    
    NSLog(@"successTwitterLogin");
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:appName
                              message:[NSString stringWithFormat:@"Username:%@ \n UserID:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"twitter_username"],[[NSUserDefaults standardUserDefaults] objectForKey:@"twitter_id"]]
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil,
                              nil];
    [alertView show];
}

- (void) failureTwitterLogin {
    
    NSLog(@"failureTwitterLogin");
}

#pragma mark - FACEBOOK

- (IBAction)facebookCall:(id)sender {
    
    [MY_APP_DELEGATE checkFacebookLoginCall:self];
}

#pragma mark  Login With Facebook

- (void) successFacebookLogin {
    
    //      NSLog(@"successFacebookLogin");
    
    // updating data to server functionality here
    [Loading showWithStatus:@"Fetching data..."];
    [self apiFQLIMe];
    
}

- (void) failureFacebookLogin {
    
    //      NSLog(@"failureFacebookLogin");
}

- (void)apiFQLIMe {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"SELECT uid,username,email FROM user WHERE uid=me()", @"query",
                                   nil];
    [[MY_APP_DELEGATE facebook] requestWithMethodName:@"fql.query"
                                            andParams:params
                                        andHttpMethod:@"POST"
                                          andDelegate:self];
}

#pragma mark  FBRequestDelegate Methods

- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
    
}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    
    [Loading dismiss];
}

- (void)request:(FBRequest *)request didLoad:(id)result {
    
    [Loading dismiss];
    
    if ([result isKindOfClass:[NSArray class]]) {
        result = [result objectAtIndex:0];
    }
    
    // NSLog(@"request=%@",request.url);
    NSLog(@"result----%@",result);
    
    NSString *email=[[NSString alloc] initWithString:[NSString stringWithFormat:@"%@",[result objectForKey:@"email"]]];
    NSString *uid=[[NSString alloc] initWithString:[NSString stringWithFormat:@"%@",[result objectForKey:@"uid"]]];
    NSString *username=[[NSString alloc] initWithString:[NSString stringWithFormat:@"%@",[result objectForKey:@"username"]]];
    
    [self setFacebookEmailID:email];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:email forKey:@"email_id"];
    [dict setObject:username forKey:@"user_name"];
    [dict setObject:uid forKey:@"profile_id"];
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:appName
                              message:[NSString stringWithFormat:@"Username:%@ \n Email:%@",username,email]
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil,
                              nil];
    [alertView show];
    
    //    [Loading showWithStatus:@"Signing up..."];
    //
    //    DLog(@"dict=%@",dict);
    //
    //    wspcontinuous = [[WSPContinuous alloc] initWithRequestForThread:[WebServices postURLRequest:@"fbLogin" andFields:dict]
    //                                                                sel:@selector(finishedFacebookLogin:)
    //                                                         andHandler:self
    //                                                       andShowAlert:NO];
    //    wspcontinuous=nil;
}

- (BOOL)validateEmailAddress:(NSString*)yourEmail
{
    //create a regex string which includes all email validation
    NSString *emailRegex    = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    //create predicate with format matching your regex string
    NSPredicate *email  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    //return True if your email address matches the predicate just formed
    return [email evaluateWithObject:yourEmail];
}

@end
