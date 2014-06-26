//
//  KKPickerAbstract.m
//  stock
//
//  Created by Jaykon on 14-5-22.
//  Copyright (c) 2014年 Maxicn. All rights reserved.
//

#import "KKPickerAbstract.h"
@interface KKPickerAbstract()
@property(assign,nonatomic)CGRect componentViewShowFrame;
@property(assign,nonatomic)CGRect componentViewHideFrame;
@end

@implementation KKPickerAbstract
-(instancetype)initWithTitle:(NSString*)aTitle
{
    self=[super init];
    if(self){
        UIWindow *window=[[UIApplication sharedApplication].delegate window];
        CGFloat wH=window.frame.size.height;
        CGFloat wW=window.frame.size.width;
        _componentViewShowFrame=CGRectMake(0, wH-260, wW, 260);
        _componentViewHideFrame=CGRectMake(0, wH, wW, 260);
        self.frame=window.frame;
        self.backgroundColor=[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.0];
        _componentContainerView=[[UIView alloc] initWithFrame:_componentViewHideFrame];
        
        UIView *componentView=[self KKPickerComponentView];
        
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0,wW, 44)];
        numberToolbar.barStyle = UIBarStyleBlackTranslucent;
        UIBarButtonItem *barCancel=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(KKPickerCancel)];
        //[barCancel setTintColor:[UIColor whiteColor]];
        UIBarButtonItem *barCommit=[[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(KKPickerCommit)];
        //[barCommit setTintColor:[UIColor whiteColor]];
        UIBarButtonItem *middleBarItem=[[UIBarButtonItem alloc]initWithTitle:aTitle style:UIBarButtonItemStylePlain target:nil action:nil];
        [middleBarItem setTintColor:[UIColor whiteColor]];
        numberToolbar.items = [NSArray arrayWithObjects:
                               barCancel,
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               middleBarItem,
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               barCommit,
                               nil];
        
        [numberToolbar sizeToFit];
        [_componentContainerView addSubview:numberToolbar];
        [_componentContainerView addSubview:componentView];
        [self addSubview:_componentContainerView];
        [window addSubview:self];
    }
    return self;
}

-(void)show
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.backgroundColor=[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.20];
        _componentContainerView.frame=_componentViewShowFrame;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)hide
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.backgroundColor=[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.0];
        _componentContainerView.frame=_componentViewHideFrame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)dealloc
{
    NSLog(@"KKPicker Dealloc!!");
}


#pragma mark -KKPickerAbstractDelegate
-(UIView *)KKPickerComponentView
{
    NSLog(@"must implementation -(UIView *)KKPickerComponentView");
    return nil;
}

-(void)KKPickerCancel
{
    [self hide];
    NSLog(@"KKPickerCancel:");
}

-(void)KKPickerCommit
{
    [self hide];
    NSLog(@"KKPickerCommit:");
}
@end
