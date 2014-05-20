//
//  InboxCell.m
//  SWAP
//
//  Created by Sajith KG on 29/05/13.
//  Copyright (c) 2013 Sajith KG. All rights reserved.
//

#import "MediaCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation MediaCell

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
}


@end
