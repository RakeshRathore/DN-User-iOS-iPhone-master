//
//  Profile.h
//  Discount
//
//  Created by Sajith KG on 04/02/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Profile : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UIView *topbarView,*profileBG;
@property (nonatomic, strong) IBOutlet UIButton *profileBtn,*backBtn;

@property (nonatomic, strong) IBOutlet UILabel *myProfileHdr,*nameLbl;

@property (nonatomic, strong) IBOutlet UIView *discountView,*favoriteView;
@property (nonatomic, strong) IBOutlet UILabel *discountHdr,*favoriteHdr;
@property (nonatomic, strong) IBOutlet UILabel *discountValue,*favoriteValue;

@property (strong, nonatomic) IBOutlet UITableView *myTable;

@end
