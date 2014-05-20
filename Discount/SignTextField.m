//
//  SignTextField.m
//  SWAP
//
//  Created by Sajith KG on 31/05/13.
//  Copyright (c) 2013 Sajith KG. All rights reserved.
//

#import "SignTextField.h"

@implementation SignTextField

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
    self.font = LATO_REGULAR(16);
    self.backgroundColor = [UIColor whiteColor];
    
    
    if ([self respondsToSelector:@selector(setAttributedPlaceholder:)]) {  //ios 7
        UIColor *color = RGB(157, 157, 157);
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    }
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 20, 0);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 20, 0);
}


// Working io6 6
//- (void) drawPlaceholderInRect:(CGRect)rect {
//    [[UIColor blueColor] setFill];
//    [[self placeholder] drawInRect:rect withFont:[UIFont systemFontOfSize:16]];
//}

@end
