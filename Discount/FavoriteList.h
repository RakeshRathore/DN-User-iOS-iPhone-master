//
//  FavoriteList.h
//  Discount
//
//  Created by Sajith KG on 20/01/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavoriteDetail.h"

@interface FavoriteList : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UIView *topbarView;
@property (strong, nonatomic) IBOutlet UILabel *titleLbl;
@property (strong, nonatomic) IBOutlet UITableView *myTable;

//- (IBAction)favoriteBtnTapped:(id)sender;

@end
