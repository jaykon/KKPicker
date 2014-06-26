//
//  ViewController.m
//  KKPickerDemo
//
//  Created by Jaykon on 14-6-26.
//  Copyright (c) 2014年 Jaykon. All rights reserved.
//

#import "ViewController.h"
#import "KKAreaPicker.h"
#import "KKStringPicker.h"
@interface ViewController ()
- (IBAction)singleComponent:(id)sender;
- (IBAction)mutiComponent:(id)sender;
- (IBAction)provice:(id)sender;
- (IBAction)city:(id)sender;
- (IBAction)area:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)singleComponent:(id)sender {
    [KKStringPicker showPickerWithTitle:@"单列选择器" data:@[@"KK1",@"KK2",@"KK3",@"KK4",@"KK5",@"KK6"] selectedIndex:3 onCancel:^(KKStringPicker *picker) {
        ;
    } onCommit:^(KKStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        UIButton *btn=sender;
        [btn setTitle:[NSString stringWithFormat:@"选中:%@",selectedValue] forState:UIControlStateNormal];
    }];
}

- (IBAction)mutiComponent:(id)sender {
    NSArray *dataArray=@[
                         @[@"KK1",@"KK2",@"KK3",@"KK4",@"KK5",@"KK6"],
                         @{
                             @"KK1":@[@"KK1-1",@"KK1-2"],
                             @"KK2":@[@"KK2-1",@"KK2-2"],
                             @"KK3":@[@"KK3-1",@"KK3-2"],
                             @"KK4":@[@"KK4-1",@"KK4-2"],
                             @"KK5":@[@"KK5-1",@"KK5-2"],
                             @"KK6":@[@"KK6-1",@"KK6-2"],
                             }
                         ];
    [KKMultiStringPicker showPickerWithTitle:@"多列关联选择" data:dataArray selectedIndex:@[@"3",@"1"] onCancel:^(KKMultiStringPicker *picker) {
        ;
    } onCommit:^(KKMultiStringPicker *picker, NSArray *selectedIndexArray, NSArray *selectedValueArray) {
        UIButton *btn=sender;
        [btn setTitle:[NSString stringWithFormat:@"选中:%@，%@",selectedValueArray[0],selectedValueArray[1]] forState:UIControlStateNormal];
    }];
}

- (IBAction)provice:(id)sender {
    [KKAreaPicker showPickerWithTitle:@"省份选择" pickerType:KKAreaPickerTypeProvice defaultValue:nil onCancel:^(KKAreaPicker *picker) {
        ;
    } onCommit:^(KKAreaPicker *picker, KKAdrress *address) {
        UIButton *btn=sender;
        [btn setTitle:[NSString stringWithFormat:@"选中:%@，",address.provice] forState:UIControlStateNormal];
    }];
}

- (IBAction)city:(id)sender {
    [KKAreaPicker showPickerWithTitle:@"省市选择" pickerType:KKAreaPickerTypeProviceCity defaultValue:nil onCancel:^(KKAreaPicker *picker) {
        ;
    } onCommit:^(KKAreaPicker *picker, KKAdrress *address) {
        UIButton *btn=sender;
        [btn setTitle:[NSString stringWithFormat:@"选中:%@，%@",address.provice,address.city] forState:UIControlStateNormal];
    }];
}

- (IBAction)area:(id)sender {
    
    KKAdrress *address=[[KKAdrress alloc] init];
    
    address.provice=@"广东";
    address.city=@"广州";
    address.area=@"天河区";
    
    [KKAreaPicker showPickerWithTitle:@"省市区选择" pickerType:KKAreaPickerTypeProviceCityArea defaultValue:address onCancel:^(KKAreaPicker *picker) {
        ;
    } onCommit:^(KKAreaPicker *picker, KKAdrress *address) {
        UIButton *btn=sender;
        [btn setTitle:[NSString stringWithFormat:@"选中:%@，%@，%@",address.provice,address.city,address.area] forState:UIControlStateNormal];
    }];
}
@end
