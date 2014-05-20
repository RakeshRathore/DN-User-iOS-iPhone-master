//
//  SocialMediaCell.m
//  Discount
//
//  Created by Sajith KG on 05/02/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "SocialMediaCell.h"

@implementation SocialMediaCell

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
    self.itemTitleLbl.textColor = [UIColor whiteColor];
    
    self.socialSwitch.tintColor = [UIColor whiteColor];
    [self.socialSwitch setOnTintColor:STATUS_BAR_COLOR];
    
    self.lineImg.backgroundColor = RGB(27, 42, 65);

}

- (void) enableCell:(BOOL) yes {
    
    if (yes) {
        self.itemTitleLbl.alpha =1.0;
        self.iconImg.alpha =1.0;
        self.socialSwitch.enabled=YES;
        
    }else {
        
        self.itemTitleLbl.alpha =0.5;
        self.iconImg.alpha =0.5;
        self.socialSwitch.enabled=NO;
    }
}

@end
