//
//  KKStringPicker.h
//  stock
//
//  Created by Jaykon on 14-5-22.
//  Copyright (c) 2014年 Maxicn. All rights reserved.
//

#import "KKPickerAbstract.h"
@class KKStringPicker;

typedef void(^KKStringPickerDoneBlock)(KKStringPicker *picker, NSInteger selectedIndex, id selectedValue);
typedef void(^KKStringPickerCancelBlock)(KKStringPicker *picker);

@interface KKStringPicker : KKPickerAbstract
@property(strong,nonatomic)UIPickerView *picker;
+(KKStringPicker*)showPickerWithTitle:(NSString*)aTitle data:(NSArray*)rowsData selectedIndex:(NSInteger)selectedIndex onCancel:(KKStringPickerCancelBlock)cancelBlock onCommit:(KKStringPickerDoneBlock)commitBlock;
@end
