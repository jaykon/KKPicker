//
//  KKAreaPicker.h
//  stock
//
//  Created by Jaykon on 14-5-22.
//  Copyright (c) 2014年 Maxicn. All rights reserved.
//

#import "KKMultiStringPicker.h"

typedef enum {
    KKAreaPickerTypeProvice,
    KKAreaPickerTypeProviceCity,
    KKAreaPickerTypeProviceCityArea,
}KKAreaPickerType;

@interface KKAdrress : NSObject
@property(strong,nonatomic)NSString *provice;
@property(strong,nonatomic)NSString *city;
@property(strong,nonatomic)NSString *area;
@end


@class KKAreaPicker;
typedef void(^KKAreaPickerDoneBlock)(KKAreaPicker *picker,KKAdrress *address);
typedef void(^KKAreaPickerCancelBlock)(KKAreaPicker *picker);

@interface KKAreaPicker : KKMultiStringPicker
+(KKAreaPicker*)showPickerWithTitle:(NSString*)aTitle pickerType:(KKAreaPickerType)pickerType defaultValue:(KKAdrress*)adress onCancel:(KKAreaPickerCancelBlock)cancelBlock onCommit:(KKAreaPickerDoneBlock)commitBlock;
@end
