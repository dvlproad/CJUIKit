//
//  DemoAlert.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifdef TEST_CJBASEUIKIT_POD
#import "CJAlertView.h"
#else
#import <CJBaseUIKit/CJAlertView.h>
#endif


@interface DemoAlert : NSObject

///显示只有一个 "我知道了" 的 alertView
+ (void)showIKnowAlertViewWithTitle:(NSString *)title;

///显示和隐藏网络权限没打开的alert
+ (void)showNetworkNoOpenAlert:(BOOL)show;

///显示和隐藏定位权限没打开的alert
+ (void)showLocationNoOpenAlert:(BOOL)show;

///显示和隐藏定位权限异常的alert
+ (void)showLocationAbnormalAlert:(BOOL)show;

/*
///显示 "取消" + "确定" 的 alertView
+ (void)showCancelAndOKAlertViewWithTitle:(NSString *)title
                             cancelHandle:(void(^)(void))cancelHandle
                                 okHandle:(void(^)(void))okHandle;
*/


///显示自定义 "OK" 的 alertView
+ (void)showAlertViewWithTitle:(NSString *)title
                 okButtonTitle:(NSString *)okButtonTitle
                      okHandle:(void(^)(void))okHandle;

///显示自定义 "Cancel" + "OK" 的 alertView
+ (void)showAlertViewWithTitle:(NSString *)title
             cancelButtonTitle:(NSString *)cancelButtonTitle
                 okButtonTitle:(NSString *)okButtonTitle
                  cancelHandle:(void(^)(void))cancelHandle
                      okHandle:(void(^)(void))okHandle;

///显示ErrorToast
+ (void)showErrorToastAlertViewTitle:(NSString *)title;

@end
