//
//  CJSuspendWindowManager+DemoSuspendWindow.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJSuspendWindowManager.h"
#import "DemoSuspendWindow.h"

@interface CJSuspendWindowManager (DemoSuspendWindow)

+ (CJSuspendWindow *)windowWithIdentifier:(NSString *)windowIdentifier;

@end
