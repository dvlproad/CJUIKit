//
//  UIView+CJToastInView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CJToastInView)

/*
 *  将当前视图Toast到superView中央
 *
 *  @param superView                    显示到哪个视图中央
 *  @param size                         toast视图的大小
 *  @param centerOffset                 toast视图的中心与superView中心的偏移量
 *  @param animated                     弹出时候的动画采用的类型
 */
- (void)cj_toastCenterInView:(nullable UIView *)superView
                    withSize:(CGSize)size
                centerOffset:(CGPoint)centerOffset
                    animated:(BOOL)animated;

/*
 *  隐藏弹出的toast视图
 *
 *  @param animated             是否要动画
 *  @param delay                多少秒后执行隐藏
 */
- (void)cj_toastHiddenWithAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay;

@end

NS_ASSUME_NONNULL_END
