//
//  KKMultiStringPicker.h
//  多列关系选择器
//
//  Created by jaykon on 14-5-22.
//  Copyright (c) 2014年 jaykon. All rights reserved.
//

#import "KKPickerAbstract.h"
#import "SafeControl.h"
@class KKMultiStringPicker;
typedef void(^KKMultiStringPickerDoneBlock)(KKMultiStringPicker *picker, NSArray *selectedIndexArray, NSArray *selectedValueArray);
typedef void(^KKMultiStringPickerCancelBlock)(KKMultiStringPicker *picker);
@interface KKMultiStringPicker : KKPickerAbstract
@property(strong,nonatomic)UIPickerView *picker;


/*
 多列关系选择器
 rowsData数据结构略复杂，举个例子
 
 NSArray *rowsData=@[
 @[@"aa",@"bb"],
 @{@"aa":@[@"aa-1",@"aa-2"],@"bb":@[@"bb-1",@"bb-2"]},
 @{
 @"aa":@{@"aa-1":@[@"aa-1-1",@"aa-1-2"],@"aa-2":@[@"aa-2-1",@"aa-2-2"]},
 @"bb":@{@"bb-2":@[@"bb-2-1",@"bb-2-2"]}}
 ];
 
 */
+(KKMultiStringPicker*)showPickerWithTitle:(NSString*)aTitle
                                      data:(NSArray*)rowsData
                             selectedIndex:(NSArray*)selectedIndexArray
                                  onCancel:(KKMultiStringPickerCancelBlock)cancelBlock
                                  onCommit:(KKMultiStringPickerDoneBlock)commitBlock;



-(instancetype)initWithTitle:(NSString*)aTitle data:(NSArray*)rowsData selectedIndex:(NSArray*)selectedIndexArray onCancel:(KKMultiStringPickerCancelBlock)cancelBlock onCommit:(KKMultiStringPickerDoneBlock)commitBlock;
@end
