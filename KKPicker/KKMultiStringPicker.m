//
//  KKMultiStringPicker.m
//  stock
//
//  Created by Jaykon on 14-5-22.
//  Copyright (c) 2014年 Maxicn. All rights reserved.
//

#import "KKMultiStringPicker.h"
@interface KKMultiStringPicker()<UIPickerViewDataSource,UIPickerViewDelegate>
@property(copy,nonatomic)KKMultiStringPickerCancelBlock cancelBlock;
@property(copy,nonatomic)KKMultiStringPickerDoneBlock commitBlock;
@property(strong,nonatomic)NSArray *rowsData;
@property(strong,nonatomic)NSMutableArray *selectedRowIndexArray;
@property(strong,nonatomic)NSMutableArray *selectedRowValueArray;
@end

@implementation KKMultiStringPicker
+(KKMultiStringPicker*)showPickerWithTitle:(NSString*)aTitle data:(NSArray*)rowsData selectedIndex:(NSArray*)selectedIndexArray onCancel:(KKMultiStringPickerCancelBlock)cancelBlock onCommit:(KKMultiStringPickerDoneBlock)commitBlock
{
    KKMultiStringPicker *apicker=[[KKMultiStringPicker alloc] initWithTitle:aTitle data:rowsData selectedIndex:selectedIndexArray onCancel:cancelBlock onCommit:commitBlock];
    [apicker show];
    return apicker;
}

-(instancetype)initWithTitle:(NSString*)aTitle data:(NSArray*)rowsData selectedIndex:(NSArray*)selectedIndexArray onCancel:(KKMultiStringPickerCancelBlock)cancelBlock onCommit:(KKMultiStringPickerDoneBlock)commitBlock
{
    self=[super initWithTitle:aTitle];
    if(self){
        self.cancelBlock=cancelBlock;
        self.commitBlock=commitBlock;
        self.rowsData=rowsData;
        self.selectedRowIndexArray=[[NSMutableArray alloc] initWithArray:selectedIndexArray];
        self.selectedRowValueArray=[[NSMutableArray alloc] init];
        
        
        for (int i=0; i<[rowsData count]; i++) {
            
            int selectedIndex=[[selectedIndexArray safeObjectAtIndex:i] intValue];
            
            if([rowsData[i] isKindOfClass:[NSArray class]]){
                if([selectedIndexArray count]<=i || selectedIndex>=[rowsData[i] count]){
                    self.selectedRowIndexArray[i]=[NSNumber numberWithInt:0];
                    self.selectedRowValueArray[i]=rowsData[i][0];
                }else{
                    self.selectedRowIndexArray[i]=[NSNumber numberWithInt:selectedIndex];
                    self.selectedRowValueArray[i]=[rowsData[i] safeObjectAtIndex:selectedIndex];
                }
            }else if ([rowsData[i] isKindOfClass:[NSDictionary class]]){
                NSString *selectedValue=self.selectedRowValueArray[i-1];
                if([selectedIndexArray count]<=i || selectedIndex>=[[rowsData[i] safeObjectForKey:selectedValue] count]){
                    self.selectedRowIndexArray[i]=[NSNumber numberWithInt:0];
                    [self.selectedRowValueArray safeSetObject:[[rowsData[i] safeObjectForKey:selectedValue] safeObjectAtIndex:0] atIndexedSubscript:i default:@""];
                }else{
                    self.selectedRowIndexArray[i]=selectedIndexArray[i];
                    NSString *rowValue=[[rowsData[i] safeObjectForKey:selectedValue]safeObjectAtIndex:selectedIndex];
                    [self.selectedRowValueArray safeSetObject:rowValue atIndexedSubscript:i default:@""];
                }
            }
        }
        
        [_picker reloadAllComponents];
        
        for (int i=0; i<[selectedIndexArray count]; i++) {
            if(i>=[rowsData count]||[selectedIndexArray[i] intValue]>[_picker numberOfRowsInComponent:i]){
                break;
            }
            [_picker selectRow:[selectedIndexArray[i] intValue] inComponent:i animated:NO];
        }
    }
    return self;
}

