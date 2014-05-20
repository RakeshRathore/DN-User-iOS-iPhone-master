//
//  video.m
//  Groopling
//
//  Created by Sajith KG on 30/08/13.
//
//

#import "video.h"
#import <MediaPlayer/MediaPlayer.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

@interface video ()

@end

@implementation video
@synthesize videoId,webView,actind,label,actView,cancelBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
            self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.clipsToBounds = TRUE;
    
    [label setHidden:NO];
    [actind startAnimating];
    [actView setHidden:NO];
     
    actView.backgroundColor = [UIColor clearColor];
    webView.scrollView.scrollEnabled=NO;
    webView.opaque = NO;
    [self.view addSubview:webView];
    webView.alpha=0;
    
    self.webView.allowsInlineMediaPlayback = YES;
    self.webView.mediaPlaybackRequiresUserAction = NO;
    
    cancelBtn.backgroundColor=[UIColor clearColor];
    cancelBtn.clipsToBounds=YES;
    cancelBtn.layer.cornerRadius=4;
    cancelBtn.layer.borderColor=[[UIColor whiteColor]CGColor];
    cancelBtn.layer.borderWidth=1;
    
    [self startVideo];
}


- (void) startVideo {
    
    [actView setHidden:NO];
    [label setHidden:NO];
    [actind startAnimating];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayFinished:) name:@"UIMoviePlayerControllerWillExitFullscreenNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayStarted:) name:@"UIMoviePlayerControllerDidEnterFullscreenNotification" object:nil];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"youtube" ofType:@"html"];
    NSError *error;
    NSString *string = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    string = [NSString stringWithFormat:string,@"320",@"330",  self.videoId];
    NSData *htmlData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSString *documentsDirectoryPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *targetPath = [documentsDirectoryPath stringByAppendingPathComponent:@"youtube.html"];
    [htmlData writeToFile:targetPath atomically:YES];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:targetPath]]];
    
    NSStringEncoding encoding;
    DLog(@"%@",[NSString stringWithContentsOfFile:targetPath  usedEncoding:&encoding  error:NULL]);
}

-(void)viewDidAppear:(BOOL)animated{
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
}
-(IBAction)cancelLoading:(UIButton *)sender{
    [label setHidden:YES];
    [actView setHidden:YES];
    [actind stopAnimating];
    
    [MY_APP_DELEGATE.rootVC dismissViewControllerAnimated:YES completion:nil];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}
-(void)webView:(UIWebView *)webview didFailLoadWithError:(NSError *)error{
    
    DLog(@"%@ %@",webView,error);

    [label setHidden:YES];
    [actView setHidden:YES];
    [actind stopAnimating];
    
    [MY_APP_DELEGATE.rootVC dismissViewControllerAnimated:YES completion:nil];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

- (BOOL)webView:(UIWebView *)webview shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    DLog(@"%@",webView);
    if ([[[request URL] scheme] isEqualToString:@"callback"]) {
        
        DLog(@"callback  %@",webView);
        
        NSString *documentsDirectoryPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *targetPath = [documentsDirectoryPath stringByAppendingPathComponent:@"youtube.html"];
        NSError *error;
        [[NSFileManager defaultManager] removeItemAtPath:targetPath error:&error];
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView1 {

    DLog(@"%@",webView1);

}
- (void)webViewDidFinishLoad:(UIWebView *)webView1 {


    DLog(@"%@",webView1);
}

-(void)videoPlayStarted:(NSNotification *)notification{
  	
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:0.25
                              delay:0
                            options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             self.actView.transform = CGAffineTransformScale(self.actView.transform, 0.8, 0.8);
                             self.actView = 0;
                         }
                         completion:^(BOOL finished){
                             if(actView.alpha == 0) {
                                 [label setHidden:YES];
                                 [actind stopAnimating];
                                 actView.alpha=1;
                             }
                         }];
    });
}


-(void)videoPlayFinished:(NSNotification *)notification{
    [label setHidden:YES];
    [actind stopAnimating];
    [actView setHidden:YES];
    CGFloat systemVersion = [[[ UIDevice currentDevice ] systemVersion ] floatValue ];
    
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait){
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    }
    
    if (systemVersion >= 6.0)
    {
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
        [[UIDevice currentDevice] performSelector:@selector(setOrientation:) withObject:(__bridge id)((void*)UIInterfaceOrientationPortrait)];
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    
    [MY_APP_DELEGATE.rootVC dismissViewControllerAnimated:YES completion:nil];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
    
}

@end

