//
//  LEOHeaderView.h
//  iOS-NavigationBar-Category
//
//  Created by 雷亮 on 16/7/29.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef kNavigationBarHeight
#define kNavigationBarHeight 64
#endif

typedef void(^ReachtopBlock) (BOOL reachtop);
typedef void(^PressHeaderBlock) ();

@interface LEOHeaderView : UIView

/** 设置背景图像
 * @param image: 背景图
 */
- (void)setBackgroundImage:(UIImage *)image;


/** 设置头像及描述文字
 * @param image: 头像
 * @param text: 描述文字
 */
- (void)setHeaderImage:(UIImage *)image text:(NSString *)text;


/** 根据滚动视图更新视图效果
 * @param scrollView: 滚动视图
 */
- (void)reloadWithScrollView:(UIScrollView *)scrollView;

/**
 * 头像的点击回调方法
 */
- (void)pressHeaderImageWithBlock:(PressHeaderBlock)block;


/** 监听scrollView是否滚动到顶部
 * @param reachtop: YES 已经滚动到顶部, NO 在顶部以下
 */
- (void)scrollViewStateChangeWithBlock:(ReachtopBlock)block;


@end
