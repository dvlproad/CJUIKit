//
//  CJUIKitAlertUtil.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJUIKitAlertUtil : NSObject

#pragma mark - Alert
/// 显示系统AlertType弹框（我知道了）
+ (void)showIKnowAlertInViewController:(UIViewController *)viewController
                             withTitle:(NSString *)title
                            iKnowBlock:(void(^)(void))iKnowBlock;

/// 显示系统AlertType弹框（取消+确认）
+ (void)showCancleOKAlertInViewController:(UIViewController *)viewController
                                withTitle:(NSString *)title
                                  message:(NSString *)message
                              cancleBlock:(void(^)(void))cancleBlock
                                  okBlock:(void(^)(void))okBlock;

#pragma mark - ActionSheet
/// 显示系统ActionSheet弹框
+ (void)showActionSheetInViewController:(UIViewController *)viewController
                              withTitle:(NSString *)title
                                message:(NSString *)message
                             itemTitles:(NSArray<NSString *> *)itemTitles
                            cancleBlock:(void(^)(void))cancleBlock
                         itemClickBlock:(void(^)(NSInteger index))itemClickBlock;

@end
