//
//  PhotoPicker.h
//  SWAP
//
//  Created by Sajith KG on 05/06/13.
//  Copyright (c) 2013 Sajith KG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PhotoPicker : NSObject <UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate> {

    UIImagePickerController *picker;

}
@property (nonatomic,readwrite) BOOL allowEditPicture;
@property (nonatomic,assign) __unsafe_unretained UIViewController* handler;
@property (nonatomic,assign) __unsafe_unretained UIViewController* controllerToPresent;

+ (id)sharedPhotoPicker;

- (id)init;
- (void) showOptions;
- (void) showOptionsWithTitle:(NSString*) title;
- (void) showCamera;
- (void) showGallery;



@end
