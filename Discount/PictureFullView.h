//
//  PictureFullView.h
//  Discount
//
//  Created by Sajith KG on 20/02/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureFullView : UIViewController <UIScrollViewDelegate>

@property (readwrite) int currentIndex;

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *viewControllers,*imageArray;

@property (strong, nonatomic) IBOutlet UIButton *nextBtn,*prevBtn;

- (id)initWithImageArray:(NSMutableArray*)imageNameArray  andSelectedIndex:(int) currentImageNo;


@end
