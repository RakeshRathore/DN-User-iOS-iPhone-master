//
//  FavoriteDetail.h
//  Discount
//
//  Created by Sajith KG on 21/01/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoriteDetail : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *itemTitle;
@property (strong, nonatomic) IBOutlet UILabel *itemDes;
@property (strong, nonatomic) IBOutlet UITableView *dealTable;

@property (strong, nonatomic) IBOutlet UIView *topView,*pictureView;
@property (strong, nonatomic) IBOutlet UILabel *titleLbl;

@property (nonatomic, readwrite) BOOL isFavoriteMode;

@end
