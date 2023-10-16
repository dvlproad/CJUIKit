//
//  CQEffectViewFactory.h
//  AppCommonUICollect
//
//  Created by ciyouzen on 2019/8/13.
//  Copyright © 2019 dvlproad. All rights reserved.
//
//  为某个视图添加效果视图的类方法：创建指定的效果视图，添加到某个视图中或该视图的子视图中

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQEffectViewFactory : NSObject {
    
}

/*
 *  对[backForSuperview中紧靠closeToSubview]的区域，添加[指定effectStyle]的毛玻璃效果，作为背景
 *
 *  @param effectStyle      毛玻璃样式
 *  @param backForSuperview 要添加的效果是作为哪个视图的背景层/第一层
 *  @param closeToSubview   要添加的效果是依靠布局在哪个视图区域上
 */
+ (UIVisualEffectView *)addEffectWithStyle:(UIBlurEffectStyle)effectStyle
                               backForView:(UIView *)backForSuperview
                               closeToView:(UIView *)closeToSubview;

@end

NS_ASSUME_NONNULL_END
