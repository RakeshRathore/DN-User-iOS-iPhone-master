//
//  SocialMediaCell.h
//  Discount
//
//  Created by Sajith KG on 05/02/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SocialMediaCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *itemTitleLbl;
@property (strong, nonatomic) IBOutlet UIImageView *iconImg,*lineImg;
@property (strong, nonatomic) IBOutlet UISwitch *socialSwitch;

- (void) enableCell:(BOOL) yes ;

@end
