//
//  ProfileNameView.m
//  Discount
//
//  Created by Boopathi on 02/05/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "ProfileNameView.h"

@implementation ProfileNameView

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
    
    self.border = [CALayer layer];
    self.border.backgroundColor = [UIColor lightGrayColor].CGColor;
    self.border.frame = CGRectMake(0.0,self.frame.size.height-0.5,self.frame.size.width, 0.5);
    [self.layer addSublayer:self.border];
}

- (void) resetBottomLine {
    self.border.frame = CGRectMake(0.0,self.frame.size.height-0.5,self.frame.size.width, 0.5);
}

@end
