//
//  RootVC.m
//  Discount
//
//  Created by Sajith KG on 28/01/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "RootVC.h"
#import "AppDelegate.h"
#import "LeftMenu.h"


@interface RootVC () {

    CGRect screenFrame,leftScreenframe,rightScreenframe;
}

@end

@implementation RootVC

- (void)awakeFromNib
{
    [MY_APP_DELEGATE setRootVC:self];
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DiscountViewController_id"];
    self.menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"menuController"];
    //self.backgroundImage = [UIImage imageNamed:@"Stars"];
    self.view.backgroundColor = RGB(24, 40, 61);
    self.delegate = (LeftMenu *)self.menuViewController;
    
    self.panFromEdge=YES;
    self.panGestureEnabled=NO;
}

- (NSUInteger) supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
    
}

- (void) showSubCategoryView :(NSDictionary*) selectedCategoryDetail{
    
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
    
    if (!_subCategories) {
        _subCategories = [[SubCategories alloc] initWithNibName:@"SubCategories" bundle:nil];
        [self.view addSubview:self.subCategories.view];
    }
    
    self.subCategories.view.frame = leftScreenframe;
    
    [self.view addSubview:_screenShotImg];
    
    [self.subCategories setCategoryDetails:selectedCategoryDetail];
    [self.subCategories resetSubCategories];

    [UIView animateWithDuration:0.4
                     animations:^{
                         self.subCategories.view.frame = screenFrame;
                         self.screenShotImg.frame = rightScreenframe;
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

- (void) hideSubCategoryViewWithAnimation: (BOOL) yes {
    
    if (yes) {
        [UIView animateWithDuration:0.4
                         animations:^{
                             self.subCategories.view.frame = leftScreenframe;
                             self.screenShotImg.frame = screenFrame;
                         }
                         completion:^(BOOL finished){
                             [_screenShotImg removeFromSuperview];
                         }];
    }else {
    
        self.subCategories.view.frame = leftScreenframe;
        self.screenShotImg.frame = screenFrame;
        [_screenShotImg removeFromSuperview];
    }
}

- (UIImage*) getScreenShot {
    
    UIImage *viewSnapShot;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7")) {
        
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale); // @2x image
        //UIGraphicsBeginImageContext (self.view.frame.size);
        //new iOS 7 method to snapshot
        [self.view drawViewHierarchyInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) afterScreenUpdates:YES];
        viewSnapShot = UIGraphicsGetImageFromCurrentImageContext ();
        UIGraphicsEndImageContext ();
    }else {
        
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        viewSnapShot= UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
//    NSString *stringPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"New Folder"];
//    // New Folder is your folder name
//    NSError *error = nil;
//    if (![[NSFileManager defaultManager] fileExistsAtPath:stringPath])
//        [[NSFileManager defaultManager] createDirectoryAtPath:stringPath withIntermediateDirectories:NO attributes:nil error:&error];
//    
//    NSString *fileName = [stringPath stringByAppendingFormat:@"/image.png"];
//    NSData *data = UIImagePNGRepresentation(viewSnapShot);
//    [data writeToFile:fileName atomically:YES];
    
    return viewSnapShot;
}

@end
