//
//  KKRangePicker.m
//  swingers
//
//  Created by Jaykon on 16/2/27.
//  Copyright © 2016年 Jaykon. All rights reserved.
//

#import "KKRangePicker.h"

@interface KKRangePicker()<UIPickerViewDataSource,UIPickerViewDelegate>
@property(copy,nonatomic)KKRangePickerCancelBlock cancelBlock;
@property(copy,nonatomic)KKRangePickerDoneBlock commitRangeBlock;
@property(copy,nonatomic)KKNumberPickerDoneBlock commitNumberBlock;
@property(strong,nonatomic)NSArray *rowsData;
@property(strong,nonatomic)NSArray *rowsData1;//第二compement
@property(assign,nonatomic)NSInteger componentCount;
@property(assign,nonatomic)NSInteger maxDiff;
@end

@implementation KKRangePicker

-(instancetype)initPickerWithTitle:(NSString*)aTitle
                              data:(NSArray*)rowsData{
    self=[super initWithTitle:aTitle];
    if(self){
        self.componentCount=1;
        self.rowsData=rowsData;
        [_picker reloadAllComponents];
    }
    return self;
}

+(KKRangePicker*)showNumberPickerWithTitle:(NSString*)aTitle
                                     range:(NSRange)range
                               afterString:(NSString*)afterString
                             selectedValue:(NSString*)selectedValue
                                  onCancel:(KKRangePickerCancelBlock)cancelBlock
                                  onCommit:(KKNumberPickerDoneBlock)commitBlock{
    NSMutableArray *rowsData=[[NSMutableArray alloc] init];
    for (NSInteger i=0; i<range.length; i++) {
        [rowsData addObject:[NSString stringWithFormat:@"%u%@",i+range.location,afterString]];
    }
    KKRangePicker *picker=[[KKRangePicker alloc] initPickerWithTitle:aTitle data:rowsData];
    picker.cancelBlock=cancelBlock;
    picker.commitNumberBlock=commitBlock;
    [picker show];
    return picker;
}

+(KKRangePicker*)showNumberRangePickerWithTitle:(NSString*)aTitle
                                          range:(NSRange)range
                                        maxDiff:(NSInteger)maxDiff
                                  selectedValue:(NSString*)selectedValue
                                       onCancel:(KKRangePickerCancelBlock)cancelBlock
                                       onCommit:(KKRangePickerDoneBlock)commitBlock{
    NSMutableArray *rowsData=[[NSMutableArray alloc] init];
    for (NSInteger i=0; i<range.length; i++) {
        [rowsData addObject:[NSString stringWithFormat:@"%u",i+range.location]];
    }
    KKRangePicker *picker=[[KKRangePicker alloc] initPickerWithTitle:aTitle data:rowsData];
    picker.rowsData1=rowsData;
    picker.cancelBlock=cancelBlock;
    picker.commitRangeBlock=commitBlock;
    picker.componentCount=2;
    picker.maxDiff=maxDiff;
    [picker show];
    return picker;
}

#pragma mark -- UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.componentCount;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component==0){
        return [_rowsData count];
    }else{
        return [_rowsData1 count];
    }
}

#pragma mark  -- UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component==0){
        return self.rowsData[row];
    }
    return self.rowsData1[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(self.componentCount==2 && component==0){
        NSMutableArray *rowsData1=[[NSMutableArray alloc] init];
        NSInteger row0Value=[_rowsData[row] integerValue];
        for (NSInteger i=row; i<[_rowsData count]; i++) {
            NSInteger row1Value=[_rowsData[i] intValue];
            if(row1Value-row0Value>self.maxDiff){
                break;
            }
            [rowsData1 addObject:[NSString stringWithFormat:@"%ld",row1Value]];
        }
        _rowsData1=rowsData1;
        [pickerView reloadComponent:1];
    }
}

#pragma mark -KKPickerAbstractDelegate
-(UIView *)KKPickerComponentView
{
    UIView *contrainerView=[[UIView alloc] initWithFrame:CGRectMake(0, 44, self.componentContainerView.frame.size.width, 216)];
    contrainerView.backgroundColor=[UIColor whiteColor];
    _picker=[[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.componentContainerView.frame.size.width, 216)];
    _picker.showsSelectionIndicator=YES;
    _picker.dataSource=self;
    _picker.delegate=self;
    [contrainerView addSubview:_picker];
    return contrainerView;
}

-(void)KKPickerCancel
{
    self.cancelBlock(self);
    [self hide];
}

-(void)KKPickerCommit
{
    if(self.componentCount==1){
        self.commitNumberBlock(self,_rowsData[[self.picker selectedRowInComponent:0]]);
    }else{
        self.commitRangeBlock(self,_rowsData[[self.picker selectedRowInComponent:0]],_rowsData1[[self.picker selectedRowInComponent:1]]);
    }
    [self hide];
}

@end
