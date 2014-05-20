//
//  Help.h
//  Discount
//
//  Created by Sajith KG on 24/02/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebController : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) IBOutlet UIView *topbarView;
@property (nonatomic, strong) IBOutlet UILabel *viewHdr;

@property (nonatomic,assign) WebPageType webPageType;
@property (nonatomic, copy) NSString *titleStr;

@end
