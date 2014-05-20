//
//  DiscountViewController.m
//  Discount
//
//  Created by Jason Merchant on 1/15/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "DiscountViewController.h"
#import "search.h"
#import "AppDelegate.h"
#import "LeftMenu.h"
#import "DiscountNow.h"
#import "Map.h"

@interface DiscountViewController () {

    UIImage *mapImage,*listImage;
    ViewController *viewController;
    BOOL isProfileShowing;
    
    CGRect screenFrame,leftScreenframe,rightScreenframe;
    
    NSUInteger lastSelectedIndex;
    
}

@end

@implementation DiscountViewController

@synthesize sidebarButton, imageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger) supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = RGB(244, 243, 237);
    self.topbarView.backgroundColor = TOPBAR_BG_COLOR;

    [self.view setUserInteractionEnabled:YES];
    
    [MY_APP_DELEGATE setDiscountViewController:self];
    
    self.statusBarBg.backgroundColor = STATUS_BAR_COLOR;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 320, self.view.frame.size.height - 64)];
    //bgView.backgroundColor = [UIColor redColor];
    [self.view addSubview:bgView];
    
    viewController = MY_APP_DELEGATE.viewController;
    
    if (self.mainTabBarCtr.view.superview==nil) {
        self.mainTabBarCtr = [self.storyboard instantiateViewControllerWithIdentifier:@"MainTabbar"];
        [self.view addSubview:self.mainTabBarCtr.view];
        self.mainTabBarCtr.view.backgroundColor = VIEW_BG_COLOR;
        self.mainTabBarCtr.tabBar.tintColor = TOPBAR_BG_COLOR;
        self.mainTabBarCtr.delegate=self;
        self.mainTabBarCtr.selectedIndex = 2;
        lastSelectedIndex=2;
    }
    
    self.DiscountNowNav = [self.mainTabBarCtr.viewControllers objectAtIndex:2];
    
    self.MapNav = [self.mainTabBarCtr.viewControllers objectAtIndex:1];
    
    self.SavedNavi = [self.mainTabBarCtr.viewControllers objectAtIndex:4];
    
    self.selectedNavi = self.DiscountNowNav;
    
    self.discountNow = (DiscountNow*)self.DiscountNowNav.topViewController;
    
    self.profileBtn.layer.cornerRadius = 17;
    self.profileBtn.clipsToBounds = YES;
    
//    mapImage = [UIImage imageNamed:@"tab_map.png"];
//    listImage = [UIImage imageNamed:@"tab_list.png"];
    
    self.backBtn.alpha=0;
    
    [self setDiscountsBadge:14];
    
   [self bringCommonOptionsWithTopbar:YES];
}

#pragma mark - Badge

- (void) setDiscountsBadge:(int) value {

    [[[self.mainTabBarCtr.viewControllers objectAtIndex:4] tabBarItem] setBadgeValue:[NSString stringWithFormat:@"%d",value]];
}

- (void) increaseDiscountBadge {

    int currentValue =[[[[self.mainTabBarCtr.viewControllers objectAtIndex:4] tabBarItem] badgeValue] intValue];
    [self setDiscountsBadge:currentValue+1];
}

#pragma mark - Left button

- (void) hideLeftButton:(BOOL) yes {
    
    self.sidebarButton.alpha=!yes;
}

#pragma mark - Back

- (void) showBackButton: (BOOL) yes {
    
    [self.view endEditing:YES];
    [MY_APP_DELEGATE.rootVC setPanGestureEnabled:!yes];

    [UIView animateWithDuration:0.3 animations:^{

        self.backBtn.alpha=yes;
        self.sidebarButton.alpha = !yes;
    }];
    

//    [UIView animateWithDuration:0.3 animations:^{
//    
//        if (yes)
//            self.sidebarButton.alpha = 0;
//        else
//            self.backBtn.alpha=0;
//    
//    } completion:^(BOOL finished ){
//        
//        [UIView animateWithDuration:0.3 animations:^{
//            
//            if (yes)
//                self.backBtn.alpha=1;
//            else
//                self.sidebarButton.alpha = 1;
//            
//        }];
//    }];
    
}

- (IBAction)backButtonTapped:(id)sender
{
    DLog(@"%@",self.selectedNavi);
    DLog(@"%@",self.selectedNavi.viewControllers);
    
    [self.selectedNavi popViewControllerAnimated:YES];
    
   [self showBackButton:!([self.selectedNavi.viewControllers count]<2)];
}

- (void) bringCommonOptionsWithTopbar:(BOOL) yes {
    
    [self.view bringSubviewToFront:self.statusBarBg];
    
    if (yes) {
        [self.view bringSubviewToFront:self.backBtn];
        [self.view bringSubviewToFront:self.profileBtn];
        [self.view bringSubviewToFront:self.sidebarButton];
    }else {
        [self.view sendSubviewToBack:self.backBtn];
        [self.view sendSubviewToBack:self.profileBtn];
        [self.view sendSubviewToBack:self.sidebarButton];
    }
    
    [self showBackButton:!([self.selectedNavi.viewControllers count]<2)];
}

#pragma mark - Menu

- (IBAction)sidebarTapped:(id)sender
{
    if (self.discountNow.sortBtn.isSelected) { // Hide
        [self.discountNow hideSortView];
    }
    
     [self.sideMenuViewController presentMenuViewController];
}

#pragma mark - Profile

