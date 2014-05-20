//
//  PictureFullView.m
//  Discount
//
//  Created by Sajith KG on 20/02/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "PictureFullView.h"
#import "AppDelegate.h"
#import "PictureContent.h"

@interface PictureFullView () {

    BOOL isRotating;
}
@end

@implementation PictureFullView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithImageArray:(NSMutableArray*)imageNameArray  andSelectedIndex:(int) currentImageNo {
    
	self = [super init];
	if (self) {
        
        self.currentIndex = currentImageNo;
        self.imageArray = imageNameArray;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelBtnTapped:(id)sender {
    
    [MY_APP_DELEGATE.rootVC dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < [self.imageArray count] ;i++) {
        [controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * [self.imageArray count], self.scrollView.frame.size.height);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.delegate = self;
    
    isRotating=NO;
    
    [self loadScrollViewWithPage:self.currentIndex-1];
    [self loadScrollViewWithPage:self.currentIndex];
    [self loadScrollViewWithPage:self.currentIndex+1];
    
    [self scrollToCurrentPage];
}

- (void) scrollToCurrentPage {
    
//    DLog(@"%d",self.currentIndex);

    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * self.currentIndex;
    frame.origin.y = 0;
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * [self.imageArray count], self.scrollView.frame.size.height);
    [self.scrollView scrollRectToVisible:frame animated:NO];
    
    [self updatePreviousNextBtnStatus];
}

- (void) updatePreviousNextBtnStatus {
    
    self.prevBtn.hidden=NO;
    self.nextBtn.hidden=NO;
    
    if (self.currentIndex < 1) {
        self.prevBtn.hidden=YES;
    }
    if (self.currentIndex == [self.viewControllers count]-1) {
        self.nextBtn.hidden=YES;
    }
}

- (IBAction)nextBtnTapped:(UIButton*)sender {
    
    self.currentIndex = self.currentIndex+1;
    
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * self.currentIndex;
    frame.origin.y = 0;
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * [self.imageArray count], self.scrollView.frame.size.height);
    [self.scrollView scrollRectToVisible:frame animated:YES];
    
    [self updatePreviousNextBtnStatus];
}

- (IBAction)previousBtnTapped:(UIButton*)sender {
    
    self.currentIndex = self.currentIndex-1;
    
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * self.currentIndex;
    frame.origin.y = 0;
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * [self.imageArray count], self.scrollView.frame.size.height);
    [self.scrollView scrollRectToVisible:frame animated:YES];
    
    [self updatePreviousNextBtnStatus];
}

- (void)loadScrollViewWithPage:(int)page {
    
    if (page < 0) return;
    if (page >= [self.imageArray count]) return;
    
    PictureContent *controller = [self.viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null]) {
        
        if ([[self.imageArray objectAtIndex:page] isKindOfClass:[UIImage class]]) {
            controller = [[PictureContent alloc] initWithImage:[self.imageArray objectAtIndex:page]];
        }else {
            controller = [[PictureContent alloc] initWithImageName:[self.imageArray objectAtIndex:page]];
        }
        
        [self.viewControllers replaceObjectAtIndex:page withObject:controller];
    }

    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * [self.imageArray count], self.scrollView.frame.size.height);
    controller.view.frame = CGRectMake(self.scrollView.frame.size.width*page, 0, self.scrollView.frame.size.width,  self.scrollView.frame.size.height);
   	
    if (nil == controller.view.superview) {
        
        CGRect frame = self.scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [self.scrollView addSubview:controller.view];
//        DLog(@"controller=%@",controller);
//        DLog(@"self.scrollView=%@",self.scrollView);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
   // DLog(@"self.scrollView=%@",self.scrollView);
    
    if (!isRotating) {
        
        CGFloat pageWidth = self.scrollView.frame.size.width;
        
        int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        
        self.currentIndex=page;
        
        [self loadScrollViewWithPage:self.currentIndex-1];
        [self loadScrollViewWithPage:self.currentIndex];
        [self loadScrollViewWithPage:self.currentIndex+1];
        
        [self updatePreviousNextBtnStatus];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (BOOL)shouldAutorotate {
    return YES;
}
-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
                                duration:(NSTimeInterval)duration
{
    isRotating = YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromOrientation
{
    isRotating = NO;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width*self.currentIndex, 0);
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * [self.imageArray count], self.scrollView.frame.size.height);
    
    [self changeFrames];
    
    [self loadScrollViewWithPage:self.currentIndex];
    
    [self scrollToCurrentPage];
}

- (void) changeFrames {
    
    for (int i=0; i < [self.imageArray count]; i++) {
        
        PictureContent *controller = [self.viewControllers objectAtIndex:i];
        
        if ((NSNull *)controller == [NSNull null]) {
            continue;
        }
        
        controller.view.frame = CGRectMake(self.scrollView.frame.size.width*i, 0, self.scrollView.frame.size.width,  self.scrollView.frame.size.height);
    }
}



@end
