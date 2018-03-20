//
//  CJTextField.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//
//  类似：[在textField左边设置图片以及图片与textField最左边和文字的距离](https://www.jianshu.com/p/adfd4a30e9c0)

#import <UIKit/UIKit.h>

/**
 *  常用语处理，textField两边有如①数字加减、②日期加减、③登录文本框前的图片的情况
 */
@interface CJTextField : UITextField

//以下四个属性的设置的前提：是必须有 leftView 和 rightView 的存在。如果为了省去设置，可直接使用
@property (nonatomic, assign) CGFloat leftViewLeftOffset;   /**< 左视图距左边框的距离 */
@property (nonatomic, assign) CGFloat leftViewRightOffset;  /**< 左视图距文字的距离 */

@property (nonatomic, assign) CGFloat rightViewRightOffset; /**< 右视图距右边框的距离 */
@property (nonatomic, assign) CGFloat rightViewLeftOffset;  /**< 右视图距文字的距离 */


@end
