//
//  KKRangePicker.h
//  swingers
//
//  Created by Jaykon on 16/2/27.
//  Copyright © 2016年 Jaykon. All rights reserved.
//

#import "KKPickerAbstract.h"

@class KKRangePicker;

typedef void(^KKNumberPickerDoneBlock)(KKRangePicker *picker, NSString *selectedValue);
typedef void(^KKRangePickerDoneBlock)(KKRangePicker *picker, NSRange selectedRange);
typedef void(^KKRangePickerCancelBlock)(KKRangePicker *picker);

@interface KKRangePicker : KKPickerAbstract

@property(strong,nonatomic)UIPickerView *picker;
/**
 *  单个整型的选择器
 *
 *  @param aTitle        标题
 *  @param range         范围
 *  @param afterString   数字后带的单位
 *  @param selectedValue 默认选中的值
 */
+(KKRangePicker*)showNumberPickerWithTitle:(NSString*)aTitle
                                     range:(NSRange)range
                               afterString:(NSString*)afterString
                             selectedValue:(NSString*)selectedValue
                                  onCancel:(KKRangePickerCancelBlock)cancelBlock
                                  onCommit:(KKNumberPickerDoneBlock)commitBlock;

/**
 *  整型范围选择器
 *
 *  @param aTitle        标题
 *  @param range         范围
 *  @param maxDiff       范围最大差距
 */
+(KKRangePicker*)showNumberRangePickerWithTitle:(NSString*)aTitle
                                          range:(NSRange)range
                                  selectedRange:(NSRange)selectedRange
                                       onCancel:(KKRangePickerCancelBlock)cancelBlock
                                       onCommit:(KKRangePickerDoneBlock)commitBlock;
@end
