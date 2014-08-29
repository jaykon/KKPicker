//
//  KKMultiStringPicker.h
//  stock
//
//  Created by Jaykon on 14-5-22.
//  Copyright (c) 2014年 Maxicn. All rights reserved.
//

#import "KKPickerAbstract.h"
@class KKMultiStringPicker;
typedef void(^KKMultiStringPickerDoneBlock)(KKMultiStringPicker *picker, NSArray *selectedIndexArray, NSArray *selectedValueArray);
typedef void(^KKMultiStringPickerCancelBlock)(KKMultiStringPicker *picker);
@interface KKMultiStringPicker : KKPickerAbstract
+(KKMultiStringPicker*)showPickerWithTitle:(NSString*)aTitle data:(NSArray*)rowsData selectedIndex:(NSArray*)selectedIndexArray onCancel:(KKMultiStringPickerCancelBlock)cancelBlock onCommit:(KKMultiStringPickerDoneBlock)commitBlock;
-(instancetype)initWithTitle:(NSString*)aTitle data:(NSArray*)rowsData selectedIndex:(NSArray*)selectedIndexArray onCancel:(KKMultiStringPickerCancelBlock)cancelBlock onCommit:(KKMultiStringPickerDoneBlock)commitBlock;
@end
