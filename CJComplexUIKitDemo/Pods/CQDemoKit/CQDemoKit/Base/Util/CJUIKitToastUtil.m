//
//  CJUIKitToastUtil.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJUIKitToastUtil.h"

@implementation CJUIKitToastUtil

+ (void)showMessage:(NSString *)message {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [self showToast:message inView:keyWindow];
}

+ (void)showToast:(NSString *)text inView:(UIView *)superView {
    if (superView == nil) {
        superView = [UIApplication sharedApplication].keyWindow;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.text = text;
    [label sizeToFit];
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
    if (@available(iOS 13.0, *)) {
        label.textColor = [UIColor labelColor];
    } else {
#endif
        label.textColor = [UIColor blackColor];
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
    }
#endif
    label.frame = CGRectMake(CGRectGetWidth(superView.frame)/2-CGRectGetWidth(label.frame)/2,
                             CGRectGetHeight(superView.frame)/2-CGRectGetHeight(label.frame)/2,
                             CGRectGetWidth(label.frame),
                             CGRectGetHeight(label.frame));
    [superView addSubview:label];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [label removeFromSuperview];
    });
}

@end
