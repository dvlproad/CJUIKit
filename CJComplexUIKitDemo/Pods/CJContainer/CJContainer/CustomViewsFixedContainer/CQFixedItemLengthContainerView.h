//
//  CQFixedItemLengthContainerView.h
//  CJDemoCommon
//
//  Created by ciyouzen on 2019/8/27.
//  Copyright © 2019 dvlproad. All rights reserved.
//
//  固定宽高的等分视图（允许子视图只为一个）：常用于

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQFixedItemLengthContainerView : UIView {
    
}
@property (nonatomic, assign, readonly) CGFloat viewMinLength;  /**< 视图的最小长度要求（水平布局的时候是宽度要求，竖直布局的时候是高度要求） */

#pragma mark - Item大小固定(Item间距不定)的等分视图接口
/*
*  初始化(容器视图最小高度：以itemSapcing间距0计算)
*
*  @param axisType              子视图的排列方式（横向、纵向）
*  @param subviews              子视图数组(允许至少一个数字)
*  @param fixedItemLength       控件的宽或高
*  @param leadSpacing           第一个控件与边缘的间隔
*  @param tailSpacing           最后一个控件与边缘的间隔
*
*  @return  Item大小固定(Item间距不定)的等分视图（无分割线）
*/
- (instancetype)initWithAlongAxis:(MASAxisType)axisType
                         subviews:(NSArray<UIView *> *)subviews
                  fixedItemLength:(CGFloat)fixedItemLength
                      leadSpacing:(CGFloat)leadSpacing
                      tailSpacing:(CGFloat)tailSpacing;

/*
*  初始化(容器视图最小高度：superViewHeight)
*  @brief   即使你是添加到self.view上，也最好需要个container，因为设置子视图与边缘的间隔时候，容易和self.mas_topLayoutGuide、self.mas_bottomLayoutGuideTop冲突，而导致无法同时满足
*
*  @param axisType              子视图的排列方式（横向、纵向）
*  @param subviews              子视图数组(允许至少一个数字)
*  @param fixedItemLength       控件的宽或高
*  @param superViewHeight       父视图的高度
*
*  @return  Item大小固定(（leadSpacing、tailSpacing、itemSpacing相等）)的等分视图（无分割线）
*/
- (instancetype)initWithAlongAxis:(MASAxisType)axisType
                         subviews:(NSArray<UIView *> *)subviews
                  fixedItemLength:(CGFloat)fixedItemLength
                inSuperViewHeight:(CGFloat)superViewHeight;

/*
*  初始化(容器视图最小高度：以itemSapcing间距0计算)
*
*  @param axisType              子视图的排列方式（横向、纵向）
*  @param subviews              子视图数组(允许至少一个数字)
*  @param fixedItemLength       控件的宽或高
*  @param leadSpacing           第一个控件与边缘的间隔
*  @param tailSpacing           最后一个控件与边缘的间隔
*  @param lineThickness         分割线的粗细(视图>=2个时候才有效,默认0,即无分割线)
*  @param lineMargin            lineMargin
*  @param lineColor             lineColor
*
*  @return  Item大小固定(Item间距不定)的等分视图（可自定义分割线）
*/
- (instancetype)initWithAlongAxis:(MASAxisType)axisType
                         subviews:(NSArray<UIView *> *)subviews
                  fixedItemLength:(CGFloat)fixedItemLength
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
