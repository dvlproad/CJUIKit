//
//  UIWindow+CJCategroy.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/29.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (CJCategroy)

/**
 *  对window(包括view)进行截图
 *
 *  @rerun 截图后所得的图片
 */
- (UIImage *)cj_snapshot;

@end
