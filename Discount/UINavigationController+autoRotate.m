//
//  UINavigationController+autoRotate.m
//  HiBye
//
//  Created by Sajith KG on 16/10/12.
//
//

#import "UINavigationController+autoRotate.h"

@implementation UINavigationController (autoRotate)

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//    
//    return [self.visibleViewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
//}

- (BOOL)shouldAutorotate {
    
    if ([self.visibleViewController respondsToSelector:@selector(shouldAutorotate)]) {
        return [self.visibleViewController shouldAutorotate];
    }
    
    return NO;
    
}

- (NSUInteger)supportedInterfaceOrientations {
    
    return [self.visibleViewController supportedInterfaceOrientations];
}


@end
