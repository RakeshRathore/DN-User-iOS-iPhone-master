//
//  UIScrollView+Touches.m
//  Tag&Flag
//
//  Created by Sajith KG on 13/03/13.
//  Copyright (c) 2013 Sajith KG. All rights reserved.
//

#import "UIScrollView+Touches.h"

@implementation UIScrollView (Touches)

- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event
{
    // If not dragging, send event to next responder
    if (!self.dragging){
        [self.nextResponder touchesEnded: touches withEvent:event];
        [self endEditing:YES];
    }
    else
        [super touchesEnded: touches withEvent: event];
}

@end
