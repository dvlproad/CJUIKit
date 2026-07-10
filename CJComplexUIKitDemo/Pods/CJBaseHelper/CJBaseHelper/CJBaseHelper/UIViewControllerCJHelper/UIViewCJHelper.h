//
//  UIViewCJHelper.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//
//  源码地址:https://github.com/dvlproad/CJUIKit.git
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewCJHelper : NSObject

#pragma mark - 获取指定视图的显示比例
/*
 *  获取指定视图的显示比例
 *
 *  @param view   要判断的视图
 *
 *  @return 视图的显示比例(范围为0.0到1.0)
 */
+ (CGFloat)getVisibleRatioForView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
