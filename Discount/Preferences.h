//
//  Preferences.h
//  Discount
//
//  Created by Sajith KG on 05/02/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Preferences : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UIView *topbarView;
@property (strong, nonatomic) IBOutlet UITableView *myTable;
@property (nonatomic, strong) IBOutlet UILabel *viewHdr;

@end
