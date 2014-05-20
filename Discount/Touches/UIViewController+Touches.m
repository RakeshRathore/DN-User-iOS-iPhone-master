//
//  UIViewController+Touches.m
//  SWAP
//
//  Created by Sajith KG on 07/06/13.
//  Copyright (c) 2013 Sajith KG. All rights reserved.
//

#import "UIViewController+Touches.h"

@implementation UIViewController (Touches)

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	//NSLog(@"Touches touchesBegan");
	[self.view endEditing:YES];
}

@end
