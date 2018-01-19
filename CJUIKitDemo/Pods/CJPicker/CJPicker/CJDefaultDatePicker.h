//
//  CJDefaultDatePicker.h
//  CJPickerDemo
//
//  Created by ciyouzen on 6/20/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  可以设置添加toolbar的含UIDatePicker的控件
 *
 */
@interface CJDefaultDatePicker : UIView {
    
}
@property (nonatomic, strong) UIDatePicker *datePicker; //UIDatePicker默认216的高
@property (nonatomic, strong, readonly) UIToolbar *toolbar;
@property (nonatomic, strong, readonly) NSDateFormatter *dateFormatter;

@property (nonatomic, copy) void(^valueChangedHandel)(UIDatePicker *datePicker);

- (void)addToolbar:(UIToolbar *)toolbar;

@end
