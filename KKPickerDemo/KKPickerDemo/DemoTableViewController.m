//
//  DemoTableViewController.m
//  KKPickerDemo
//
//  Created by Jaykon on 16/4/7.
//  Copyright © 2016年 Jaykon. All rights reserved.
//

#import "DemoTableViewController.h"
#import "KKAreaPicker.h"
#import "KKStringPicker.h"
#import "KKDateTimePicker.h"
#import "KKRangePicker.h"

@interface DemoTableViewController ()

@end

@implementation DemoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            [KKStringPicker showPickerWithTitle:@"单列选择器" data:@[@"KK1",@"KK2"] selectedIndex:3 onCancel:^(KKStringPicker *picker) {
                ;
            } onCommit:^(KKStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                NSLog(@"选中%@",selectedValue);
            }];
            break;
        case 1:{
            NSArray *rowsData=@[
                                @[@"aa",@"bb"],
                                @{@"aa":@[@"aa-1",@"aa-2"],@"bb":@[@"bb-1",@"bb-2"]},
                                @{
                                    @"aa":@{@"aa-1":@[@"aa-1-1",@"aa-1-2"],@"aa-2":@[@"aa-2-1",@"aa-2-2"]},
                                    @"bb":@{@"bb-2":@[@"bb-2-1",@"bb-2-2"]}}
                                ];
            [KKMultiStringPicker showPickerWithTitle:@"三列关联选择" data:rowsData selectedIndex:@[@"3",@"1"] onCancel:^(KKMultiStringPicker *picker) {
                ;
            } onCommit:^(KKMultiStringPicker *picker, NSArray *selectedIndexArray, NSArray *selectedValueArray) {
                NSLog(@"选中%@,%@",selectedValueArray[0],selectedValueArray[1]);
            }];
        }break;
        case 2:{
            [KKAreaPicker showPickerWithTitle:@"省份选择" pickerType:KKAreaPickerTypeProvice defaultValue:nil onCancel:^(KKAreaPicker *picker) {
                ;
            } onCommit:^(KKAreaPicker *picker, KKAdrress *address) {
                NSLog(@"选中:%@",address.provice);
            }];
        }break;
        case 3:{
            [KKAreaPicker showPickerWithTitle:@"省市选择" pickerType:KKAreaPickerTypeProviceCity defaultValue:nil onCancel:^(KKAreaPicker *picker) {
                ;
            } onCommit:^(KKAreaPicker *picker, KKAdrress *address) {
                NSLog(@"选中:%@，%@",address.provice,address.city);
            }];
        }break;
        case 4:{
            KKAdrress *address=[[KKAdrress alloc] init];
            address.provice=@"广东";
            address.city=@"广州";
            address.area=@"天河区";
            [KKAreaPicker showPickerWithTitle:@"省市区选择" pickerType:KKAreaPickerTypeProviceCityArea defaultValue:address onCancel:^(KKAreaPicker *picker) {
                ;
            } onCommit:^(KKAreaPicker *picker, KKAdrress *address) {
                NSLog(@"选中:%@，%@，%@",address.provice,address.city,address.area);
            }];
        }break;
        case 5:{
            [KKDateTimePicker showPickerWithTitle:@"选择日期" pickerMode:UIDatePickerModeDate defaultValue:nil onCancel:^(KKDateTimePicker *picker) {
                NSLog(@"%@",picker);
            } onCommit:^(KKDateTimePicker *picker, NSDate *selectedDate) {
                NSLog(@"%@",selectedDate);
            }];
        }break;
        case 6:{
            [KKRangePicker showNumberPickerWithTitle:@"身高选择" range:NSMakeRange(120,80) afterString:@"CM" selectedValue:nil onCancel:^(KKRangePicker *picker) {
                NSLog(@"取消");
            } onCommit:^(KKRangePicker *picker, NSString *selectedValue) {
                NSLog(@"选中:%@",selectedValue);
            }];
        }break;
        case 7:{
            [KKRangePicker showNumberRangePickerWithTitle:@"选择月收入范围" range:NSMakeRange(1000,9000) selectedRange:NSMakeRange(2000,3000) onCancel:^(KKRangePicker *picker) {
                NSLog(@"取消");
            } onCommit:^(KKRangePicker *picker, NSRange selectedRange) {
                NSLog(@"选中:%d - %d",selectedRange.location,selectedRange.location+selectedRange.length);
            }];
        }break;
        case 8:{
            [KKAreaPicker showPickerWithProviceCityPickerWithTitle:@"选择地区" defaultValue:nil optionalCitiesOfProvince:@[@"北京",@"上海",@"天津",@"重庆",@"澳门",@"香港",@"台湾"] onCancel:nil onCommit:^(KKAreaPicker *picker, KKAdrress *address) {
                NSLog(@"选中:%@，%@，%@",address.provice,address.city,address.area);
            }];
            
        }break;
        case 9:{
            [KKAreaPicker showPickerWithProviceCityAreaPickerWithTitle:@"选择地区" defaultValue:nil optionalCitiesOfProvince:nil areaOptional:YES onCancel:nil onCommit:^(KKAreaPicker *picker, KKAdrress *address) {
                NSLog(@"选中:%@，%@，%@",address.provice,address.city,address.area);
            }];
            
        }break;
        case 10:{
            
        }break;
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
