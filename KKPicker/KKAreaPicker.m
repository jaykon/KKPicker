//
//  KKAreaPicker.m
//  stock
//
//  Created by jaykon on 14-5-22.
//  Copyright (c) 2014年 jaykon. All rights reserved.
//

#import "KKAreaPicker.h"
@implementation KKAdrress
+(instancetype)addressWithProvice:(NSString *)province city:(NSString *)city area:(NSString *)area{
    KKAdrress *addr=[[KKAdrress alloc] init];
    addr.provice=province;
    addr.city=city;
    addr.area=area;
    return addr;
}

+(instancetype)addressWithString:(NSString*)addressString seperateByString:(NSString*)seperator{
    KKAdrress *addr=[[KKAdrress alloc] init];
    NSArray *addrArray=[addressString componentsSeparatedByString:seperator];
    for (int i=0; i<[addrArray count]; i++) {
        if (i==0) {
            addr.provice=addrArray[i];
        }else if (i==1){
            addr.city=addrArray[i];
        }else{
            addr.area=addrArray[i];
        }
    }
    return addr;
}
@end

@interface KKAreaPicker()
@end

@implementation KKAreaPicker

-(instancetype)initWithTitle:(NSString *)aTitle data:(NSArray *)rowsData selectedIndex:(NSArray *)selectedIndexArray onCancel:(KKMultiStringPickerCancelBlock)cancelBlock onCommit:(KKMultiStringPickerDoneBlock)commitBlock{
    self=[super initWithTitle:aTitle data:rowsData selectedIndex:selectedIndexArray onCancel:cancelBlock onCommit:commitBlock];
    return self;
}


+(KKAreaPicker*)showPickerWithTitle:(NSString*)aTitle pickerType:(KKAreaPickerType)pickerType defaultValue:(KKAdrress*)adress onCancel:(KKAreaPickerCancelBlock)cancelBlock onCommit:(KKAreaPickerDoneBlock)commitBlock
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
            NSInteger index0=[stateArray indexOfObject:adress.provice];
            [defaultSelected safeAddObject:[NSNumber numberWithInt:(int)index0]];
            if(adress.city){
                NSInteger index1=[[cityDic safeObjectForKey:adress.provice] indexOfObject:adress.city];
                [defaultSelected safeAddObject:[NSNumber numberWithInt:(int)index1]];
                if(adress.area){
                    NSInteger index2=[[[areaDic safeObjectForKey:adress.provice] safeObjectForKey:adress.city] indexOfObject:adress.area];
                    [defaultSelected safeAddObject:[NSNumber numberWithInt:(int)index2]];
                }
            }
        }
    }
    
    KKAreaPicker *p=[[KKAreaPicker alloc] initWithTitle:aTitle data:data selectedIndex:defaultSelected onCancel:^(KKMultiStringPicker *picker) {
        if (cancelBlock) {
            cancelBlock(p);
        }
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
        if (commitBlock) {
            commitBlock(p,address);
        }
    }];
    [p show];
    return p;
}


+(KKAreaPicker*)showPickerWithProviceCityPickerWithTitle:(NSString*)aTitle
                                            defaultValue:(KKAdrress*)adress
                                optionalCitiesOfProvince:(NSArray*)optionalCitiesOfProvince
                                                onCancel:(KKAreaPickerCancelBlock)cancelBlock
                                                onCommit:(KKAreaPickerDoneBlock)commitBlock{
    
    NSMutableArray *data=[[NSMutableArray alloc] init];
    NSArray *stateArray;
    NSDictionary *cityDic;
    NSMutableArray *defaultSelected=[[NSMutableArray alloc] init];
    
    stateArray=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"KKPickerProvice" ofType:@"plist"]];
    cityDic=[NSMutableDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"KKPickerCity" ofType:@"plist"]];
    [data addObject:stateArray];
    [data addObject:cityDic];
    
    if(optionalCitiesOfProvince==nil){
        NSArray *allProvinces=[cityDic allKeys];
        for (NSString *tProvice in allProvinces) {
            if([SAFE_VALUE_FOR_KEY(cityDic, tProvice) isKindOfClass:[NSArray class]]){
                NSMutableArray *tCitys=[NSMutableArray arrayWithArray:SAFE_VALUE_FOR_KEY(cityDic, tProvice)];
                [tCitys insertObject:@"-不限-" atIndex:0];
                SAFE_SET_VALUE_OF_KEY(cityDic, tProvice, tCitys);
            }
        }
    }else{
        for (NSString *tProvice in optionalCitiesOfProvince) {
            if([SAFE_VALUE_FOR_KEY(cityDic, tProvice) isKindOfClass:[NSArray class]]){
                NSMutableArray *tCitys=[NSMutableArray arrayWithArray:SAFE_VALUE_FOR_KEY(cityDic, tProvice)];
                [tCitys insertObject:@"-不限-" atIndex:0];
                SAFE_SET_VALUE_OF_KEY(cityDic, tProvice, tCitys);
            }
        }
    }
    
    if(adress){
        if(adress.provice){
            NSInteger index0=[stateArray indexOfObject:adress.provice];
            [defaultSelected safeAddObject:[NSNumber numberWithInt:(int)index0]];
            if(adress.city){
                NSInteger index1=[[cityDic safeObjectForKey:adress.provice] indexOfObject:adress.city];
                [defaultSelected safeAddObject:[NSNumber numberWithInt:(int)index1]];
            }
        }
    }
    
    KKAreaPicker *p=[[KKAreaPicker alloc] initWithTitle:aTitle data:data selectedIndex:defaultSelected onCancel:^(KKMultiStringPicker *picker) {
        if (cancelBlock) {
            cancelBlock(p);
        }
    } onCommit:^(KKMultiStringPicker *picker, NSArray *selectedIndexArray, NSArray *selectedValueArray) {
        KKAdrress *address=[[KKAdrress alloc] init];
        for (int i=0; i<[selectedValueArray count]; i++) {
            switch (i) {
                case 0:
                    if (![selectedValueArray[i] isEqualToString:@"-不限-"]) {
                        address.provice=selectedValueArray[i];
                    }
                    break;
                case 1:
                    if (![selectedValueArray[i] isEqualToString:@"-不限-"]) {
                        address.city=selectedValueArray[i];
                    }
                    break;
                case 2:
                    if (![selectedValueArray[i] isEqualToString:@"-不限-"]) {
                        address.area=selectedValueArray[i];
                    }
            }
        }
        if (commitBlock) {
            commitBlock(p,address);
        }
    }];
    [p show];
    return p;
}


