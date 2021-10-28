//
//  CJUIKitToastUtil.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJUIKitToastUtil : NSObject {
    
}

/// 在window的中心显示message信息
+ (void)showMessage:(NSString *)message;

/*
 *  在指定View上显示Toast信息(系统的 UIAlertController 没法同时弹出多个，但这里每个toast都是单独的视图)
 *
 *  @param text         要显示的信息
 *  @param superView    要显示在什么视图上
 *  @param centerOffset 弹框中心与视图中心的偏移(用于显示多个toast时候，能够都在界面上显示出来)
 */
+ (void)showToast:(NSString *)text inView:(nullable UIView *)superView centerOffset:(CGPoint)centerOffset;


@end

NS_ASSUME_NONNULL_END
