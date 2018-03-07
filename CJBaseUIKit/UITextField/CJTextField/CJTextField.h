//
//  CJTextField.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//
//  类似：[在textField左边设置图片以及图片与textField最左边和文字的距离](https://www.jianshu.com/p/adfd4a30e9c0)

#import <UIKit/UIKit.h>

@interface CJTextField : UITextField

@property (nonatomic, assign) CGFloat leftViewLeftOffset;   /**< 左视图距左边框的距离 */
@property (nonatomic, assign) CGFloat leftViewRightOffset;  /**< 左视图距文字的距离 */

@property (nonatomic, assign) CGFloat rightViewRightOffset; /**< 右视图距右边框的距离 */
@property (nonatomic, assign) CGFloat rightViewLeftOffset;  /**< 右视图距文字的距离 */


@end
