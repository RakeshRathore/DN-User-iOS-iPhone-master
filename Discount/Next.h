//
//  Next.h
//  Discount
//
//  Created by Sajith KG on 30/01/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Next : UIViewController

@property (nonatomic, strong) IBOutlet UIImageView *topView,*logoImg;
@property (nonatomic, strong) IBOutlet UILabel *resetPassHdr;
@property (nonatomic, strong) IBOutlet UILabel *enterEmailHdr;
@property (nonatomic, strong) IBOutlet UIButton *submitBtn;

- (IBAction)nextBtnTapped:(id)sender;

@end
