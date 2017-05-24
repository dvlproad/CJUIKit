//
//  CJSelectTextTextField.h
//  CJUIKitDemo
//
//  Created by dvlproad on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  一个文本框中的文本只能来源于选择的文本框（常用于类似文本框中的文本只能来源于pickerView的时候)
 *  一个文本框中的文本只能来源于选择的时候，需要①隐藏光标，②最多允许弹出选择、复制操作
 */
@interface CJSelectTextTextField : UITextField

@property (nonatomic, assign) BOOL hideMenuController;  /**< 是否隐藏弹出菜单(禁止手动输入的同时，最多允许弹出选择、复制操作) */

- (void)setTextOnlyFromInputView:(UIView *)inputView;


@end
