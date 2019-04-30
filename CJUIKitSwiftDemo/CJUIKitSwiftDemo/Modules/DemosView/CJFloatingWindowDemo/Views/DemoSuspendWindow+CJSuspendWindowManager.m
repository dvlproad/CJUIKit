//
//  DemoSuspendWindow+CJSuspendWindowManager.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "DemoSuspendWindow+CJSuspendWindowManager.h"

@implementation DemoSuspendWindow (CJSuspendWindowManager)

+ (DemoSuspendWindow *)windowWithIdentifier:(NSString *)windowIdentifier {
    NSString *lastWindowIdentifier = [NSString stringWithFormat:@"%@_%@", NSStringFromClass([self class]), windowIdentifier];
    DemoSuspendWindow *suspendWindow = (DemoSuspendWindow *)[CJSuspendWindowManager windowForKey:lastWindowIdentifier];
    if (suspendWindow == nil) {
        suspendWindow = [[DemoSuspendWindow alloc] initWithFrame:CGRectZero];
        suspendWindow.windowIdentifier = lastWindowIdentifier;
        
        [CJSuspendWindowManager saveWindow:suspendWindow forKey:suspendWindow.windowIdentifier];
    }
    return suspendWindow;
}

@end
