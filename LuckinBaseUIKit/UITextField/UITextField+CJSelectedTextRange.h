//
//  UITextField+CJSelectedTextRange.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/11/30.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (CJSelectedTextRange) {
    
}
//@property (nonatomic) NSRange cjSelectedTextRange;  /**< textField当前选中的文本区域(系统的是UITextRange，这里自己用NSRange结构) */

/**
 *  获取当前textField选中的文本区域
 *
 *  @return 当前textField选中的文本区域(系统的是返回UITextRange，这里自己用NSRange结构返回)
 */
- (NSRange)cjSelectedTextRange;

/**
 *  设置当前textField选中的文本区域
 *
 *  @param range 文本区域(系统的是UITextRange，这里自己用NSRange结构)
 */
- (void)setCjSelectedTextRange:(NSRange)range;

@end
