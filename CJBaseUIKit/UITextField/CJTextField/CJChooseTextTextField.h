//
//  CJChooseTextTextField.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "CJTextField.h"

/**
 *  一个文本框中的文本只能来源于选择的文本框（常用于类似文本框中的文本只能来源于pickerView的时候)
 *  一个文本框中的文本只能来源于选择的时候，因为这是一个pickerView,而不是系统或自定义的输入键盘等,所以首先肯定需要①隐藏光标，其次一般②最多允许弹出选择、复制操作
 */
@interface CJChooseTextTextField : CJTextField

@property (nonatomic, assign) BOOL hideMenuController;  /**< 是否隐藏弹出菜单(禁止手动输入的同时，最多允许弹出选择、复制操作) */

/**
 *  设置textField的值只能来源于指定pickerView的选择
 *
 *  @param pickerView 指定的pickerView
 */
- (void)setTextOnlyFromPickerView:(UIView *)pickerView;


@end