- (UIImage*) getScreenShot {
    
    UIImage *viewSnapShot;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7")) {
        
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale); // @2x image
        [self.view drawViewHierarchyInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) afterScreenUpdates:YES];
        viewSnapShot = UIGraphicsGetImageFromCurrentImageContext ();
        UIGraphicsEndImageContext ();
    }else {
        
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        viewSnapShot= UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    NSString *stringPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"New Folder"];
    // New Folder is your folder name
    NSError *error = nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:stringPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:stringPath withIntermediateDirectories:NO attributes:nil error:&error];
    
    NSString *fileName = [stringPath stringByAppendingFormat:@"/image.png"];
    NSData *data = UIImagePNGRepresentation(viewSnapShot);
    [data writeToFile:fileName atomically:YES];

    
    return viewSnapShot;
}

- (IBAction)profileBtnTapped:(id)sender
{
    if (self.discountNow.sortBtn.isSelected) { // Hide
        [self.discountNow hideSortView];
    }
    
    screenFrame = self.view.bounds;
    
    leftScreenframe = screenFrame;
    leftScreenframe.origin.x = -320;
    
    rightScreenframe = screenFrame;
    rightScreenframe.origin.x = 320;
    
    if (!_screenShotImg) {
        _screenShotImg = [[UIImageView alloc] init];
        _screenShotImg.userInteractionEnabled=NO;
    }
    
    self.screenShotImg.frame = screenFrame;
    [self.screenShotImg setImage:[self getScreenShot]];
    
    if (self.profileNavi.view.superview==nil) {
        self.profileNavi = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileNavi"];
        [self.view addSubview:self.profileNavi.view];
        self.profileNavi.view.backgroundColor = STATUS_BAR_COLOR;
    }
    
    self.profileNavi.view.frame = rightScreenframe;
    
    [self.view addSubview:_screenShotImg];
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.profileNavi.view.frame = screenFrame;
                         self.screenShotImg.frame = leftScreenframe;
                     }
                     completion:^(BOOL finished){
                     }];
    
    isProfileShowing=YES;
    
    [self bringCommonOptionsWithTopbar:NO];
    
    [self.view bringSubviewToFront:self.statusBarBg];
    
    [MY_APP_DELEGATE.rootVC setPanGestureEnabled:NO];
}

- (void) removeProfileScreen {
    
    isProfileShowing=NO;

    [UIView animateWithDuration:0.3
                     animations:^{
                         self.profileNavi.view.frame = rightScreenframe;
                         self.screenShotImg.frame = screenFrame;
                     }
                     completion:^(BOOL finished){
                         [_screenShotImg removeFromSuperview];
                        
                         [self bringCommonOptionsWithTopbar:YES];
                         
                         if (lastSelectedIndex == 3 || lastSelectedIndex == 4) {
                             if ([[self.selectedNavi viewControllers] count]==1) {
                                 [self hideLeftButton:YES];
                             }
                         }
                     }];
}

#pragma mark - Tab Bar

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)SelviewController NS_AVAILABLE_IOS(3_0) {
    
//    DLog(@"tabBarController.selectedIndex %lu",(unsigned long)tabBarController.selectedIndex);
    
    UINavigationController *navi = (UINavigationController*) SelviewController;
    
//    DLog(@"topViewController %@",navi.topViewController);
    
    if (tabBarController.selectedIndex == 1) {
        
        if ([navi isEqual:self.MapNav]){
            return NO;
        }
    
        if ([navi isEqual:self.DiscountNowNav]){
            
            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        
            UIView * fromView = tabBarController.selectedViewController.view;
            UIView * toView = [[tabBarController.viewControllers objectAtIndex:2] view];
            
            // Transition using a page curl.
            [UIView transitionFromView:fromView
                                toView:toView
                              duration:0.8
                               options:UIViewAnimationOptionTransitionFlipFromLeft
                            completion:^(BOOL finished) {
                                if (finished) {
                                    tabBarController.selectedIndex = 2;
                                    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                                }
                            }];
        
        }
    
    }else if (tabBarController.selectedIndex == 2) {
        
        if ([navi isEqual:self.DiscountNowNav]){
            return NO;
        }
    
        if ([navi isEqual:self.MapNav]){
            
            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
            
            UIView * fromView = tabBarController.selectedViewController.view;
            UIView * toView = [[tabBarController.viewControllers objectAtIndex:1] view];
            
            // Transition using a page curl.
            [UIView transitionFromView:fromView
                                toView:toView
                              duration:0.8
                               options:UIViewAnimationOptionTransitionFlipFromRight
                            completion:^(BOOL finished) {
                                if (finished) {
                                    tabBarController.selectedIndex = 1;
                                    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                                }
                            }];
        }
    }
    
    return YES;

}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)nav_viewController {
    
    [self changeSelectedTab:(int)tabBarController.selectedIndex];
}

- (void) changeSelectedTab:(int) selectedTabIndex {
    
    self.mainTabBarCtr.selectedIndex =selectedTabIndex;
    
    self.selectedNavi = (UINavigationController*)[[self.mainTabBarCtr viewControllers] objectAtIndex:selectedTabIndex];
    [self bringCommonOptionsWithTopbar:self.mainTabBarCtr.selectedIndex!=0];
    
    if (selectedTabIndex == 3 || selectedTabIndex == 4) {
        
        if ([[self.selectedNavi viewControllers] count]==1) {
            [self hideLeftButton:YES];
        }
    }
    
    
    lastSelectedIndex = self.mainTabBarCtr.selectedIndex;

}



@end
