//
//  PickerSheet.h
//  PickerViewActionSheetSample
//
//  Created by Sajith KG on 04/09/12.
//  Copyright (c) 2012 Internet Sales Promotion Group. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    dateType =1,               
    defaultType =0
}Type;

typedef enum {
    kBardefault =0,               
    kBarStyleBlackOpaque =1,
    kBarStyleBlackTranslucent=2,
    kBarStyleBlack=3
}barStyle;
@protocol pickerDelegate;
@protocol datePickerDelegate;
@interface PickerSheet : NSObject<UIActionSheetDelegate,UIPickerViewDelegate>{
 	id <pickerDelegate> __unsafe_unretained pickerdelegate;
    id <datePickerDelegate>__unsafe_unretained datepickerDelegate;
    
    UIActionSheet *actionSheet;
    UIDatePicker *datePicker;
    UIPickerView *picker;
    Type pickerType;
    
    UIToolbar *bar;
    UILabel *titleLabel;
    
    NSMutableArray *pickerItems;
}
@property(nonatomic,retain)NSMutableArray *pickerItems;
@property(nonatomic,retain)UIActionSheet *actionSheet;
@property(nonatomic,retain)UIDatePicker *datePicker;
@property(nonatomic,retain)UIPickerView *picker;
@property(nonatomic)Type pickerType;
@property (nonatomic, unsafe_unretained) id <pickerDelegate> pickerdelegate;
@property (nonatomic,unsafe_unretained)id <datePickerDelegate>datepickerDelegate;

-(void)setPicker:(Type )type :(NSString *)title :(barStyle)barStyle;
-(void)showPicker:(UIView *)onView animated:(BOOL)value;
-(void)showPickerOnTabar:(UITabBar *)tabBar;
-(void)hidePicker :(BOOL)value;
-(void)reloadItems;
@end


@protocol pickerDelegate 
-(void)pickerSelectedRow:(int)row;
-(void)PickerCancelled;
@end
@protocol datePickerDelegate
-(void)datePickerChanged:(UIDatePicker *)datePicker newDate:(NSDate *)date;
-(void)datePickerCancelled;
@end

