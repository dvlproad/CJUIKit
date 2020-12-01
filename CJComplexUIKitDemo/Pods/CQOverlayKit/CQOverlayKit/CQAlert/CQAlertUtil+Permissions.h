//
//  CQAlertUtil.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQAlertUtil (Permissions)

#pragma mark - 不支持/无权限弹窗
/**
 *  权限信息的显示或权限弹窗
 *
 *  @param title    title
 *  @param message  message
 */
+ (void)showPermissionAlertWithTitle:(NSString *)title
                             message:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
