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
 *  将图片和文字竖直排放
 *  @attention  前提要保证Button的宽度一定要大于等于图片的宽
 *
 *  @param spacing 图片和文字的间隔为多少
 */
- (void)cjVerticalImageAndTitle:(CGFloat)spacing;

@end
