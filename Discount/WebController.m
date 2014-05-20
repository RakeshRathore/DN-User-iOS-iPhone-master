//
//  Help.m
//  Discount
//
//  Created by Sajith KG on 24/02/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "WebController.h"

@interface WebController () {

    IBOutlet UIWebView *webView;
    IBOutlet UIActivityIndicatorView *activity;
    
    IBOutlet UIToolbar* mToolbar;
    IBOutlet UIBarButtonItem* mBack;
    IBOutlet UIBarButtonItem* mForward;
    IBOutlet UIBarButtonItem* mRefresh;
    IBOutlet UIBarButtonItem* mStop;
}

@end

@implementation WebController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(IBAction)backBtnCall:(id)sender {
    
    [webView stopLoading];
    activity.alpha = 0;
    [activity stopAnimating];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = VIEW_BG_COLOR;
    self.topbarView.backgroundColor = TOPBAR_BG_COLOR;
    self.viewHdr.font = LATO_REGULAR(18);
    
    self.viewHdr.text = self.titleStr;
    
    mToolbar.tintColor = STATUS_BAR_COLOR;
    
    [self setUrlToLoad:[NSURLRequest requestWithURL:[NSURL URLWithString:[Global getWebPageUrlString:self.webPageType]]]];
}

- (void) setUrlToLoad:(NSURLRequest *)urlToLoads {
    
    //[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
    [webView loadRequest:urlToLoads];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    activity.alpha = 1;
    [activity startAnimating];
     [self updateButtons];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    activity.alpha = 0;
    [activity stopAnimating];
     [self updateButtons];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateButtons];
}

- (void)updateButtons
{
    mForward.enabled = webView.canGoForward;
    mBack.enabled = webView.canGoBack;
    mStop.enabled = webView.loading;
}

@end
