//
//  CQContainerModelFactory.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/1/31.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQHorizontalContainerModel : NSObject

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, assign) CGFloat containerWidth;

@end


@interface CQVerticalContainerModel : NSObject

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, assign) CGFloat containerHeight;

@end






@interface CQContainerModelFactory : NSObject

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
                                     subviewSpacing:(CGFloat)subviewSpacing;

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
                                 subviewSpacing:(CGFloat)subviewSpacing;


@end


NS_ASSUME_NONNULL_END
