//
//  RootVC.h
//  Discount
//
//  Created by Sajith KG on 28/01/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "SubCategories.h"

@interface RootVC : RESideMenu


@property (nonatomic,strong) SubCategories *subCategories;
@property (nonatomic,strong) UIImageView *screenShotImg;

- (void) showSubCategoryView:(NSDictionary*) selectedCategoryDetail;
- (void) hideSubCategoryViewWithAnimation: (BOOL) yes;

@end
