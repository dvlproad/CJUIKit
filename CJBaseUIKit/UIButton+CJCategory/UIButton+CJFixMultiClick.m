//
//  UIButton+CJFixMultiClick.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/1/4.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "UIButton+CJFixMultiClick.h"
#import <objc/runtime.h>

@implementation UIButton (CJFixMultiClick)

// 因category不能添加属性，只能通过关联对象的方式。
static const char *cjMinClickIntervalKey = "cjMinClickIntervalKey";

- (NSTimeInterval)cjMinClickInterval {
    return  [objc_getAssociatedObject(self, cjMinClickIntervalKey) doubleValue];
}

- (void)setCjMinClickInterval:(NSTimeInterval)cjMinClickInterval {
    objc_setAssociatedObject(self, cjMinClickIntervalKey, @(cjMinClickInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static const char *cjLastClickTimestampKey = "cjLastClickTimestampKey";

- (NSTimeInterval)cjLastClickTimestamp {
    return  [objc_getAssociatedObject(self, cjLastClickTimestampKey) doubleValue];
}

- (void)setCjLastClickTimestamp:(NSTimeInterval)cjLastClickTimestamp {
    objc_setAssociatedObject(self, cjLastClickTimestampKey, @(cjLastClickTimestamp), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


// 在load时执行hook
+ (void)load {
    Method before   = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method after    = class_getInstanceMethod(self, @selector(cj_sendAction:to:forEvent:));
    method_exchangeImplementations(before, after);
}

- (void)cj_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if ([NSDate date].timeIntervalSince1970 - self.cjLastClickTimestamp < self.cjMinClickInterval) {
        return;
    }
    
    if (self.cjMinClickInterval > 0) {
        self.cjLastClickTimestamp = [NSDate date].timeIntervalSince1970;
    }
    
    [self cj_sendAction:action to:target forEvent:event];
}


@end
