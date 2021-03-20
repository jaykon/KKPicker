//
//  KKMultiStringPicker.m
//  stock
//
//  Created by jaykon on 14-5-22.
//  Copyright (c) 2014年 jaykon. All rights reserved.
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
                NSString *selectedValue=[rowsData[i] safeObjectAtIndex:[selectedIndexArray[i] intValue]];
                if([selectedIndexArray count]<=i || selectedIndex>=[rowsData[i] count]){
                    self.selectedRowIndexArray[i]=[NSNumber numberWithInt:0];
                    self.selectedRowValueArray[i]=rowsData[i][0];
                }else{
                    self.selectedRowIndexArray[i]=selectedIndexArray[i];
                    self.selectedRowValueArray[i]=selectedValue;
                }
            }else if ([rowsData[i] isKindOfClass:[NSDictionary class]]){
                
                id selectedValue=rowsData[i];
                for (int j=0; j<self.selectedRowValueArray.count; j++) {
                    if ([selectedValue isKindOfClass:[NSString class]]) {
                        self.selectedRowIndexArray[i]=selectedIndexArray[i];
                        [self.selectedRowValueArray safeSetObject:selectedValue atIndexedSubscript:i default:@""];
                    }else{
                        selectedValue=[selectedValue safeObjectForKey:self.selectedRowValueArray[j]];
                    }
                }
                
                if ([selectedValue isKindOfClass:[NSArray class]]) {
                    if([selectedIndexArray count]<=i || selectedIndex>=[rowsData[i] count]){
                        self.selectedRowIndexArray[i]=[NSNumber numberWithInt:0];
                        if ([selectedValue count]>0) {
                            self.selectedRowValueArray[i]=selectedValue[0];
                        }else{
                            self.selectedRowValueArray[i]=@"";
                        }
                        
                    }else{
                        selectedValue=[selectedValue safeObjectAtIndex:[selectedIndexArray[i] intValue]];
                        self.selectedRowIndexArray[i]=selectedIndexArray[i];
                        [self.selectedRowValueArray safeSetObject:selectedValue atIndexedSubscript:i default:@""];
                    }
                }
            }
        }
        
        [_picker reloadAllComponents];
        
        for (int i=0; i<[selectedIndexArray count]; i++) {
            if(i>=[rowsData count]||[selectedIndexArray[i] intValue]>[_picker numberOfRowsInComponent:i]||[selectedIndexArray[i] intValue]<0){
                break;
            }
            [_picker selectRow:[selectedIndexArray[i] intValue] inComponent:i animated:NO];
        }
    }
    return self;
}

#pragma mark -- UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return [self.rowsData count];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    id obj=_rowsData[component];
    NSArray *rows=[self rowArrayWithObj:obj loopCount:0];
    return [rows count];
    //NSLog(@"component(%d)=>%d",component,[self.rowsData[component] count]);
}

#pragma mark  -- UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    id obj=_rowsData[component];
    NSArray *rows=[self rowArrayWithObj:obj loopCount:0];
    NSString *title=[rows safeObjectAtIndex:row];
    return title?title:@"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _selectedRowIndexArray[component]=[NSNumber numberWithInt:row];
    _selectedRowValueArray[component]=[self pickerView:_picker titleForRow:row forComponent:component];
    if(component<[_rowsData count]-1){
        [_picker reloadComponent:component+1];
        [self pickerView:_picker didSelectRow:0 inComponent:component+1];
        [_picker selectRow:0 inComponent:component+1 animated:YES];
    }
}

-(NSArray*)rowArrayWithObj:(id)obj loopCount:(NSInteger)loopCount{
    if ([obj isKindOfClass:[NSDictionary class]]) {
        id obj2=[obj safeObjectForKey:[_selectedRowValueArray safeObjectAtIndex:loopCount]];
        if ([obj2 isKindOfClass:[NSDictionary class]]) {
            NSInteger loopNextCount=loopCount+1;
            return [self rowArrayWithObj:obj2 loopCount:loopNextCount];
        }else if ([obj2 isKindOfClass:[NSArray class]]){
            return obj2;
        }
        return @[];
    }else if ([obj isKindOfClass:[NSArray class]]){
        return obj;
    }
    return @[];
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
    if (self.commitBlock) {
        self.commitBlock(self,_selectedRowIndexArray,_selectedRowValueArray);
    }
    [self hide];
}
@end
