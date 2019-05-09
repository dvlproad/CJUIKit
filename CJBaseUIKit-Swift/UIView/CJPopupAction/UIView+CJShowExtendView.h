//
//  UIView+CJShowExtendView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+CJPopupInView.h"




@interface UIView (CJShowExtendView)


#pragma mark - 外部接口

/**
 *  隐藏下拉视图
 *
 *  @param animated 是否动画
 */
- (void)cj_hideExtendViewAnimated:(BOOL)animated;

@end
