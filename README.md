# KKPicker

简易选择器，包括文本选择，多文本关联选择，省市地区选择，时间选择。

![Alt Text](https://raw.githubusercontent.com/jaykon/KKPicker/master/KKPickerDemo/RES/demo.gif "sample")

## 样式修改
修改KKPickerAbstract.h文件

## 调用方法
~~~
//单列
[KKStringPicker showPickerWithTitle:@"单列选择器" data:@[@"KK1",@"KK2"] selectedIndex:3 onCancel:^(KKStringPicker *picker) {
                ;
            } onCommit:^(KKStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                NSLog(@"选中%@",selectedValue);
            }];
            

//多列关联
NSArray *dataArray=@[ @[@"KK1",@"KK2"],
@{@"KK1":@[@"KK1-1",@"KK1-2"],@"KK2":@[@"KK2-1",@"KK2-2"]}
                                 ];
            [KKMultiStringPicker showPickerWithTitle:@"多列关联选择" data:dataArray selectedIndex:@[@"3",@"1"] onCancel:^(KKMultiStringPicker *picker) {
                ;
            } onCommit:^(KKMultiStringPicker *picker, NSArray *selectedIndexArray, NSArray *selectedValueArray) {
                NSLog(@"选中%@,%@",selectedValueArray[0],selectedValueArray[1]);
            }];
            
            
            
//省份
KKAdrress *address=[[KKAdrress alloc] init];
address.provice=@"广东";
address.city=@"广州";
address.area=@"天河区";
[KKAreaPicker showPickerWithTitle:@"省市区选择器" pickerType:KKAreaPickerTypeProviceCityArea defaultValue:address onCancel:^(KKAreaPicker *picker) {} onCommit:^(KKAreaPicker *picker, KKAdrress *address) {}];

//日期
[KKDateTimePicker showPickerWithTitle:@"选择日期" pickerMode:UIDatePickerModeDate defaultValue:nil onCancel:^(KKDateTimePicker *picker) {
                NSLog(@"%@",picker);
            } onCommit:^(KKDateTimePicker *picker, NSDate *selectedDate) {
                NSLog(@"%@",selectedDate);
            }];


//单列范围
[KKRangePicker showNumberPickerWithTitle:@"身高选择" range:NSMakeRange(120,80) afterString:@"CM" selectedValue:nil onCancel:^(KKRangePicker *picker) {
                NSLog(@"取消");
            } onCommit:^(KKRangePicker *picker, NSString *selectedValue) {
                NSLog(@"选中:%@",selectedValue);
            }];
       
       
//双列范围
[KKRangePicker showNumberRangePickerWithTitle:@"选择月收入范围" range:NSMakeRange(1000,9000) maxDiff:5000 selectedValue:nil onCancel:^(KKRangePicker *picker) {
                NSLog(@"取消");
            } onCommit:^(KKRangePicker *picker, NSString *selectedValue0, NSString *selectedValue1) {
                NSLog(@"选中:%@ - %@",selectedValue0,selectedValue1);
            }];

~~~