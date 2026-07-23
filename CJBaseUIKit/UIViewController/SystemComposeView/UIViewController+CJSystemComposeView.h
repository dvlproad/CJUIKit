//
//  UIViewController+CJSystemComposeView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/10/10.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  添加childViewController数组以及从哪个切换到哪个的方法

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (CJSystemComposeView)

@property (nonatomic, assign, readonly) NSInteger cjCurrentSelectedIndex;
@property (nonatomic, strong, readonly) UIView *cjComposeView;
@property (nonatomic, strong, readonly) NSMutableArray<UIViewController *> *cjComponentViewControllers; //该set方法有操作

#pragma mark - Init
/*
 *  为 composeView 添加 componentViewControllers 下的视图作为其子视图
 *
 *  @param composeView              componentViewControllers的子视图添加到哪
 *  @param componentViewControllers composeView子视图的来源
 */
- (void)cj_setupComposeView:(UIView *)composeView
fromComponentViewControllers:(NSArray<UIViewController *> *)componentViewControllers;

#pragma mark - Action
- (void)cj_replaceChildViewControllerIndex:(NSInteger)index_old
               newChildViewControllerIndex:(NSInteger)index_new
                             completeBlock:(void(^)(NSInteger index_cur))completeBlock;

@end

NS_ASSUME_NONNULL_END
