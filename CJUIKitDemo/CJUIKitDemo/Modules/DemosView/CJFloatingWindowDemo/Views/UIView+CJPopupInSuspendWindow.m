//
//  UIView+CJPopupInSuspendWindow.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "UIView+CJPopupInSuspendWindow.h"
#import "CJSuspendWindowManager.h"

@implementation UIView (CJPopupInSuspendWindow)

- (void)cj_popupInSuspendWindowWithIdentifier:(NSString *)windowIdentifier
                                  windowFrame:(CGRect)suspendWindowFrame
{
    UIWindow *suspendWindow = [CJSuspendWindowManager windowForKey:windowIdentifier];
    if (suspendWindow == nil) {
        suspendWindow = [[UIWindow alloc] initWithFrame:suspendWindowFrame];
        suspendWindow.rootViewController = [UIViewController new]; // suppress warning
        suspendWindow.windowLevel = UIWindowLevelAlert; //是窗口保持在最前
        [suspendWindow setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.3]];
        suspendWindow.userInteractionEnabled = NO; //设为NO，使屏幕触摸事件会传递到下层的实际 view 上去，不会挡住测试的操作
        
        suspendWindow.hidden = NO; //显示窗口
        
        //保证suspendWindow被某个对象强制持有，否则不会显示
        //((CJLogView *)self).belongWindow = suspendWindow;
        [CJSuspendWindowManager saveWindow:suspendWindow forKey:windowIdentifier];
    }
    
    CGRect viewFrame = CGRectMake(0, 0, CGRectGetWidth(suspendWindowFrame), CGRectGetHeight(suspendWindowFrame));
    [self setFrame:viewFrame];

    [suspendWindow addSubview:self];
}

@end
