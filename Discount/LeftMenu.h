//
//  LeftMenu.h
//  Discount
//
//  Created by Sajith KG on 30/01/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"

@interface LeftMenu : UIViewController<RESideMenuDelegate>

@property (nonatomic,strong) IBOutlet UITableView *menuTable;

@property (nonatomic,readwrite) NSInteger selectedNoOfSubCategories;


@end
