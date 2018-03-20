//
//  UIButton+CJUpDownStructure.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/7/3.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CJUpDownStructure)

/**
 *  将图片和文字竖直排放（调用前提：必须保证你的button的size已经确定后才能调用）
 *  @attention  也要保证Button的宽度一定要大于等于图片的宽
 *
 *  @param spacing 图片和文字的间隔为多少
 */
- (void)cjVerticalImageAndTitle:(CGFloat)spacing;


/**
 *  左图片、右文字时候
 *
 *  @param spacing          图片与文字的间隔
 *  @param leftOffset       视图与左边缘的距离
 */
- (void)cjLeftImageOffset:(CGFloat)leftOffset imageAndTitleSpacing:(CGFloat)spacing;

@end