/*
-(BOOL)analyzData:(id)data level:(int)cLevel
{
    if([data isKindOfClass:[NSArray class]]){
        _componentDataArray[cLevel]=data;
        cLevel++;
        [self analyzData:data[0] level:cLevel];
    }else if([data isKindOfClass:[NSDictionary class]]){
        NSDictionary *tDic=data;
        NSArray *keys=[tDic allKeys];
        
        if([keys count]!=2){
            return NO;
        }
        
        if([tDic[keys[0]] isKindOfClass:[NSString class]]){
            [_keyArray addObject:keys[0]];
            [_valueArray addObject:keys[1]];
            [self analyzData:tDic[keys[1]] level:cLevel];
        }else{
            [_keyArray addObject:keys[1]];
            [_valueArray addObject:keys[0]];
            [self analyzData:tDic[keys[0]] level:cLevel];
        }
    }else if ([data isKindOfClass:[NSString class]]){
        
    }
    return YES;
}


-(NSArray*)nextComponentData:(id)data CurrentLevel:(int)cLevel targetLevel:(int)tLevel row:(int)targetRow
{
    if(cLevel==tLevel){
        if([data isKindOfClass:[NSArray class]]){
            return data;
        }else{
            return [data objectForKey:_valueArray[cLevel-1]];
        }
    }else{
        id tem;
        if([data[targetRow] isKindOfClass:[NSArray class]]){
            tem=data[targetRow];
        }else{
            tem=[data[targetRow] objectForKey:_valueArray[cLevel]];
        }
        cLevel++;
        return [self nextComponentData:tem CurrentLevel:cLevel targetLevel:tLevel row:targetRow];
    }
}
*/

#pragma mark -- UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return [self.rowsData count];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if([_rowsData[component] isKindOfClass:[NSArray class]]){
        return [_rowsData[component] count];
    }else if ([_rowsData[component] isKindOfClass:[NSDictionary class]]){
        return [[_rowsData[component] valueForKey:_selectedRowValueArray[component-1]] count];
    }
    return 0;
    //NSLog(@"component(%d)=>%d",component,[self.rowsData[component] count]);
}

#pragma mark  -- UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    id obj=_rowsData[component];
    NSString *returnString;
    if([obj isKindOfClass:[NSDictionary class]]){
        returnString =[[obj safeObjectForKey:_selectedRowValueArray[component-1]] safeObjectAtIndex:row];
    }else if([obj isKindOfClass:[NSArray class]]){
        returnString= _rowsData[component][row];
    }
    return returnString==nil?@"":returnString;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _selectedRowIndexArray[component]=[NSNumber numberWithInt:row];
    _selectedRowValueArray[component]=[self pickerView:nil titleForRow:row forComponent:component];
    if(component<[_rowsData count]-1){
        [_picker reloadComponent:component+1];
        [self pickerView:_picker didSelectRow:0 inComponent:component+1];
        [_picker selectRow:0 inComponent:component+1 animated:YES];
    }
}

#pragma mark -KKPickerAbstractDelegate
-(UIView *)KKPickerComponentView
{
    UIView *contrainerView=[[UIView alloc] initWithFrame:CGRectMake(0, 44, self.componentContainerView.frame.size.width, 216)];
    contrainerView.backgroundColor=[UIColor whiteColor];
    _picker=[[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.componentContainerView.frame.size.width, 216)];
    _picker.dataSource=self;
    _picker.delegate=self;
    _picker.showsSelectionIndicator=YES;
    [contrainerView addSubview:_picker];
    return contrainerView;
}

-(void)KKPickerCancel
{
    if(self.cancelBlock){
        self.cancelBlock(self);
    }
    [self hide];
}

-(void)KKPickerCommit
{
    self.commitBlock(self,_selectedRowIndexArray,_selectedRowValueArray);
    [self hide];
}
@end
