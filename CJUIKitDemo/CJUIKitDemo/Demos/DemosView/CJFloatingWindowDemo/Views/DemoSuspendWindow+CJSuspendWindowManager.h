//
//  DemoSuspendWindow+CJSuspendWindowManager.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "DemoSuspendWindow.h"

#ifdef CJTESTPOD
#import "CJSuspendWindowManager.h"
#else
#import <CJBaseUIKit/CJSuspendWindowManager.h>
#endif

@interface DemoSuspendWindow (CJSuspendWindowManager)

+ (DemoSuspendWindow *)windowWithIdentifier:(NSString *)windowIdentifier;

@end
