//
//  KKRangePicker.m
//  swingers
//
//  Created by jaykon on 16/2/27.
//  Copyright © 2016年 jaykon. All rights reserved.
//

#import "KKRangePicker.h"

@interface KKRangePicker()<UIPickerViewDataSource,UIPickerViewDelegate>
@property(copy,nonatomic)KKRangePickerCancelBlock cancelBlock;
@property(copy,nonatomic)KKRangePickerDoneBlock commitRangeBlock;
@property(copy,nonatomic)KKNumberPickerDoneBlock commitNumberBlock;
@property(strong,nonatomic)NSArray *rowsData0;
@property(strong,nonatomic)NSArray *rowsData1;//第二compement
@property(assign,nonatomic)NSInteger componentCount;
@property(assign,nonatomic)BOOL isRange;
@end

@implementation KKRangePicker

-(instancetype)initPickerWithTitle:(NSString*)aTitle
                         rowsData0:(NSArray*)rowsData0
                         rowsData1:(NSArray*)rowsData1{
    self=[super initWithTitle:aTitle];
    if(self){
        self.componentCount=1;
        self.rowsData0=rowsData0;
        if (rowsData1) {
            self.componentCount=2;
            self.rowsData1=rowsData1;
        }
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
        [rowsData addObject:[NSString stringWithFormat:@"%zd%@",i+range.location,afterString]];
    }
    KKRangePicker *picker=[[KKRangePicker alloc]initPickerWithTitle:aTitle rowsData0:rowsData rowsData1:nil];
    picker.cancelBlock=cancelBlock;
    picker.commitNumberBlock=commitBlock;
    NSUInteger selectedIndex;
    if (selectedValue) {
        selectedIndex=[rowsData indexOfObject:selectedValue];
    }else{
        selectedIndex=floor(range.length/2);
    }
    [picker.picker selectRow: selectedIndex inComponent:0 animated:YES];
    [picker show];
    return picker;
}

+(KKRangePicker*)showNumberRangePickerWithTitle:(NSString*)aTitle
                                          range:(NSRange)range
                                  selectedRange:(NSRange)selectedRange
                                       onCancel:(KKRangePickerCancelBlock)cancelBlock
                                       onCommit:(KKRangePickerDoneBlock)commitBlock{
    NSMutableArray *rowsData=[[NSMutableArray alloc] init];
    for (NSInteger i=range.location; i<=range.length+range.location; i++) {
        [rowsData addObject:[NSString stringWithFormat:@"%zd",i]];
    }
    NSMutableArray *rowsData1=[[NSMutableArray alloc] init];
    for (NSInteger i=selectedRange.location; i<=range.length+range.location; i++) {
        [rowsData1 addObject:[NSString stringWithFormat:@"%zd",i]];
    }
    KKRangePicker *picker=[[KKRangePicker alloc] initPickerWithTitle:aTitle rowsData0:rowsData rowsData1:rowsData1];
    picker.cancelBlock=cancelBlock;
    picker.commitRangeBlock=commitBlock;
    picker.isRange=YES;
    [picker.picker selectRow:[rowsData indexOfObject:[NSString stringWithFormat:@"%zd",selectedRange.location]] inComponent:0 animated:YES];
    [picker.picker selectRow:[rowsData1 indexOfObject:[NSString stringWithFormat:@"%zd",selectedRange.location+selectedRange.length]]  inComponent:1 animated:YES];
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
        return [_rowsData0 count];
    }else{
        return [_rowsData1 count];
    }
}

#pragma mark  -- UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component==0){
        return self.rowsData0[row];
    }
    return self.rowsData1[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(self.componentCount==2 && component==0){
        NSMutableArray *rowsData1=[[NSMutableArray alloc] init];
        for (NSInteger i=row; i<[_rowsData0 count]; i++) {
            NSInteger row1Value=[_rowsData0[i] unsignedIntValue];
            [rowsData1 addObject:[NSString stringWithFormat:@"%zd",row1Value]];
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
    if (self.cancelBlock) {
        self.cancelBlock(self);
    }
    [self hide];
}

-(void)KKPickerCommit
{
    if(self.componentCount==1 && self.commitNumberBlock){
        self.commitNumberBlock(self,_rowsData0[[self.picker selectedRowInComponent:0]]);
    }else if(self.commitRangeBlock){
        self.commitRangeBlock(self,NSMakeRange([_rowsData0[[self.picker selectedRowInComponent:0]] intValue], [_rowsData1[[self.picker selectedRowInComponent:1]] intValue]-[_rowsData0[[self.picker selectedRowInComponent:0]] intValue]));
    }
    [self hide];
}

@end
