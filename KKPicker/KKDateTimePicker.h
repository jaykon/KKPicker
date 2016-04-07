//
//  KKDateTimePicker.h
//  KKPickerDemo
//
//  Created by Jaykon on 14-8-28.
//  Copyright (c) 2014年 Jaykon. All rights reserved.
//

#import "KKPickerAbstract.h"
@class KKDateTimePicker;

typedef enum {
    KKDateTimePickerTypeDate
}KKDateTimePickerType;

typedef void(^KKDateTimePickerDoneBlock)(KKDateTimePicker *picker, NSDate *selectedDate);
typedef void(^KKDateTimePickerCancelBlock)(KKDateTimePicker *picker);

@interface KKDateTimePicker : KKPickerAbstract
+(KKDateTimePicker*)showPickerWithTitle:(NSString*)aTitle pickerMode:(UIDatePickerMode)pickerMode defaultValue:(NSDate*)defaultDate onCancel:(KKDateTimePickerCancelBlock)cancelBlock onCommit:(KKDateTimePickerDoneBlock)commitBlock;
@end
