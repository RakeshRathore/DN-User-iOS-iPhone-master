//
//  PictureContent.m
//  Discount
//
//  Created by Sajith KG on 21/02/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "PictureContent.h"

@interface PictureContent () 
@end

@implementation PictureContent

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithImageName:(NSString*) image_name {
    
    if (self = [super init]) {
        _imageURL = image_name;
        _image = nil;
    }
    return self;
}

- (id)initWithImage:(UIImage*) image {
    
    if (self = [super init]) {
        _imageURL = nil;
        _image = image;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.image) {
        [self.myImageView setImage:self.image];
    }else {
        [self.myImageView setImage:[UIImage imageNamed:self.imageURL]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
