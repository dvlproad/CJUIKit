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
 *  添加左视图，并左视图距离左边框与文字的距离
 *
 *  @param buttonSize       左视图的大小
 *  @param leftOffset       左视图距左边框的距离
 *  @param rightOffset      左视图距的距离
 *  @param leftNormalImage  左视图的图片
 *  @param leftHandle       左视图的点击动作
 *
 *  @return 左视图
 */
- (UIButton *)cj_addLeftButtonWithSize:(CGSize)buttonSize
                            leftOffset:(CGFloat)leftOffset
                           rightOffset:(CGFloat)rightOffset
                       leftNormalImage:(UIImage *)leftNormalImage
                            leftHandel:(void (^)(UITextField *textField))leftHandle;

/**
 *  添加由视图，并右视图距离右边框与文字的距离
 *
 *  @param buttonSize       右视图的大小
 *  @param rightOffset      右视图距的距离
 *  @param leftOffset       右视图距左边框的距离
 *  @param rightNormalImage 右视图的图片
 *  @param rightHandle      右视图的点击动作
 *
 *  @return 右视图
 */
- (UIButton *)cj_addRightButtonWithSize:(CGSize)buttonSize
                            rightOffset:(CGFloat)rightOffset
                             leftOffset:(CGFloat)leftOffset
                       rightNormalImage:(UIImage *)rightNormalImage
                            rightHandle:(void (^)(UITextField *textField))rightHandle;

@end
