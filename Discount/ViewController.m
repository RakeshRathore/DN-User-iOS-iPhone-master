//
//  ViewController.m
//  Discount
//
//  Created by Jason Merchant on 1/13/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import "SignUp.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize scrollView;
@synthesize pageControl;
@synthesize imageArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [MY_APP_DELEGATE setViewController:self];
    
    self.view.backgroundColor = RGB(27, 34, 48);
    self.bottomView.backgroundColor = RGB(1, 144, 200);
    
    [[self.skipBtn titleLabel] setFont:LATO_REGULAR(14)];
    [self.skipBtn setTitleColor:RGB(233, 234, 235) forState:0];
    [self.skipBtn setTitleColor:RGB(233, 234, 235) forState:UIControlStateHighlighted];
    
    //Put the names of our image files in our array.
    //imageArray = [[NSArray alloc] initWithObjects:@"Tour1.png", @"Tour1.png", @"Tour1.png", @"Tour1.png", nil];
    imageArray = [[NSArray alloc] initWithObjects:@"tour_pic_1.png", @"tour_pic_1.png", @"tour_pic_1.png", @"tour_pic_1.png", nil];
    
    for (int i = 0; i < [imageArray count]; i++) {
        //We'll create an imageView object in every 'page' of our scrollView.
        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
        [self.scrollView addSubview:imageView];
    }
    //Set the content size of our scrollview according to the total width of our imageView objects.
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [imageArray count], scrollView.frame.size.height);
    
    if (self.signInNavi.view.superview==nil) {
        self.signInNavi = [self.storyboard instantiateViewControllerWithIdentifier:@"signInNavi"];
        self.signInNavi.view.backgroundColor = VIEW_BG_COLOR;
    }
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

- (IBAction)skipTapped:(id)sender
{
    
//    [self performSegueWithIdentifier:@"showHome" sender:self];
//    return; //boopa
    
    [self performSegueWithIdentifier:@"Model_signInNavi" sender:self];
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"Model_signInNavi"]) {
//        UINavigationController *navigationController = segue.destinationViewController;
//        LoginViewController *controller = (LoginViewController *)navigationController.topViewController;
//    }
//    
//    if ([segue.identifier isEqualToString:@"Model_signUpNavi"]) {
//        UINavigationController *navigationController = segue.destinationViewController;
//        SignUp *controller = (SignUp *)navigationController.topViewController;
//    }
//}

#pragma mark - Sign In delegates

-(void) signUpCall {
    
    [self dismissViewControllerAnimated:YES completion:^(void) {
        
        [self performSegueWithIdentifier:@"Model_signUpNavi" sender:self];
    }];
}

#pragma mark - Sign Up delegates

-(void) loginCall{
    
    [self dismissViewControllerAnimated:YES completion:^(void) {
        
        [self performSegueWithIdentifier:@"Model_signInNavi" sender:self];
    }];
}

#pragma mark - Show Home

-(void) ShowHomePage {
    
    [self dismissViewControllerAnimated:YES completion:^(void) {
        
        [self performSegueWithIdentifier:@"showHome" sender:self];
    }];
}

#pragma mark - Memory

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger) supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
    
}

@end
