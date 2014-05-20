//
//  UILabel+Boldify.h
//  Discount
//
//  Created by Sajith KG on 16/04/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Boldify)

- (void) boldSubstring: (NSString*) substring;
- (void) boldRange: (NSRange) range;

@end
