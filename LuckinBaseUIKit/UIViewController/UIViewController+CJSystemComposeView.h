//
//  UIViewController+CJSystemComposeView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/10/10.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  添加childViewController以及转换的方法

#import <UIKit/UIKit.h>

@interface UIViewController (CJSystemComposeView)

@property (nonatomic, assign, readonly) NSInteger cjCurrentSelectedIndex;
@property (nonatomic, strong) UIView *cjComposeView;
@property (nonatomic, strong) NSMutableArray<UIViewController *> *cjComponentViewControllers; //该set方法有操作

- (void)cjReplaceChildViewControllerIndex:(NSInteger)index_old
              newChildViewControllerIndex:(NSInteger)index_cur
                            completeBlock:(void(^)(NSInteger index_cur))completeBlock;

@end
