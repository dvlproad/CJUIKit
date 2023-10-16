//
//  CQFixedSpacingContainerView.h
//  CJDemoCommon
//
//  Created by ciyouzen on 2019/8/27.
//  Copyright © 2019 dvlproad. All rights reserved.
//
//  间距固定的等分视图：常用于①底部的分享(+举报)按钮组合

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQFixedSpacingContainerView : UIView {
    
}

#pragma mark - Item间距固定(Item大小不定)的等分视图接口
/*
*  初始化（无分割线）
*
*  @param axisType              子视图的排列方式（横向、纵向）
*  @param subviews              子视图数组(允许至少一个数字)
*  @param fixedSpacing          两个控件间隔
*  @param leadSpacing           第一个控件与边缘的间隔
*  @param tailSpacing           最后一个控件与边缘的间隔
*
*  @return  Item间距固定(Item大小不定)的等分视图接口（无分割线）
*/
- (instancetype)initWithAlongAxis:(MASAxisType)axisType
                         subviews:(NSArray<UIView *> *)subviews
                     fixedSpacing:(CGFloat)fixedSpacing
                      leadSpacing:(CGFloat)leadSpacing
                      tailSpacing:(CGFloat)tailSpacing;


/*
*  初始化（可自定义分割线）
*
*  @param axisType              子视图的排列方式（横向、纵向）
*  @param subviews              子视图数组(允许至少一个数字)
*  @param fixedSpacing          两个控件间隔
*  @param leadSpacing           第一个控件与边缘的间隔
*  @param tailSpacing           最后一个控件与边缘的间隔
*  @param lineThickness         分割线的粗细(视图>=2个时候才有效,默认0,即无分割线)
*  @param lineMargin            线与视图边缘的距离(有分割线的时候)
*  @param lineColor             线的颜色(有分割线的时候)
*
*  @return  Item间距固定(Item大小不定)的等分视图接口（可自定义分割线）
*/
- (instancetype)initWithAlongAxis:(MASAxisType)axisType
                         subviews:(NSArray<UIView *> *)subviews
                     fixedSpacing:(CGFloat)fixedSpacing
                      leadSpacing:(CGFloat)leadSpacing
                      tailSpacing:(CGFloat)tailSpacing
                    lineThickness:(CGFloat)lineThickness
                       lineMargin:(BOOL)lineMargin
                        lineColor:(nullable UIColor *)lineColor NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

#pragma mark - Event
/// 更新线条颜色（有时候cell样式一样，颜色不同的时候，又不想创建多种cell，需要更新后续根据数据来更新颜色）
- (void)updateLineColor:(UIColor *)lineColor;


@end

NS_ASSUME_NONNULL_END
