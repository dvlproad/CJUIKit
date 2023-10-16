//
//  CQLeftIconRightCustomConstraintHelper.m
//  CJDemoCommon
//
//  Created by ciyouzen on 2019/8/27.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CQLeftIconRightCustomConstraintHelper.h"
#import <Masonry/Masonry.h>

static CGFloat const kNavTitleViewLeftMargin = 20 + 22 + 10;    // 导航栏标题默认离左边的边距

@implementation CQLeftIconRightCustomConstraintHelper

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
       contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment
{
    [containerView addSubview:rightCustomView];
    [containerView addSubview:leftImageView];
    
    if (contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft) {
        // 在本视图中从左排列：图片在左，文字在图片的右边（如cell中的"+自定义"）
        [rightCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(containerView).offset(0);
            make.centerY.mas_equalTo(containerView);
            make.left.mas_equalTo(leftImageView.mas_right).offset(iconTitleSpacing);
        }];
        [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(containerView);
            make.size.mas_equalTo(leftViewSize);
            make.left.mas_equalTo(containerView);
        }];
    } else { // 居中
        // 在本视图中居中排列：图片在左，文字在图片的右边
        [rightCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(containerView).offset(0);
            make.centerY.mas_equalTo(containerView);
            make.centerX.mas_equalTo(containerView).offset((leftViewSize.width+iconTitleSpacing)/2);
        }];
        [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(containerView);
            make.size.mas_equalTo(leftViewSize);
            make.right.mas_equalTo(rightCustomView.mas_left).mas_offset(-iconTitleSpacing);
        }];
    }
}


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
//                 showLeftView:(BOOL)showLeftView
              rightCustomView:(UIView *)rightCustomView
//                showRightView:(BOOL)showRightView
                 leftViewSize:(CGSize)leftViewSize
             iconTitleSpacing:(CGFloat)iconTitleSpacing
   contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment
{
//    BOOL existView = showLeftView == YES || showRightView == YES;
//    NSAssert(existView == YES, @"不能一个视图都没有");
    
    if (contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft) {
        // 在本视图中从左排列：图片在左，文字在图片的右边（如cell中的"+自定义"）
        [leftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(containerView);
            make.size.mas_equalTo(leftViewSize);
            make.left.mas_equalTo(containerView);
        }];
        [rightCustomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(containerView).offset(0);
            make.centerY.mas_equalTo(containerView);
            make.left.mas_equalTo(leftImageView.mas_right).offset(iconTitleSpacing);
        }];
    } else { // 居中
        // 在本视图中居中排列：图片在左，文字在图片的右边
//        [rightCustomView setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal]; // TODO:抗压缩不对没起作用，另待整理掉BLCardNameRecognizeView
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat labelLabelViewMaxWidth = screenWidth - 2*kNavTitleViewLeftMargin; // 左右两边扣去返回按钮
        CGFloat rightCustomViewMaxWidth = labelLabelViewMaxWidth - (leftViewSize.width+iconTitleSpacing);
        [rightCustomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(containerView).offset(0);
            make.centerY.mas_equalTo(containerView);
            make.centerX.mas_equalTo(containerView).offset((leftViewSize.width+iconTitleSpacing)/2);
            make.width.mas_lessThanOrEqualTo(rightCustomViewMaxWidth); // 修复右视图文本太长时候，超出区域
//            make.left.mas_equalTo(containerView).offset(leftViewSize.width+iconTitleSpacing).priorityLow; // 修复右视图文本太长时候，超出区域
        }];
        [leftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(containerView);
            make.size.mas_equalTo(leftViewSize);
            make.right.mas_equalTo(rightCustomView.mas_left).mas_offset(-iconTitleSpacing);
        }];
    }
}


/// 只显示左视图时候的布局
+ (void)reConstraintContainer_onlyShowLeft:(UIView *)containerView
                         withLeftImageView:(UIView *)leftImageView
                           rightCustomView:(UIView *)rightCustomView
                              leftViewSize:(CGSize)leftViewSize
                contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment
{
    if (contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft) {
        // 在本视图中从左排列：图片在左，文字在图片的右边（如cell中的"+自定义"）
        [leftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(containerView);
            make.size.mas_equalTo(leftViewSize);
            make.left.mas_equalTo(containerView);
        }];
        [rightCustomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(containerView).offset(0);
            make.centerY.mas_equalTo(containerView);
            make.width.mas_equalTo(0);
        }];
    } else { // 居中
        // 在本视图中居中排列：图片在左，文字在图片的右边
        [rightCustomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(containerView).offset(0);
            make.centerY.mas_equalTo(containerView);
            make.width.mas_equalTo(0);
        }];
        [leftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(containerView);
            make.size.mas_equalTo(leftViewSize);
            make.centerX.mas_equalTo(containerView);
        }];
    }
}


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
                          iconTitleSpacing:(CGFloat)iconTitleSpacing
{
    [containerView addSubview:bottomCustomView];
    [containerView addSubview:topImageView];
 
    // 在本视图中居中排列：图片在左，文字在图片的右边
    [bottomCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(containerView).offset(0);
        make.centerX.mas_equalTo(containerView);
        make.centerY.mas_equalTo(containerView).offset((iconHeight+iconTitleSpacing)/2);
    }];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(containerView);
        make.width.height.mas_equalTo(iconHeight);
        make.bottom.mas_equalTo(bottomCustomView.mas_top).mas_offset(-iconTitleSpacing);
    }];
}


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
                      iconTitleSpacing:(CGFloat)iconTitleSpacing
{
    // 在本视图中居中排列：图片在左，文字在图片的右边
    [bottomCustomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(containerView).offset(0);
        make.centerX.mas_equalTo(containerView);
        make.centerY.mas_equalTo(containerView).offset((iconHeight+iconTitleSpacing)/2);
    }];
    [topImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(containerView);
        make.width.height.mas_equalTo(iconHeight);
        make.bottom.mas_equalTo(bottomCustomView.mas_top).mas_offset(-iconTitleSpacing);
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
