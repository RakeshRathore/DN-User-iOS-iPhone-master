//
//  SubCategoryCell.m
//  Discount
//
//  Created by Sajith KG on 12/02/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "SubCategoryCell.h"

@implementation SubCategoryCell

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
    self.subCategoryName.font = LATO_REGULAR(16);
    [self.subCategoryName setTextColor:RGB(174, 231, 255)];
}

@end
