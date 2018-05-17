//
//  UINavigationBar+CJChangeBG.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
//应用场景，项目中有某一两个界面的导航栏在一开始时候是透明的，然后随着scrollView的移动才逐渐显示成它自己的颜色，这里为了能够在退出那些界面的时候，还原导航栏的颜色，我们直接在navigationBar上加一层视图overlay

@interface UINavigationBar (CJChangeBG)

/**
 *  删除导航栏的下划线
 */
- (void)cj_removeUnderline;

/**
 *  设置导航栏的背景色
 *
 *  @param backgroundColor  backgroundColor
 */
- (void)cj_setBackgroundColor:(UIColor *)backgroundColor;

/**
 *  改变导航栏上左、右及titleView的alpha值
 *
 *  @param alpha    alpha
 */
- (void)cj_setElementsAlpha:(CGFloat)alpha;

/**
 *  设置导航栏的位置
 *
 *  @param translationY    translationY
 */
- (void)cj_setTranslationY:(CGFloat)translationY;

/**
 *  还原导航栏之前的设置
 */
- (void)cj_reset;

@end
