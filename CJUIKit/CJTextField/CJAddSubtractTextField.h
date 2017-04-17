//
//  CJAddSubtractTextField.h
//  CJUIKitDemo
//
//  Created by dvlproad on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "CJTextField.h"

/**
 *  可在两边添加加减的textField(可用于①数字加减、②日期加减、③登录文本框前的图片)
 *
 */
@interface CJAddSubtractTextField : CJTextField

- (void)addLeftButtonImage:(UIImage *)leftImage withLeftHandel:(void (^)(UITextField *textField))leftHandle;

- (void)addRightButtonImage:(UIImage *)rightImage withRightHandel:(void (^)(UITextField *textField))rightHandle;

@end
