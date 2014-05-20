//
//  ProfileNameLabel.m
//  Discount
//
//  Created by Boopathi on 02/05/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "ProfileNameLabel.h"

@implementation ProfileNameLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor=[UIColor clearColor];
    self.textAlignment=NSTextAlignmentRight;
    self.numberOfLines=2;
    self.font = LATO_BOLD(15);
    self.textColor = STATUS_BAR_COLOR;
}

@end
