//
//  KKStringPicker.m
//  stock
//
//  Created by Jaykon on 14-5-22.
//  Copyright (c) 2014年 Maxicn. All rights reserved.
//

#import "KKStringPicker.h"
@interface KKStringPicker()<UIPickerViewDataSource,UIPickerViewDelegate>
@property(copy,nonatomic)KKStringPickerCancelBlock cancelBlock;
@property(copy,nonatomic)KKStringPickerDoneBlock commitBlock;
@property(strong,nonatomic)NSArray *rowsData;
@property(strong,nonatomic)UIPickerView *picker;
@property(assign,nonatomic)NSInteger selectedRowIndex;
@end

@implementation KKStringPicker
+(KKStringPicker*)showPickerWithTitle:(NSString*)aTitle data:(NSArray*)rowsData selectedIndex:(NSInteger)selectedIndex onCancel:(KKStringPickerCancelBlock)cancelBlock onCommit:(KKStringPickerDoneBlock)commitBlock
{
    KKStringPicker *picker=[[KKStringPicker alloc] initPickerWithTitle:aTitle data:rowsData selectedIndex:selectedIndex onCancel:cancelBlock onCommit:commitBlock];
    [picker show];
    return picker;
}

-(instancetype)initPickerWithTitle:(NSString*)aTitle data:(NSArray*)rowsData selectedIndex:(NSInteger)selectedIndex onCancel:(KKStringPickerCancelBlock)cancelBlock onCommit:(KKStringPickerDoneBlock)commitBlock
{
    self=[super initWithTitle:aTitle];
    if(self){
        self.cancelBlock=cancelBlock;
        self.commitBlock=commitBlock;
        self.rowsData=rowsData;
        [_picker reloadAllComponents];
        if(selectedIndex<[rowsData count]){
            [_picker selectRow:selectedIndex inComponent:0 animated:NO];
        }
    }
    return self;
}

#pragma mark -- UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.rowsData count];
}

#pragma mark  -- UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.rowsData[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _selectedRowIndex=row;
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
    self.commitBlock(self,_selectedRowIndex,_rowsData[_selectedRowIndex]);
    [self hide];
}
@end
