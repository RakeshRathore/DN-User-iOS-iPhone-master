//
//  NewsFeedCell.h
//  SWAP
//
//  Created by Sajith KG on 28/05/13.
//  Copyright (c) 2013 Sajith KG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoriteItemCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *favTitleLbl1,*favTitleLbl2;
@property (strong, nonatomic) IBOutlet UIImageView *businessImage1,*businessImage2;
@property (strong, nonatomic) IBOutlet UIButton *selectionBtn1,*selectionBtn2;


@end
