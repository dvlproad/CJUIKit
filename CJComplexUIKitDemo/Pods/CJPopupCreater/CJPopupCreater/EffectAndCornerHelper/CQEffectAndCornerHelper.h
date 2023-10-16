//
//  CQEffectAndCornerHelper.h
//  AppCommonUICollect
//
//  Created by ciyouzen on 2019/8/13.
//  Copyright © 2019 dvlproad. All rights reserved.
//
//  为某个视图添加模糊效果和圆角化效果，常用于底部弹窗

#import <UIKit/UIKit.h>
#import "CQEffectEnum.h"

NS_ASSUME_NONNULL_BEGIN

@interface CQEffectAndCornerHelper : NSObject {
    
}
#pragma mark - 基础方法
#pragma mark 基础方法：模糊化
/*
 *  对弹出视图进行【模糊指定区域】
 *  ps:如果模糊化操作有新视图生成，则再当要圆角化的子视图还等于模糊化的子视图时候，也要为此新模糊视图添加corner
 *
 *  @param effectStyle                      创建生成【指定类型】的模糊视图
 *  @param newEffectViewAddToView           将生成的模糊视图添加到【指定的视图】上，作为该视图的背景层/第一层
 *  @param newEffectViewCloseToViewSubView  将添加的模糊视图依靠在【视图】的【指定区域】上(可能为整个区域或某个子视图区域)
 *
 *  @return 返回执行此操作后，额外添加上去的视图(可能为nil)
 */
+ (nullable UIVisualEffectView *)createEffectViewWithEffectStyle:(CQEffectStyle)effectStyle
                                          newEffectViewAddToView:(UIView *)newEffectViewAddToView
                                 newEffectViewCloseToViewSubView:(UIView *)newEffectViewCloseToViewSubView;

#pragma mark 基础方法：圆角化
/*
 *  为【指定的视图(支持UIScrollView)】设置mask实现圆角的
 *  ps:请在layoutSubviews中使用
 *
 *  @param cornerToSubView  要设置mask实现圆角的视图
 *  @param cornerRadius     圆角的角度
 */
+ (void)cornerByMaskToView:(UIView *)cornerToSubView
          withCornerRadius:(CGFloat)cornerRadius;


@end

NS_ASSUME_NONNULL_END
