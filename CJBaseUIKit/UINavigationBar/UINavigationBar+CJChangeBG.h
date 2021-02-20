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


#pragma mark - 导航栏的背景色
///设置导航栏的背景色为指定背景色backgroundColor
- (void)cj_setBackgroundColor:(UIColor *)backgroundColor;

///还原导航栏的背景色为之前的设置
- (void)cj_resetBackgroundColor;



#pragma mark - 导航栏最下面的横线
/*
 *  是否隐藏导航栏最下面的横线
 *
 *  @param hide 是否隐藏
 */
- (void)cj_hideUnderline:(BOOL)hide;




#pragma mark - 导航栏的位置
/*
 *  设置导航栏的位置
 *
 *  @param translationY    translationY
 */
- (void)cj_setTranslationY:(CGFloat)translationY;




/*
 *  改变导航栏上左、右及titleView的alpha值
 *
 *  @param alpha    alpha
 */
- (void)cj_setElementsAlpha:(CGFloat)alpha;





@end
