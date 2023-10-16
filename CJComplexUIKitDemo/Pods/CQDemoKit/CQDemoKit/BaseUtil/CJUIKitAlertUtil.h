//
//  CJUIKitAlertUtil.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJUIKitAlertUtil : NSObject

#pragma mark - Alert
/// 显示系统AlertType弹框（我知道了）
+ (void)showIKnowAlertInViewController:(UIViewController *)viewController
                             withTitle:(NSString *)title
                            iKnowBlock:(void(^ _Nullable)(void))iKnowBlock;

/// 显示系统AlertType弹框（取消+确认）
+ (void)showCancleOKAlertInViewController:(UIViewController *)viewController
                                withTitle:(nullable NSString *)title
                                  message:(nullable NSString *)message
                              cancleBlock:(void(^ _Nullable)(void))cancleBlock
                                  okBlock:(void(^ _Nullable)(void))okBlock;

#pragma mark - ActionSheet
/// 显示系统ActionSheet弹框
+ (void)showActionSheetInViewController:(UIViewController *)viewController
                              withTitle:(nullable NSString *)title
                                message:(nullable NSString *)message
                             itemTitles:(NSArray<NSString *> *)itemTitles
                            cancleBlock:(void(^ _Nullable)(void))cancleBlock
                         itemClickBlock:(void(^ _Nullable)(NSInteger index))itemClickBlock;

@end

NS_ASSUME_NONNULL_END
