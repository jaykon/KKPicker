//
//  KKAreaPicker.h
//  stock
//
//  Created by jaykon on 14-5-22.
//  Copyright (c) 2014年 jaykon. All rights reserved.
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

+(instancetype)addressWithProvice:(NSString*)province
                             city:(NSString*)city
                             area:(NSString*)area;

+(instancetype)addressWithString:(NSString*)addressString seperateByString:(NSString*)seperator;
@end


@class KKAreaPicker;
typedef void(^KKAreaPickerDoneBlock)(KKAreaPicker *picker,KKAdrress *address);
typedef void(^KKAreaPickerCancelBlock)(KKAreaPicker *picker);

@interface KKAreaPicker : KKMultiStringPicker

/**
 *  展示省市选择器
 */
+(KKAreaPicker*)showPickerWithTitle:(NSString*)aTitle
                         pickerType:(KKAreaPickerType)pickerType
                       defaultValue:(KKAdrress*)adress
                           onCancel:(KKAreaPickerCancelBlock)cancelBlock
                           onCommit:(KKAreaPickerDoneBlock)commitBlock;

/**
 *  展示省市选择器（市可以选择不限）
 *
 *  @param aTitle                   标题
 *  @param adress                   默认选中
 *  @param noNeedSelectCityOfProvince @[NSString] 指定省份的市级项可选"-不限-"，传入nil则所有市可选"-不限-"
 */
+(KKAreaPicker*)showPickerWithProviceCityPickerWithTitle:(NSString*)aTitle
                                            defaultValue:(KKAdrress*)adress
                                optionalCitiesOfProvince:(NSArray*)optionalCitiesOfProvince
                                                onCancel:(KKAreaPickerCancelBlock)cancelBlock
                                                onCommit:(KKAreaPickerDoneBlock)commitBlock;

/**
 *  展示省市区选择器（市、区可以选择不限）
 *
 *  @param aTitle                   标题
 *  @param adress                   默认选中
 *  @param noNeedSelectCityOfProvince @[NSString]  指定省份的市级项可以选"-不限-"，传入nil则所有市可以选"-不限-"
 *  @param areaOptional 区是否出现“-不限-”选项
 */
+(KKAreaPicker*)showPickerWithProviceCityAreaPickerWithTitle:(NSString*)aTitle
                                                defaultValue:(KKAdrress*)adress
                                    optionalCitiesOfProvince:(NSArray*)optionalCitiesOfProvince
                                                areaOptional:(BOOL)areaOptional
                                                    onCancel:(KKAreaPickerCancelBlock)cancelBlock
                                                    onCommit:(KKAreaPickerDoneBlock)commitBlock;
@end
