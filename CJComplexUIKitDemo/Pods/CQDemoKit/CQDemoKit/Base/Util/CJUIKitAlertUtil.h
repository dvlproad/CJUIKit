//
//  CJUIKitAlertUtil.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJUIKitAlertUtil : NSObject

#pragma mark - UIAlert
/// 显示系统AlertType弹框
+ (void)showInViewController:(UIViewController *)viewController
                   withTitle:(NSString *)title
                     message:(NSString *)message
                 cancleBlock:(void(^)(void))cancleBlock
                     okBlock:(void(^)(void))okBlock;

@end
