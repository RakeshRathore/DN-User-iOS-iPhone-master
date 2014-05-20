//
//  PhotoPicker.m
//  SWAP
//
//  Created by Sajith KG on 05/06/13.
//  Copyright (c) 2013 Sajith KG. All rights reserved.
//

#import "PhotoPicker.h"
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIImage+fixOrientation.h"

@implementation PhotoPicker


@synthesize handler,controllerToPresent,allowEditPicture;

- (id)init {

    self = [super init];
    if (self) {
        
        self.allowEditPicture=YES;
    }
    return self;
}

+ (id)sharedPhotoPicker {
    
    static PhotoPicker *sharedMyPhotoPicker = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyPhotoPicker = [[self alloc] init];
    });
    return sharedMyPhotoPicker;
}
    
- (void) showOptions {
    [self showOptionsWithTitle:appName];
}

- (void) showOptionsWithTitle:(NSString*) title {
    
	UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:title delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Photo Gallery",nil];
	[action showInView:[UIApplication sharedApplication].keyWindow];
}

- (void) showCamera {

    if (!picker) {
        picker = [[UIImagePickerController alloc] init];
    }
    
    picker.delegate = self;
    picker.allowsEditing=self.allowEditPicture;
    
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        [Global showErrorWithMessage:@"Sorry! No Camera Found !!"];
    }
    else {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self.controllerToPresent presentModalViewController:picker animated:YES];
    }
}

- (void) showGallery {
    
    if (!picker) {
        picker = [[UIImagePickerController alloc] init];
    }
    
    picker.delegate = self;
    picker.allowsEditing=self.allowEditPicture;
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.controllerToPresent presentModalViewController:picker animated:YES];
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
	if(buttonIndex == 0) 
        [self showCamera];
	
	if(buttonIndex == 1) 
		[self showGallery];
}

#pragma mark Picker delegate

- (void) imagePickerController:(UIImagePickerController *)picker1 didFinishPickingImage:(UIImage *)imageSel editingInfo:(NSDictionary *)editingInfo {
	
	[self.controllerToPresent dismissModalViewControllerAnimated:YES];
	picker.delegate=nil;
    
//    NSURL *imageURL = [editingInfo valueForKey:UIImagePickerControllerReferenceURL];
//    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
//    {
//        ALAssetRepresentation *representation = [myasset defaultRepresentation];
//        NSLog(@"filename %@",[representation filename]);
//        
//        //id fileName = [representation valueForProperty:ALAssetPropertyDate];
//        //NSLog(@"fileName : %@",fileName);
//    };
//    
//    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
//    [assetslibrary assetForURL:imageURL
//                   resultBlock:resultblock
//                  failureBlock:nil];
    
//    NSData *imageData = [[NSData alloc] initWithData:UIImageJPEGRepresentation((imageSel), 1)];
//    NSLog(@"%@",NSStringFromCGSize(imageSel.size));
//    NSLog(@"SIZE OF IMAGE: %f ", (float)imageData.length/1024.0);
    
    
    if (imageSel.size.width<=640) {
        if ([self.handler respondsToSelector:@selector(successPicture:)]){
            [self.handler performSelector:@selector(successPicture:) withObject:imageSel];
        }
        
    }else {
        
        UIImage *resizedImage = [Global imageWithImage:[imageSel fixOrientation] scaledToWidth:640];
//        NSData *imageData1 = [[NSData alloc] initWithData:UIImageJPEGRepresentation((resizedImage), 1)];
//        NSLog(@"%@",NSStringFromCGSize(resizedImage.size));
//        NSLog(@"SIZE OF IMAGE AFTER: %f ", (float)imageData1.length/1024.0);
        
        if ([self.handler respondsToSelector:@selector(successPicture:)]){
            [self.handler performSelector:@selector(successPicture:) withObject:resizedImage];
        }
    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker1 {
    
    [self.controllerToPresent dismissModalViewControllerAnimated:YES];
	picker1.delegate=nil;

    if ([self.handler respondsToSelector:@selector(failurePicture)]){
        [self.handler performSelector:@selector(failurePicture)];
    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}



@end
