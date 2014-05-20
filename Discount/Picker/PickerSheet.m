//
//  PickerSheet.m
//  PickerViewActionSheetSample
//
//  Created by Sajith KG on 04/09/12.
//  Copyright (c) 2012 Internet Sales Promotion Group. All rights reserved.
//

#import "PickerSheet.h"
#import "AppDelegate.h"
#ifdef __IPHONE_6_0
# define ALIGN_CENTER NSTextAlignmentCenter
#define  ALIGN_LEFT NSTextAlignmentLeft
#define MIN_FONT_SIZE minimumScaleFactor
#else
# define ALIGN_CENTER UITextAlignmentCenter
#define  ALIGN_LEFT UITextAlignmentLeft
#define MIN_FONT_SIZE minimumFontSize
#endif
@implementation PickerSheet
@synthesize pickerdelegate,datepickerDelegate,actionSheet,datePicker,picker,pickerType,pickerItems;
- (id) init
{
    if (self = [super init])
    {
        pickerItems=[[NSMutableArray alloc]init];
        
        actionSheet = [[UIActionSheet alloc] 
                       initWithTitle:nil
                       delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles: nil];
        
        picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,40, 320, 216)];
        picker.showsSelectionIndicator=YES;
        picker.delegate = self;        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,40, 320, 216)];
        datePicker.datePickerMode = UIDatePickerModeDate;
        datePicker.date = [NSDate date];
        [datePicker addTarget:self action:@selector(dateChangedValue) forControlEvents:UIControlEventValueChanged];
        
        bar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0,320,44)];
        
        [actionSheet addSubview:bar];
        
        UIBarButtonItem *doneButton=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(btnActinDoneClicked)];
        doneButton.imageInsets=UIEdgeInsetsMake(200, 6, 50, 25);
        UIBarButtonItem *CancelButton=[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(btnActinCancelClicked)];
        
        UIBarButtonItem *flexSpace= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        NSArray *array = [[NSArray alloc]initWithObjects:CancelButton,flexSpace,flexSpace,doneButton,nil];
        
        [bar setItems:array];
        
        
        //picker title
        titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(60,8, 200, 25)];
       
        titleLabel.backgroundColor=[UIColor clearColor];
        titleLabel.textColor=[UIColor whiteColor];
        titleLabel.textAlignment=ALIGN_CENTER;
        titleLabel.font=[UIFont boldSystemFontOfSize:15];
        [bar addSubview:titleLabel];
        
    }
    return self;
}
-(void)setPicker:(Type )type :(NSString *)title :(barStyle)barStyle{
    
    [datePicker removeFromSuperview];
    [picker removeFromSuperview];
    switch (barStyle) {
        case kBarStyleBlack:
            [bar setBarStyle:UIBarStyleBlack];
            break;
        case kBarStyleBlackOpaque:
            [bar setBarStyle:UIBarStyleBlackOpaque];
            break;
        case kBarStyleBlackTranslucent:
            [bar setBarStyle:UIBarStyleBlackTranslucent];
            break;
            
        default:[bar setBarStyle:UIBarStyleDefault];
            break;
    }
    titleLabel.text=title;
    [self setPickerType:type];
    if (type==dateType) {
        [datePicker reloadInputViews];
        [actionSheet addSubview:datePicker]; 
    }
    else {
        [picker reloadAllComponents];
        [actionSheet addSubview:picker]; 
    }
}
-(void)reloadItems{
    if (pickerType==dateType) {
        [datePicker reloadInputViews];
    }
    else {
        [picker reloadAllComponents];
    }
}
-(void)showPicker:(UIView *)onView animated:(BOOL)value{
    [actionSheet showFromRect:CGRectMake(0,480, 320,480) inView:onView animated:value];
    [actionSheet setBounds:CGRectMake(0,0, 320, 480)];
}
-(void)showPickerOnTabar:(UITabBar *)tabBar{
    [actionSheet showFromTabBar:tabBar];
     [actionSheet setBounds:CGRectMake(0,0, 320, 480)];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	//NSLog(@"%d",[pickerView selectedRowInComponent:component]);
}
-(int)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1;
}
-(int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	return (int)[pickerItems count];
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

	return [pickerItems objectAtIndex:row];
}
-(void)btnActinDoneClicked{
    
    //NSLog(@"picker %d",[picker selectedRowInComponent:0]);
    
    if (pickerType==dateType) {
        [datepickerDelegate datePickerChanged:datePicker newDate:datePicker.date];
    }
    else{
        if ([pickerItems count]) {
            [pickerdelegate pickerSelectedRow:(int)[picker selectedRowInComponent:0]];
        }
        else {
            [pickerdelegate pickerSelectedRow :-1];
        }
    }
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES]; 
}


-(void)btnActinCancelClicked{
     if(actionSheet!=nil){
    	[actionSheet dismissWithClickedButtonIndex:0 animated:YES];
         [pickerdelegate PickerCancelled];
         
     }
	if (pickerType==dateType) {
        [datepickerDelegate datePickerCancelled];
    }
}
- (void)dateChangedValue{
     //NSLog(@"dateChangedValue");
	//Use NSDateFormatter to write out the date in a friendly format
}	
-(void)hidePicker:(BOOL)value{
    [actionSheet dismissWithClickedButtonIndex:0 animated:value];
}
-(void)dealloc{
}
@end
