//
//  ProfileCell.m
//  Discount
//
//  Created by Sajith KG on 05/02/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "ProfileCell.h"
#import "UIImage+customColor.h"

@implementation ProfileCell

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
    
    self.backgroundColor = [UIColor clearColor];
    self.itemTitleLbl.font = LATO_REGULAR(16);
    
    self.lineView.frame = CGRectMake(0, self.frame.size.height-1, 320, 1);
    self.lineView.backgroundColor = RGB(27, 42, 65);
    
    [self.arrowImg setImage:[[UIImage imageNamed:@"blue_arrow.png"] imageWithOverlayColor:[UIColor whiteColor]]];
}

@end
