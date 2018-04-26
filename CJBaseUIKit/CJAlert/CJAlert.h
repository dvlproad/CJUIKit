//
//  CJAlert.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CJPopupAction/UIView+CJPopupInView.h>

#import "CJAlertActionModel.h"

@interface CJAlert : NSObject

#pragma mark - UIAlertController
+ (void)showAlertTypeAlertControllerWithTitle:(NSString *)title
                                      message:(NSString *)message
                            alertActionModels:(NSArray<CJAlertActionModel *> *)alertActionModels
                             inViewController:(UIViewController *)viewController;

+ (void)showSheetTypeAlertControllerWithTitle:(NSString *)title
                                      message:(NSString *)message
                            alertActionModels:(NSArray<CJAlertActionModel *> *)alertActionModels
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
