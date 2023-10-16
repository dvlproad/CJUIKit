//
//  CQBottomCustomWithPanlineView.h
//  AppCommonUICollect
//
//  Created by ciyouzen on 2019/8/13.
//  Copyright © 2019 dvlproad. All rights reserved.
//
//  包含顶部下拉线的弹出视图

#import <UIKit/UIKit.h>
#import <CJPopupCreater/CQEffectAndCornerHelper.h>
#import "CQPanLineView.h"

NS_ASSUME_NONNULL_BEGIN

/// 视图部分的类型
typedef NS_ENUM(NSUInteger, CQPanlinePopupViewPart) {
    CQPanlinePopupViewPartNone = 0,         /**< 无 */
    CQPanlinePopupViewPartAll,              /**< 自身整个视图 */
    CQPanlinePopupViewPartWithoutPanLine,   /**< 除下拉线视图外的视图 */
};

@interface CQBottomCustomWithPanlineView : UIView {
    
}
@property (nullable, nonatomic, strong, readonly) CQPanLineView *panLineView;
@property (nonatomic, strong, readonly) UIView *customView; /**< 除去下拉视图外的那部分视图 */

#pragma mark - Init
/*
 *  初始化弹窗视图
 *
 *  @param showPanLine      是否显示下拉线
 *  @param customView       下拉线视图除外的其他视图
 *
 *  @return 弹窗视图
 */
- (instancetype)initWithShowPanLine:(BOOL)showPanLine customView:(UIView *)customView;


#pragma mark - 设置圆角化#pragma mark - 设置模糊化和圆角化
/*
 *  对本视图的进行【模糊指定区域】
 *
 *  @param effectViewPart       要添加模糊化的是视图的哪个部分
 *  @param effectStyle          要添加的模糊效果是【什么类型】
 */
- (void)effectWithViewPart:(CQPanlinePopupViewPart)effectViewPart
               effectStyle:(CQEffectStyle)effectStyle;
/*
 *  设置对本视图的进行圆角化的参数
 *
 *  @param cornerViewPart   要添加圆角的是视图的哪个部分
 *  @param cornerRadius     圆角圆角
 */
- (void)cornerWithViewPart:(CQPanlinePopupViewPart)cornerViewPart cornerRadius:(CGFloat)cornerRadius;


#pragma mark - Get Method
/// 获取本视图的高度
- (CGFloat)viewHeightWithCustomViewHeight:(CGFloat)customViewHeight;

/// 获取customVie视图的高度
- (CGFloat)customViewHeightWithViewHeight:(CGFloat)viewHeight;

@end

NS_ASSUME_NONNULL_END
