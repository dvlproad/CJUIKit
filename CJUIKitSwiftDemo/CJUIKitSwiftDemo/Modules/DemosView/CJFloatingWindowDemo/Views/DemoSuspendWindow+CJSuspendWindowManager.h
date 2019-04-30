//
//  DemoSuspendWindow+CJSuspendWindowManager.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "DemoSuspendWindow.h"

#ifdef TEST_CJBASEUIKIT_POD
#import "CJSuspendWindowManager.h"
#else
#import <CJBaseUIKit/CJSuspendWindowManager.h>
#endif

@interface DemoSuspendWindow (CJSuspendWindowManager)

+ (DemoSuspendWindow *)windowWithIdentifier:(NSString *)windowIdentifier;

@end
