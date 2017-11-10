//
//  UITextField+CJAddLeftRightView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  可在两边添加加减的textField(可用于①数字加减、②日期加减、③登录文本框前的图片)
 *
 */
@interface UITextField (CJAddLeftRightView)

- (UIButton *)addLeftButtonWithNormalImage:(UIImage *)leftNormalImage leftHandel:(void (^)(UITextField *textField))leftHandle;

- (UIButton *)addRightButtonWithNormalImage:(UIImage *)rightNormalImage rightHandel:(void (^)(UITextField *textField))rightHandle;

@end
