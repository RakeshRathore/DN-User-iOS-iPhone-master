//
//  FavoriteDetailCell.m
//  Discount
//
//  Created by Sajith KG on 22/01/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "FavoriteDetailCell.h"
#import "UIImage+customColor.h"

@implementation FavoriteDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    self.itemTitleLbl.font = LATO_REGULAR(14);
    self.itemDesLbl.font = LATO_REGULAR(10);
    
    self.lineView.frame = CGRectMake(0, self.frame.size.height-0.50, 320, 0.50);
    
    self.backgroundColor = DETAIL_BG_COLOR;
    self.itemTitleLbl.textColor = [UIColor whiteColor];
    self.itemDesLbl.textColor = STATUS_BAR_COLOR;
    [self.circleImg setImage:[[UIImage imageNamed:@"favourite_detail_arrow.png"] imageWithOverlayColor:[UIColor grayColor]]];
    
    self.lineView.backgroundColor = RGB(27, 42, 65);
}



@end
