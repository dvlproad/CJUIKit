//
//  CJIndependentPickerView.h
//  CJPickerDemo
//
//  Created by ciyouzen on 6/20/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  含toolbar以及UIPickerView默认样式的控件（用于例如体重60.5kg各部分的独立选择）
 *
 */
@interface CJIndependentPickerView : UIView <UIPickerViewDataSource, UIPickerViewDelegate>{
    
}
@property (nonatomic, strong) UIPickerView *pickerView; //UIPickerView默认216的高
@property (nonatomic, strong, readonly) UIToolbar *toolbar;

@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) NSMutableArray *selecteds;
@property (nonatomic, strong) NSArray *selecteds_default;


@property (nonatomic, copy) void(^valueChangedHandel)(UIPickerView *pickerView);

- (void)addToolbar:(UIToolbar *)toolbar;

@end
