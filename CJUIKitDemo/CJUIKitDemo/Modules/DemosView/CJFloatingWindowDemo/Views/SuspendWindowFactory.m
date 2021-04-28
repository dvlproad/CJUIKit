//
//  SuspendWindowFactory.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "SuspendWindowFactory.h"
#import <CQDemoKit/CJUIKitToastUtil.h>
#import "DemoSuspendWindowRootViewController.h"
#import "CQTSSuspendWindow.h"

#ifdef TEST_CJBASEUTIL_POD
#import "CJSuspendWindowManager.h"
#else
#import <CJBaseUtil/CJSuspendWindowManager.h>
#endif


@implementation SuspendWindowFactory

+ (UIWindow *)windowWithIdentifier:(NSString *)windowIdentifier {
    NSString *lastWindowIdentifier = [NSString stringWithFormat:@"%@_%@", NSStringFromClass([self class]), windowIdentifier];
    CQTSSuspendWindow *suspendWindow = (CQTSSuspendWindow *)[CJSuspendWindowManager windowForKey:lastWindowIdentifier];
    if (suspendWindow == nil) {
        DemoSuspendWindowRootViewController *vc = [[DemoSuspendWindowRootViewController alloc] initWithNibName:nil bundle:nil];
        vc.clickWindowBlock = ^(UIButton * _Nonnull clickButton) {
            NSLog(@"click %@", clickButton.titleLabel.text);
        };
        vc.closeWindowBlock = ^{
            //[weakSuspendWindow removeFromScreen];
            [CJSuspendWindowManager destroyWindowForKey:lastWindowIdentifier];
        };
        
        suspendWindow = [[CQTSSuspendWindow alloc] initWithFrame:CGRectZero];
        suspendWindow.windowIdentifier = lastWindowIdentifier;
        suspendWindow.rootViewController = vc;
        
        [CJSuspendWindowManager saveWindow:suspendWindow forKey:suspendWindow.windowIdentifier];
    }
    return suspendWindow;
}

@end
