//
//  CJBasePopupBlankView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//
//  整弹出框的容器视图blankContainer（每一个弹窗的背景点击回调都不一样）
//  注意：当正在关闭弹窗的时候，应该禁用整个视图的所有点击（防止尤其是当关闭耗时时候，多次进行的空白区域的快速点击导致重复调用）

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 注意：当正在关闭弹窗的时候，应该禁用整个视图的所有点击（防止尤其是当关闭耗时时候，多次进行的空白区域的快速点击导致重复调用）
@interface CJBasePopupBlankView : UIView {
    
}

#pragma mark - Init
/*
 *  初始化
 *
 *  @param tapBlock             点击视图的回调（每一个弹窗的背景点击回调都不一样）
 *
 *  @return 完整弹出框的容器视图blankContainer
 */
- (instancetype)initWithTapBlankHandle:(void(^ _Nullable)(CJBasePopupBlankView *bSelf))tapBlankHandle NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

+ (void)cjPopup_makeView:(UIView *)superView addSubView:(UIView *)subView withEdgeInsets:(UIEdgeInsets)edgeInsets;

@end

NS_ASSUME_NONNULL_END
