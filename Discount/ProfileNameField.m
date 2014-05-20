//
//  ProfileNameField.m
//  Discount
//
//  Created by Boopathi on 02/05/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "ProfileNameField.h"

@implementation ProfileNameField

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
    
    self.backgroundColor=VIEW_BG_COLOR;
    self.textAlignment=NSTextAlignmentLeft;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    self.textColor = [UIColor blackColor];
    self.font = LATO_BOLD(16);
    
    self.borderStyle = UITextBorderStyleNone;
    
    if (self.placeholder) {
        if ([self respondsToSelector:@selector(setAttributedPlaceholder:)]) {  //ios 7
            self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSFontAttributeName: LATO_BOLD(9)}];
        }
    }
    
    
}


@end
