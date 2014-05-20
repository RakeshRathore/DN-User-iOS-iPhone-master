//
//  PictureContent.h
//  Discount
//
//  Created by Sajith KG on 21/02/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureContent : UIViewController

@property (nonatomic,copy) NSString *imageURL;
@property (nonatomic,copy) UIImage *image;

@property (nonatomic, strong) IBOutlet UIImageView *myImageView;


- (id)initWithImageName:(NSString*) image_name;
- (id)initWithImage:(UIImage*) image;


@end
