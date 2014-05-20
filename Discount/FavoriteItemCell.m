//
//  NewsFeedCell.m
//  SWAP
//
//  Created by Sajith KG on 28/05/13.
//  Copyright (c) 2013 Sajith KG. All rights reserved.
//

#import "FavoriteItemCell.h"

@implementation FavoriteItemCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundColor = [UIColor clearColor];
    self.favTitleLbl1.font = LATO_BOLD(14);
    self.favTitleLbl2.font = LATO_BOLD(14);
    
}

@end
