//
//  video.h
//  Groopling
//
//  Created by Sajith KG on 30/08/13.
//
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AppDelegate.h"
@interface video : UIViewController <UIWebViewDelegate>{
    IBOutlet UIWebView *webView;
    NSString *videoId;
     
}
@property(nonatomic,strong)IBOutlet UIActivityIndicatorView *actind;
@property(nonatomic,strong)IBOutlet UILabel *label;
@property(nonatomic,strong)IBOutlet UIView *actView;
@property(nonatomic,strong)IBOutlet UIButton *cancelBtn;
@property(nonatomic,retain) IBOutlet UIWebView *webView;
@property(retain)NSString *videoId;

-(IBAction)cancelLoading:(UIButton *)sender;
@end

