//
//  UIView+CJAddDistributeViews.m
//  CJDemoCommon
//
//  Created by ciyouzen on 2019/8/27.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "UIView+CJAddDistributeViews.h"

@implementation UIView (CJAddDistributeViews)

/*
*  添加子视图（子视图距离边缘和彼此之间的距离是一样的）
*  @brief 利用superViewHeight和子视图subviews个数及其fixedItemLength来计算间距
*
*  @param subviews              子视图数组(允许至少一个数字)
*  @param fixedItemLength       子视图的宽或高
*  @param axisType              子视图的排列方式（横向、纵向）
*  @param superViewHeight       父视图的高度（里面的是视图均分）
*/
- (void)cj_addDistributeSubviews:(NSArray<UIView *> *)subviews
             withFixedItemLength:(CGFloat)fixedItemLength
                       alongAxis:(MASAxisType)axisType
               inSuperViewHeight:(CGFloat)superViewHeight
{
    UIView *superView = self;
    
    NSInteger count = subviews.count;
    if (count == 1) {
        UIView *imageTextView = subviews[0];
        
        [superView addSubview:imageTextView];
        [imageTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(superView);
            make.top.bottom.mas_equalTo(superView);
        }];
        
    } else if (count > 1) {
        CGFloat spacing = (superViewHeight - count*fixedItemLength)/(count+1);
        CGFloat leadSpacing = spacing;
        CGFloat tailSpacing = spacing;
        
        for (NSInteger i = 0; i < count; i++) {
            UIView *imageTextView = subviews[i];
            [superView addSubview:imageTextView];
        }
        
        if (axisType == MASAxisTypeHorizontal) {
            [subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:fixedItemLength leadSpacing:leadSpacing tailSpacing:tailSpacing];
            [subviews mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(superView);
            }];
        } else {
            [subviews mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:fixedItemLength leadSpacing:leadSpacing tailSpacing:tailSpacing];
            [subviews mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(superView);
            }];
        }
    }
}


@end
