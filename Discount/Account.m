//
//  AccountInformation.m
//  Discount
//
//  Created by Sajith KG on 24/02/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "Account.h"
#import "PictureFullView.h"
#import "RootVC.h"
#import "AppDelegate.h"
#import "PhotoPicker.h"

@interface Account () {

    IBOutlet UIView *pictureHolder,*emailAdrHolder,*accountHolder;
    IBOutlet UIButton *editSaveBtn,*ProfileBtn;
    IBOutlet ProfileNameField *firstNameField,*lastNameField,*passwordField,*confirmPasswordField;
    IBOutlet ProfileNameView *firstNameView,*lastNameView,*emailIDView,*passwordView,*confirmPasswordView;
    IBOutlet UILabel *emailIDLbl,*accountLbl,*changeLbl;
}

@end

@implementation Account

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark BACK

-(IBAction)backBtnCall:(id)sender {
    
    if (editSaveBtn.selected) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirm"
                                                        message:@"Do you want to save the changes you have made?"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"Don't save",@"Save",nil];
        alert.tag=1111;
        [alert show];
    }else {
    
        [self doBackAction];
    }
}

#pragma mark Alert

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex != alertView.cancelButtonIndex) {
        
        if (buttonIndex==1) {
            
            if (alertView.tag==1111) {  //logout
                
                
            }
        }
    }
    
    [self doBackAction];
}

- (void) doBackAction {

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = DETAIL_BG_COLOR;
    self.topbarView.backgroundColor = TOPBAR_BG_COLOR;
    self.viewHdr.font = LATO_REGULAR(18);
    
    accountLbl.font = LATO_REGULAR(14);
    changeLbl.font = LATO_REGULAR(12);
    
    emailIDLbl.textColor = [UIColor blackColor];
    emailIDLbl.font = LATO_BOLD(16);
    
    self.accountType = kNormal;
    
    //pictureHolder.layer.borderColor = [UIColor redColor].CGColor;
    pictureHolder.layer.borderWidth = 2.0;
    pictureHolder.layer.cornerRadius = 5;
    pictureHolder.backgroundColor = VIEW_BG_COLOR;
    
    emailAdrHolder.layer.borderWidth = 2.0;
    emailAdrHolder.layer.cornerRadius = 5;
    emailAdrHolder.backgroundColor = VIEW_BG_COLOR;
    
    accountHolder.layer.borderWidth = 2.0;
    accountHolder.layer.cornerRadius = 5;
    accountHolder.backgroundColor = VIEW_BG_COLOR;
    
    editSaveBtn.titleLabel.font = LATO_BOLD(16);
    [editSaveBtn setTitle:@"Edit" forState:UIControlStateNormal];
    [editSaveBtn setTitle:@"Save" forState:UIControlStateSelected];
    
    [editSaveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [editSaveBtn setTitleColor:RGB(50, 205, 50) forState:UIControlStateSelected];
    
    editSaveBtn.selected=NO;
    [self changePageContentsWithAnimation:NO];
}

#pragma mark Edit/Save

- (IBAction)editSaveBtnCall:(id)sender {

    editSaveBtn.selected = !editSaveBtn.isSelected;
    [self changePageContentsWithAnimation:YES];
}

- (void) changePageContentsWithAnimation:(BOOL) yes {
    
    NSTimeInterval duration= (yes)? 0.3: 0.0f;
    
    firstNameField.userInteractionEnabled = editSaveBtn.isSelected;
    lastNameField.userInteractionEnabled = editSaveBtn.isSelected;
    passwordField.userInteractionEnabled = editSaveBtn.isSelected;
    confirmPasswordField.userInteractionEnabled = editSaveBtn.isSelected;
    
    [UIView animateWithDuration:duration animations:^{
        
        if (editSaveBtn.isSelected) {
            changeLbl.alpha = 0.7;
            
        }else {
           changeLbl.alpha = 0.0;
        }
    }];
    
    if (self.accountType==kNormal) {
        
        [UIView animateWithDuration:duration animations:^{
            
            if (editSaveBtn.isSelected) {
                
                passwordView.alpha = 1.0;
                [accountHolder setFrame:CGRectMake(accountHolder.frame.origin.x, accountHolder.frame.origin.y, accountHolder.frame.size.width, 160)];
                
            }else {
            
                passwordView.alpha = 0.0;
                [accountHolder setFrame:CGRectMake(accountHolder.frame.origin.x, accountHolder.frame.origin.y, accountHolder.frame.size.width, 80)];
            }
        }];
        
    }else {
        
        passwordView.alpha = 0.0;
        [accountHolder setFrame:CGRectMake(accountHolder.frame.origin.x, accountHolder.frame.origin.y, accountHolder.frame.size.width, 80)];
    }
}


#pragma mark Profile

- (IBAction)ProfileBtnCall:(id)sender {
    
    [self.view endEditing:YES];
    
    if (editSaveBtn.isSelected) {
       
       PhotoPicker *photoPicker = [PhotoPicker sharedPhotoPicker];
       [photoPicker setControllerToPresent:MY_APP_DELEGATE.rootVC];
       [photoPicker setHandler:self];
        [photoPicker showOptionsWithTitle:@"Select Your Profile Picture Source"];
    
   }else {
       
       PictureFullView *pictureFullView;
       
       if ([ProfileBtn imageForState:0]) {
            pictureFullView= [[PictureFullView alloc] initWithImageArray:[NSMutableArray arrayWithArray:@[[ProfileBtn imageForState:0]]] andSelectedIndex:(int)0];
       }else {
            pictureFullView= [[PictureFullView alloc] initWithImageArray:[NSMutableArray arrayWithArray:@[@"profile_sample.png"]] andSelectedIndex:(int)0];
       }
       
       
       [MY_APP_DELEGATE.rootVC presentViewController:pictureFullView animated:YES completion:nil];
   }
}

#pragma mark  Picture delegate

- (void) successPicture:(UIImage*) selectedPic {
    [ProfileBtn setImage:selectedPic forState:0];
    [ProfileBtn setImage:selectedPic forState:UIControlStateSelected];

}

- (void) failurePicture {
    
}

#pragma mark  UITextfield

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField == passwordField) {
        [Global animateView:self.view :YES :40];
    }
    if (textField == confirmPasswordField) {
        [Global animateView:self.view :YES :40];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField == passwordField) {
        [Global animateView:self.view :NO :40];
    }
    if (textField == confirmPasswordField) {
        [Global animateView:self.view :NO :40];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}







@end
