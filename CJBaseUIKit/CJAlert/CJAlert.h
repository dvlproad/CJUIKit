//
//  CJAlert.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+CJPopupInView.h"

@interface CJAlert : NSObject

#pragma mark - UIAlertController
/* 完整的描述请参见文件头部 */
+ (void)showAlertTypeAlertControllerWithTitle:(NSString *)title
                                      message:(NSString *)message
                                 alertActions:(NSArray<UIAlertAction *> *)alertActions
                             inViewController:(UIViewController *)viewController;

/* 完整的描述请参见文件头部 */
+ (void)showSheetTypeAlertControllerWithTitle:(NSString *)title
                                      message:(NSString *)message
                                 alertActions:(NSArray<UIAlertAction *> *)alertActions
                             inViewController:(UIViewController *)viewController;


#pragma mark - CJAlertView
+ (void)showCJAlertViewWithSize:(CGSize)size
                      flagImage:(UIImage *)flagImage
                          title:(NSString *)title
                        message:(NSString *)message
              cancelButtonTitle:(NSString *)cancelButtonTitle
                  okButtonTitle:(NSString *)okButtonTitle
                   cancelHandle:(void(^)(void))cancelHandle
                       okHandle:(void(^)(void))okHandle;

@end
