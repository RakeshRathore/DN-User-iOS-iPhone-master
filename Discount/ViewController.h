//
//  ViewController.h
//  Discount
//
//  Created by Jason Merchant on 1/13/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) IBOutlet UIView *bottomView;

@property (nonatomic, strong) IBOutlet UIButton *skipBtn;

@property (nonatomic, strong) UINavigationController *signInNavi;

@property (nonatomic, strong) NSArray *imageArray;

- (IBAction)skipTapped:(id)sender;

-(void) ShowHomePage ;
-(void) signUpCall;
-(void) loginCall;

@end
