//
//  CQLeftIconRightCustomConstraintHelper.h
//  CJDemoCommon
//
//  Created by ciyouzen on 2019/8/27.
//  Copyright © 2019 dvlproad. All rights reserved.
//
//  添加的【左图片、右自定义视图(一般为label或linkTextView)】到【容器containerView】中，并完成指定的布局
//  支持：
//  支持①：【单行形式】的任意对齐
//  支持②：【多行形式】的左对齐（不支持居中对齐，居中对齐需要知道文本视图的宽度）

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQLeftIconRightCustomConstraintHelper : NSObject {
    
}


#pragma mark - 水平布局：【左图片+右文字】的视图
/*
 *  添加【水平布局】的【左图片、右自定义视图(一般为label或linkTextView)】到【容器containerView】中，并完成指定的布局
 *
 *  @param containerView                容器
 *  @param leftImageView                容器的左视图（一般为UIImageView、UIButton）
 *  @param rightCustomView              容器的右视图（一般为label或linkTextView）
 *  @param leftViewSize                 左视图的大小(左视图常为①宽高1:1的icon图片；或②大小固定的文本label)
 *  @param iconTitleSpacing             左视图与右视图的间距
 *  @param contentHorizontalAlignment   对齐方式（居左、居中）
 */
+ (void)addAndConstraintContainer:(UIView *)containerView
                withLeftImageView:(UIView *)leftImageView
                  rightCustomView:(UIView *)rightCustomView
                    leftViewSize:(CGSize)leftViewSize
                 iconTitleSpacing:(CGFloat)iconTitleSpacing
       contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment;

/*
 *  重新【水平】布局【左图片、右自定义视图(一般为label或linkTextView)】到【容器containerView】中，并完成指定的布局（常用于：视图已创建，但不需要图片时，将iconHeight和iconTitleSpacing设为0）
 *
 *  @param containerView                容器
 *  @param leftImageView                容器的左视图（一般为UIImageView、UIButton、UILabel放emoji）
 *  @param showLeftView                 是否显示左视图
 *  @param rightCustomView              容器的右视图（一般为label或linkTextView）
 *  @param showRightView                是否显示右视图
 *  @param leftViewSize                 左视图的大小(左视图常为①宽高1:1的icon图片；或②大小固定的文本label)
 *  @param iconTitleSpacing             icon与右视图的间距
 *  @param contentHorizontalAlignment   对齐方式（居左、居中）
 */
+ (void)reConstraintContainer:(UIView *)containerView
            withLeftImageView:(UIView *)leftImageView
              rightCustomView:(UIView *)rightCustomView
                 leftViewSize:(CGSize)leftViewSize
             iconTitleSpacing:(CGFloat)iconTitleSpacing
   contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment;

/// 只显示左视图时候的布局
+ (void)reConstraintContainer_onlyShowLeft:(UIView *)containerView
                         withLeftImageView:(UIView *)leftImageView
                           rightCustomView:(UIView *)rightCustomView
                              leftViewSize:(CGSize)leftViewSize
                contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment;


#pragma mark - 竖直布局：【上图片+下文字】的视图

/*
 *  添加【竖直布局】的【左图片、右自定义视图(一般为label或linkTextView)】到【容器containerView】中，并完成竖直居中布局
 *
 *  @param containerView                容器
 *  @param topImageView                 容器的上视图（一般为UIImageView、UIButton）
 *  @param bottomCustomView             容器的下视图（一般为label或linkTextView）
 *  @param iconHeight                   icon的宽和高(1:1)
 *  @param iconTitleSpacing             icon与右视图的间距
 */
+ (void)addAndVerticalIConstraintContainer:(UIView *)containerView
                          withTopImageView:(UIView *)topImageView
                          bottomCustomView:(UIView *)bottomCustomView
                                iconHeight:(CGFloat)iconHeight
                          iconTitleSpacing:(CGFloat)iconTitleSpacing;

/*
 *  重新【竖直】布局【左图片、右自定义视图(一般为label或linkTextView)】到【容器containerView】中，并完成竖直居中布局（常用于：视图已创建，但不需要图片）
 *
 *  @param containerView                容器
 *  @param topImageView                 容器的上视图（一般为UIImageView、UIButton）
 *  @param bottomCustomView             容器的下视图（一般为label或linkTextView）
 *  @param iconHeight                   icon的宽和高(1:1)
 *  @param iconTitleSpacing             icon与右视图的间距
 */
+ (void)reVerticalIConstraintContainer:(UIView *)containerView
                      withTopImageView:(UIView *)topImageView
                      bottomCustomView:(UIView *)bottomCustomView
                            iconHeight:(CGFloat)iconHeight
                      iconTitleSpacing:(CGFloat)iconTitleSpacing;


@end

NS_ASSUME_NONNULL_END