+(KKAreaPicker*)showPickerWithProviceCityAreaPickerWithTitle:(NSString*)aTitle
                                                defaultValue:(KKAdrress*)adress
                                    optionalCitiesOfProvince:(NSArray*)optionalCitiesOfProvince
                                                areaOptional:(BOOL)areaOptional
                                                    onCancel:(KKAreaPickerCancelBlock)cancelBlock
                                                    onCommit:(KKAreaPickerDoneBlock)commitBlock{
    NSMutableArray *data=[[NSMutableArray alloc] init];
    NSArray *stateArray;
    NSDictionary *cityDic;
    NSMutableArray *defaultSelected=[[NSMutableArray alloc] init];
    
    stateArray=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"KKPickerProvice" ofType:@"plist"]];
    cityDic=[NSMutableDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"KKPickerCity" ofType:@"plist"]];
    [data addObject:stateArray];
    [data addObject:cityDic];
    
    NSMutableDictionary *areaDic=[NSMutableDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"KKPickerArea" ofType:@"plist"]];
    
    
    if(optionalCitiesOfProvince==nil){
        NSArray *allProvinces=[cityDic allKeys];
        for (NSString *tProvice in allProvinces) {
            if([SAFE_VALUE_FOR_KEY(cityDic, tProvice) isKindOfClass:[NSArray class]]){
                NSMutableArray *tCitys=[NSMutableArray arrayWithArray:SAFE_VALUE_FOR_KEY(cityDic, tProvice)];
                [tCitys insertObject:@"-不限-" atIndex:0];
                SAFE_SET_VALUE_OF_KEY(cityDic, tProvice, tCitys);
            }
        }
    }else{
        for (NSString *tProvice in optionalCitiesOfProvince) {
            if([SAFE_VALUE_FOR_KEY(cityDic, tProvice) isKindOfClass:[NSArray class]]){
                NSMutableArray *tCitys=[NSMutableArray arrayWithArray:SAFE_VALUE_FOR_KEY(cityDic, tProvice)];
                [tCitys insertObject:@"-不限-" atIndex:0];
                SAFE_SET_VALUE_OF_KEY(cityDic, tProvice, tCitys);
            }
        }
    }
    
    NSMutableDictionary *newAreaDic=[[NSMutableDictionary alloc] init];
    if (areaOptional) {
        for (NSString *province in areaDic) {
            NSMutableDictionary *cities=[areaDic safeObjectForKey:province];
            NSMutableDictionary *newCityDic=[[NSMutableDictionary alloc] init];
            for (NSString *city in cities) {
                NSMutableArray *tAreas=[NSMutableArray arrayWithArray:SAFE_VALUE_FOR_KEY(SAFE_VALUE_FOR_KEY(areaDic, province), city)];
                if ([tAreas count]>0) {
                    [tAreas insertObject:@"-不限-" atIndex:0];
                    [newCityDic safeSetObject:tAreas forKey:city];
                }
            }
            [newAreaDic safeSetObject:newCityDic forKey:province];
        }
    }else{
        newAreaDic=areaDic;
    }
    
    [data addObject:newAreaDic];
    
    if(adress){
        if(adress.provice){
            NSInteger index0=[stateArray indexOfObject:adress.provice];
            [defaultSelected safeAddObject:[NSNumber numberWithInt:(int)index0]];
            if(adress.city){
                NSInteger index1=[[cityDic safeObjectForKey:adress.provice] indexOfObject:adress.city];
                [defaultSelected safeAddObject:[NSNumber numberWithInt:(int)index1]];
                if(adress.area){
                    NSInteger index2=[[[newAreaDic safeObjectForKey:adress.provice] safeObjectForKey:adress.city] indexOfObject:adress.area];
                    [defaultSelected safeAddObject:[NSNumber numberWithInt:(int)index2]];
                }
            }
        }
    }
    
    KKAreaPicker *p=[[KKAreaPicker alloc] initWithTitle:aTitle data:data selectedIndex:defaultSelected onCancel:^(KKMultiStringPicker *picker) {
        if (cancelBlock) {
            cancelBlock(p);
        }
    } onCommit:^(KKMultiStringPicker *picker, NSArray *selectedIndexArray, NSArray *selectedValueArray) {
        KKAdrress *address=[[KKAdrress alloc] init];
        for (int i=0; i<[selectedValueArray count]; i++) {
            switch (i) {
                case 0:
                    if (![selectedValueArray[i] isEqualToString:@"-不限-"]) {
                        address.provice=selectedValueArray[i];
                    }
                    break;
                case 1:
                    if (![selectedValueArray[i] isEqualToString:@"-不限-"]) {
                        address.city=selectedValueArray[i];
                    }
                    break;
                case 2:
                    if (![selectedValueArray[i] isEqualToString:@"-不限-"]) {
                        address.area=selectedValueArray[i];
                    }
            }
        }
        if (commitBlock) {
            commitBlock(p,address);
        }
    }];
    [p show];
    return p;
}

@end
