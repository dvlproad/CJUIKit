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

/**
 *  设置文字距左边框的距离
 *
 *  @param leftOffset 文字距左边框的距离
 */
- (void)cj_addLeftOffset:(CGFloat)leftOffset;

/**
 *  设置文字距右边框的距离
 *
 *  @param rightOffset 设置文字距右边框的距离
 */
- (void)cj_addRightOffset:(CGFloat)rightOffset;


/**
 *  添加按钮作为左视图，并设置其与左边框和文字的距离
 *
 *  @param buttonSize       左视图的大小
 *  @param leftOffset       左视图距左边框的距离
 *  @param rightOffset      左视图距文字的距离
 *  @param leftHandle       左视图的点击动作
 */
- (void)cj_addLeftButton:(UIButton *)button
                withSize:(CGSize)buttonSize
              leftOffset:(CGFloat)leftOffset
             rightOffset:(CGFloat)rightOffset
              leftHandel:(void (^)(UITextField *textField))leftHandle;

/**
 *  添加按钮作为右视图，并设置其与右边框和文字的距离
 *
 *  @param buttonSize       右视图的大小
 *  @param rightOffset      右视图距文字的距离
 *  @param leftOffset       右视图距左边框的距离
 *  @param rightHandle      右视图的点击动作
 */
- (void)cj_addRightButton:(UIButton *)button
                 withSize:(CGSize)buttonSize
              rightOffset:(CGFloat)rightOffset
               leftOffset:(CGFloat)leftOffset
              rightHandle:(void (^)(UITextField *textField))rightHandle;

@end
