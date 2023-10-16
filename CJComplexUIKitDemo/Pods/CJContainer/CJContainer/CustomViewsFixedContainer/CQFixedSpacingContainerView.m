//
//  CQFixedSpacingContainerView.m
//  CJDemoCommon
//
//  Created by ciyouzen on 2019/8/27.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CQFixedSpacingContainerView.h"

@interface CQFixedSpacingContainerView () {
    
}
@property (nonatomic, strong) NSArray<UIView *> *containerSubviews;
@property (nonatomic, assign, readonly) MASAxisType axisType;
@property (nonatomic, strong, readonly) NSMutableArray<UIView *> *lineViews;

@end

@implementation CQFixedSpacingContainerView

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
                      tailSpacing:(CGFloat)tailSpacing
{
    return [self initWithAlongAxis:axisType subviews:subviews fixedSpacing:fixedSpacing leadSpacing:leadSpacing tailSpacing:tailSpacing lineThickness:0 lineMargin:0 lineColor:nil];
}


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
                        lineColor:(nullable UIColor *)lineColor
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _containerSubviews = subviews;
        _axisType = axisType;
        
        NSInteger count = subviews.count;
        if (count == 1) {
            UIView *imageTextView = subviews[0];
            
            [self addSubview:imageTextView];
            [imageTextView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self);
                make.top.bottom.mas_equalTo(self);
            }];
            
        } else if (count > 1) {
            for (NSInteger i = 0; i < count; i++) {
                UIView *imageTextView = subviews[i];
                [self addSubview:imageTextView];
            }
            
            if (axisType == MASAxisTypeHorizontal) {
                [subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:fixedSpacing leadSpacing:leadSpacing tailSpacing:tailSpacing];
                [subviews mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.mas_equalTo(self);
                }];
            } else {
                [subviews mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:fixedSpacing leadSpacing:leadSpacing tailSpacing:tailSpacing];
                [subviews mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.mas_equalTo(self);
                }];
            }
            
            
            if (lineThickness > 0) { // 添加分割线
                [self separateWithAlongAxis:axisType lineThickness:lineThickness lineMargin:lineMargin lineColor:lineColor];
            }
            
        }
    }
    return self;
}

#pragma mark - Event
/// 更新线条颜色（有时候cell样式一样，颜色不同的时候，又不想创建多种cell，需要更新后续根据数据来更新颜色）
- (void)updateLineColor:(UIColor *)lineColor {
    for (UIView *lineView in self.lineViews) {
        lineView.backgroundColor = lineColor;
    }
}



#pragma mark - Private Method
/*
 *  添加lineWidth宽，与边缘距离lineMargin的线
 *
 *  @param axisType         子视图的排列方式（横向、纵向）
 *  @param lineThickness    分割线的粗细(视图>=2个时候才有效,默认0,即无分割线)
 *  @param lineMargin       线与视图边缘的距离(有分割线的时候)
 *  @param lineColor        线的颜色(有分割线的时候)
 */
- (void)separateWithAlongAxis:(MASAxisType)axisType
                lineThickness:(CGFloat)lineThickness
                   lineMargin:(BOOL)lineMargin
                    lineColor:(nullable UIColor *)lineColor
{
    NSInteger count = self.containerSubviews.count;
    if (count < 2) {
        return;
    }
    
    NSMutableArray<UIView *> *lineViews = [[NSMutableArray alloc] init];
    NSInteger lineCount = count - 1;
    for (NSInteger i = 0; i < lineCount; i++) {
        UIView *dividingLineView = [UIView new];
        dividingLineView.backgroundColor = lineColor;
        [self addSubview:dividingLineView];
        [lineViews addObject:dividingLineView];
    }
    _lineViews = lineViews;
    
    
    if (lineCount == 1) {
        UIView *dividingLineView = lineViews[0];
        [dividingLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.width.mas_equalTo(lineThickness);
            make.top.bottom.mas_equalTo(self);
        }];
        
    } else if (lineCount > 1) {
        if (axisType == MASAxisTypeHorizontal) {
            [lineViews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:lineThickness leadSpacing:0 tailSpacing:0];
            [lineViews mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self).offset(lineMargin);
                make.centerY.mas_equalTo(self);
            }];
        } else {
            [lineViews mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:lineThickness leadSpacing:0 tailSpacing:0];
            [lineViews mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self).offset(lineMargin);
                make.centerX.mas_equalTo(self);
            }];
        }
        
    }
}



@end
