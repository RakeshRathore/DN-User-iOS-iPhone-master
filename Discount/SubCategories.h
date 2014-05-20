//
//  SubCategories.h
//  Discount
//
//  Created by Sajith KG on 12/02/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SubCategories : UIViewController

@property (nonatomic,strong) IBOutlet UITableView *myTable;
@property (nonatomic,strong) IBOutlet UIImageView *iconView;
@property (nonatomic,strong) IBOutlet UILabel *categoryName;
@property (nonatomic,strong) IBOutlet UIButton *applyCategoriesBtn;

@property (nonatomic,strong) NSDictionary *categoryDetails;

- (void) resetSubCategories;

@end
