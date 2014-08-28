//
//  KKDateTimePicker.m
//  KKPickerDemo
//
//  Created by Jaykon on 14-8-28.
//  Copyright (c) 2014年 Jaykon. All rights reserved.
//

#import "KKDateTimePicker.h"
@interface KKDateTimePicker ()
@property(nonatomic,strong) UIDatePicker *picker;
@property(nonatomic,assign) UIDatePickerMode pickerMode;
@property(copy,nonatomic)KKDateTimePickerCancelBlock cancelBlock;
@property(copy,nonatomic)KKDateTimePickerDoneBlock commitBlock;
@end

@implementation KKDateTimePicker
+(KKDateTimePicker*)showPickerWithTitle:(NSString*)aTitle pickerMode:(UIDatePickerMode)pickerMode defaultValue:(NSDate*)defaultDate onCancel:(KKDateTimePickerCancelBlock)cancelBlock onCommit:(KKDateTimePickerDoneBlock)commitBlock
{
    KKDateTimePicker *picker=[[KKDateTimePicker alloc] initWithTitle:aTitle];
    picker.picker.datePickerMode=pickerMode;
    picker.cancelBlock=cancelBlock;
    picker.commitBlock=commitBlock;
    picker.picker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    if(defaultDate){
        picker.picker.date=defaultDate;
    }
    [picker show];
    return picker;
}

#pragma mark -KKPickerAbstractDelegate
-(UIView *)KKPickerComponentView
{
    UIView *contrainerView=[[UIView alloc] initWithFrame:CGRectMake(0, 44, self.componentContainerView.frame.size.width, 216)];
    contrainerView.backgroundColor=[UIColor whiteColor];
    _picker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.componentContainerView.frame.size.width, 216)];
    [contrainerView addSubview:_picker];
    return contrainerView;
}

-(void)KKPickerCancel
{
    self.cancelBlock(self);
    [self hide];
}

-(void)KKPickerCommit
{
    self.commitBlock(self,_picker.date);
    [self hide];
}

@end
