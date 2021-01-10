//
//  UIButton+CJStructure.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/7/3.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CJStructure)

/**
 *  上图片、下文字(竖直排放)（调用前提：必须保证你的button的size已经确定后才能调用）
 *  @attention  也要保证Button的宽度一定要大于等于图片的宽
 *
 *  @param spacing 图片和文字的间隔为多少
 */
- (void)cjVerticalImageAndTitle:(CGFloat)spacing;

/*
 *  上图片、下文字(竖直排放)（调用前提：必须保证你的button的size已经确定后才能调用）
 *  @attention  也要保证Button的宽度一定要大于等于图片的宽
 *
 *  @param imageSize    图片大小
 *  @param spacing      图片和文字的间隔为多少
 *  @param titleSize    文字大小
 */
- (void)cjVerticalImageSize:(CGSize)imageSize spacing:(CGFloat)spacing titleSize:(CGSize)titleSize;


/**
 *  左图片、右文字(水平排放)
 *
 *  @param spacing          图片与文字的间隔
 *  @param leftOffset       视图与左边缘的距离
 */
- (void)cjLeftImageOffset:(CGFloat)leftOffset imageAndTitleSpacing:(CGFloat)spacing;

/**
 *  左文字、右图片(水平排放)
 *
 *  @param spacing          图片与文字的间隔
 *  @param rightOffset      视图与右边缘的距离
 */
- (void)cjLeftTextRightImageWithSpacing:(CGFloat)spacing
                            rightOffset:(CGFloat)rightOffset;

@end
