//
//  KKPickerAbstract.h
//  stock
//
//  Created by Jaykon on 14-5-22.
//  Copyright (c) 2014年 Maxicn. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol KKPickerAbstractDelegate
@optional
-(void)KKPickerCancel;
-(void)KKPickerCommit;
@required
-(UIView*)KKPickerComponentView;
@end

@interface KKPickerAbstract : UIView <KKPickerAbstractDelegate>
@property(strong,nonatomic)UIView *componentContainerView;
-(instancetype)initWithTitle:(NSString*)aTitle;
-(void)show;
-(void)hide;
@end
