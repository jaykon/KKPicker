//
//  KKAreaPicker.m
//  stock
//
//  Created by Jaykon on 14-5-22.
//  Copyright (c) 2014年 Maxicn. All rights reserved.
//

#import "KKAreaPicker.h"
@implementation KKAdrress
@end

@interface KKAreaPicker()
@end

@implementation KKAreaPicker
+(KKAreaPicker*)showPickerWithTitle:(NSString*)aTitle pickerType:(KKAreaPickerType)pickerType defaultValue:(KKAdrress*)adress onCancel:(KKAreaPickerCancelBlock)cancelBlock onCommit:(KKAreaPickerDoneBlock)commitBlock
{
    KKAreaPicker *picker=[[KKAreaPicker alloc] initPickerWithTitle:aTitle pickerType:pickerType defaultValue:adress onCancel:cancelBlock onCommit:commitBlock];
    [picker show];
    return picker;
}

-(KKAreaPicker*)initPickerWithTitle:(NSString*)aTitle pickerType:(KKAreaPickerType)pickerType defaultValue:(KKAdrress*)adress onCancel:(KKAreaPickerCancelBlock)cancelBlock onCommit:(KKAreaPickerDoneBlock)commitBlock
{
    
    NSMutableArray *data=[[NSMutableArray alloc] init];
    NSArray *stateArray;
    NSDictionary *cityDic;
    NSDictionary *areaDic;
    NSMutableArray *defaultSelected=[[NSMutableArray alloc] init];
    
    if(pickerType==KKAreaPickerTypeProvice){
        stateArray=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"KKPickerProvice" ofType:@"plist"]];
        [data addObject:stateArray];
    }else if (pickerType==KKAreaPickerTypeProviceCity){
        stateArray=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"KKPickerProvice" ofType:@"plist"]];
        cityDic=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"KKPickerCity" ofType:@"plist"]];
        [data addObject:stateArray];
        [data addObject:cityDic];
    }else{
        stateArray=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"KKPickerProvice" ofType:@"plist"]];
        cityDic=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"KKPickerCity" ofType:@"plist"]];
        areaDic=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"KKPickerArea" ofType:@"plist"]];
        [data addObject:stateArray];
        [data addObject:cityDic];
        [data addObject:areaDic];
    }
    
    if(adress){
        if(adress.provice){
            NSUInteger index0=[stateArray indexOfObject:adress.provice];
            [defaultSelected safeAddObject:[NSNumber numberWithInt:index0]];
            if(adress.city){
                NSUInteger index1=[[cityDic safeObjectForKey:adress.provice] indexOfObject:adress.city];
                [defaultSelected safeAddObject:[NSNumber numberWithInt:index1]];
                if(adress.area){
                    NSUInteger index2=[[areaDic safeObjectForKey:adress.city] indexOfObject:adress.area];
                    [defaultSelected safeAddObject:[NSNumber numberWithInt:index2]];
                }
            }
        }
    }
    
    __weak KKAreaPicker *wSelf=self;
    
    self=[super initWithTitle:aTitle data:data selectedIndex:defaultSelected onCancel:^(KKMultiStringPicker *picker) {
        cancelBlock(wSelf);
    } onCommit:^(KKMultiStringPicker *picker, NSArray *selectedIndexArray, NSArray *selectedValueArray) {
        KKAdrress *address=[[KKAdrress alloc] init];
        for (int i=0; i<[selectedValueArray count]; i++) {
            switch (i) {
                case 0:
                    address.provice=selectedValueArray[i];
                    break;
                case 1:
                    address.city=selectedValueArray[i];
                    break;
                case 2:
                    address.area=selectedValueArray[i];
            }
        }
        commitBlock(wSelf,address);
    }];
    if(self)
    {
        
    }
    return self;
}


@end
