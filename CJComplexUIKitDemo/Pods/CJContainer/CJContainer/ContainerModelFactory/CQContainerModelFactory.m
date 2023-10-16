//
//  CQContainerModelFactory.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/1/31.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CQContainerModelFactory.h"

@implementation CQHorizontalContainerModel

@end

@implementation CQVerticalContainerModel

@end





@interface CQContainerModelFactory () {
    
}

@end

@implementation CQContainerModelFactory

#pragma mark - 视图容器
/*
 *  包含水平均分subviews中的视图的视图容器
 *  @brief  (subview的宽高比为：subviewWidth这个宽度和整个容器的视图高度的比)
 *
 *  @param subviews         要包含的视图
 *  @param subviewWidth     每个视图的宽度
 *  @param subviewSpacing   视图的间距
 *
 *  @return 水平视图
 */
+ (CQHorizontalContainerModel *)horizontalContainer:(NSArray<UIView *> *)subviews
                                       subviewWidth:(CGFloat)subviewWidth
                                     subviewSpacing:(CGFloat)subviewSpacing
{
    NSAssert(subviews.count >= 0, @"视图个数不能为空");
    if (subviews.count == 1) {
        UIView *view = subviews[0];
        return view;
    }
    
    UIView *containerView = [[UIView alloc] init]; // 用来包subviews的视图
    for (UIView *view in subviews) {
        [containerView addSubview:view];
    }
    
    [subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:subviewWidth leadSpacing:0 tailSpacing:0];
    [subviews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(containerView);
    }];
    
    CGFloat subviewCount = subviews.count;
    CGFloat containerWidth = subviewCount*subviewWidth + (subviewCount-1)*subviewSpacing;
    
    CQHorizontalContainerModel *model = [[CQHorizontalContainerModel alloc] init];
    model.containerView = containerView;
    model.containerWidth = containerWidth;
    
    return model;
}


/*
 *  包含竖直均分subviews中的视图的视图容器
 *  @brief  (subview的宽高比为：整个容器的视图宽度和subviewHeight这个高度的比)
 *
 *  @param subviews         要包含的视图
 *  @param subviewHeight    每个视图的高度
 *  @param subviewSpacing   视图的间距
 *
 *  @return 竖直视图
 */
+ (CQVerticalContainerModel *)verticalContainer:(NSArray<UIView *> *)subviews
                                  subviewHeight:(CGFloat)subviewHeight
                                 subviewSpacing:(CGFloat)subviewSpacing
{
    NSAssert(subviews.count >= 0, @"视图个数不能为空");
    if (subviews.count == 1) {
        UIView *view = subviews[0];
        return view;
    }
    
    UIView *containerView = [[UIView alloc] init];
    for (UIView *view in subviews) {
        [containerView addSubview:view];
    }
    
    [subviews mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:subviewHeight leadSpacing:0 tailSpacing:0];
    [subviews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(containerView);
    }];
    
    CGFloat subviewCount = subviews.count;
    CGFloat containerHeight = subviewCount*subviewHeight + (subviewCount-1)*subviewSpacing;

    CQVerticalContainerModel *model = [[CQVerticalContainerModel alloc] init];
    model.containerView = containerView;
    model.containerHeight = containerHeight;
    
    return model;
}

@end
