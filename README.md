#KKPicker

简易选择器，包括文本选择，多文本关联选择，省市地区选择，时间选择。

![Alt Text](https://raw.githubusercontent.com/jaykon/KKPicker/master/KKPickerDemo/RES/1.png "sample")


![Alt Text](https://raw.githubusercontent.com/jaykon/KKPicker/master/KKPickerDemo/RES/2.pngg "sample")


![Alt Text](https://raw.githubusercontent.com/jaykon/KKPicker/master/KKPickerDemo/RES/3.png "sample")

![Alt Text](https://raw.githubusercontent.com/jaykon/KKPicker/master/KKPickerDemo/RES/4.png "sample")

###require:
ARC,iOS5+

###使用方法
[KKStringPicker showPickerWithTitle:@"单列选择器" data:@[@"KK1",@"KK2",@"KK3",@"KK4",@"KK5",@"KK6"] selectedIndex:3 onCancel:^(KKStringPicker *picker) {
        ;
    } onCommit:^(KKStringPicker *picker, NSInteger selectedIndex, id selectedValue) {

 }];
