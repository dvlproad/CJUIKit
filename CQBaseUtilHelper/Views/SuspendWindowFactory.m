//
//  SuspendWindowFactory.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <CQBaseUtilHelper/SuspendWindowFactory.h>
#import <CQBaseUtilHelper/DemoSuspendWindowRootViewController.h>
#import <CQDemoKit/CQTSSuspendWindow.h>
#import <CJBaseUtil/CJSuspendWindowManager.h>


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
