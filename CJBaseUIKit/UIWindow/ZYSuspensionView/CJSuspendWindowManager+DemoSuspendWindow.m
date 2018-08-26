//
//  CJSuspendWindowManager+DemoSuspendWindow.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJSuspendWindowManager+DemoSuspendWindow.h"

@implementation CJSuspendWindowManager (DemoSuspendWindow)

+ (CJSuspendWindow *)windowWithIdentifier:(NSString *)windowIdentifier {
    DemoSuspendWindow *suspendWindow = (DemoSuspendWindow *)[CJSuspendWindowManager windowForKey:windowIdentifier];
    if (suspendWindow == nil) {
        suspendWindow = [[DemoSuspendWindow alloc] initWithFrame:CGRectZero];
        suspendWindow.windowIdentifier = windowIdentifier;
        
        [CJSuspendWindowManager saveWindow:suspendWindow forKey:suspendWindow.windowIdentifier];
    }
    return suspendWindow;
}

@end
