//
//  UIView+CJAddDistributeViews.h
//  CJDemoCommon
//
//  Created by ciyouzen on 2019/8/27.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CJAddDistributeViews)

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
               inSuperViewHeight:(CGFloat)superViewHeight;

@end

NS_ASSUME_NONNULL_END
