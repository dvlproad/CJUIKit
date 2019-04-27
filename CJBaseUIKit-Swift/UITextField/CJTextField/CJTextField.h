//
//  CJTextField.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextField+CJForbidKeyboard.h"

/// 文本框菜单禁止的类型
typedef NS_ENUM(NSUInteger, CJTextFieldForbidMenuType) {
    CJTextFieldForbidMenuTypeNone = 0,      /**< 不禁止 */
    CJTextFieldForbidMenuTypeAll,           /**< 禁止所有 */
    CJTextFieldForbidMenuTypeSelectPaste,   /**< 禁止选择和粘贴 */
};

/**
 *  常用语处理，textField两边有如①数字加减、②日期加减、③登录文本框前的图片的情况
 */
@interface CJTextField : UITextField {
    
}
@property (nonatomic, assign) CJTextFieldForbidMenuType forbidMenuType; /**< 文本框菜单禁止的类型 */

//以下四个属性的设置的前提：是必须有 leftView 和 rightView 的存在。如果为了省去设置，可直接使用
@property (nonatomic, assign) CGFloat leftViewLeftOffset;   /**< 左视图距左边框的距离 */
@property (nonatomic, assign) CGFloat leftViewRightOffset;  /**< 左视图距文字的距离 */

@property (nonatomic, assign) CGFloat rightViewRightOffset; /**< 右视图距右边框的距离 */
@property (nonatomic, assign) CGFloat rightViewLeftOffset;  /**< 右视图距文字的距离 */


/// 在 textField 左侧添加 图片(使用场景：登录等)
@property (nonatomic, assign) BOOL leftButtonSelected;  /**< 左侧图片是否选中 */
- (void)addLeftImageWithNormalImage:(UIImage *)normalImage
                      selectedImage:(UIImage *)selectedImage
                          imageSize:(CGSize)imageSize;

/**
 *  在 textField 底部添加下划线
 *
 *  @param lineHeight   lineHeight
 *  @param lineColor    lineColor
 *  @param leftMargin   leftMargin
 *  @param rightMargin  rightMargin
 */
- (void)addUnderLineWithHeight:(CGFloat)lineHeight
                         color:(UIColor *)lineColor
                    leftMargin:(CGFloat)leftMargin
                   rightMargin:(CGFloat)rightMargin;

@end
