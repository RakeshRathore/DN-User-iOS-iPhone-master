//
//  Search.h
//  Discount
//
//  Created by Sajith KG on 21/01/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationSearchBar.h"

@interface Search : UIViewController <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (nonatomic, strong) IBOutlet UIView *topbarView;
@property (strong, nonatomic) IBOutlet UILabel *itemTitleLbl;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet LocationSearchBar *locationSearchBar;
@property (strong, nonatomic) IBOutlet UITableView *listTable;
@property (strong ,nonatomic) IBOutlet UIButton *cancelBtn,*searchBtn;

@end
