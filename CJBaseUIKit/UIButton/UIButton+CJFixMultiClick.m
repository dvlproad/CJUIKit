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
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        SEL selA = @selector(sendAction:to:forEvent:);
        SEL selB = @selector(cj_sendAction:to:forEvent:);
        
        Method methodA = class_getInstanceMethod(self, selA);
        Method methodB = class_getInstanceMethod(self, selB);
        
        //将methodB的实现添加到系统方法中也就是说将methodA方法指针添加成方法methodB的返回值表示是否添加成功
        //注：判断条件不能少，否则非常容易出现崩溃
        BOOL isAdd = class_addMethod(self,
                                    selA,
                                    method_getImplementation(methodB),
                                    method_getTypeEncoding(methodB));
        
        //添加成功了说明本类中不存在methodB所以此时必须将方法b的实现指针换成方法A的，否则b方法将没有实现。
        if(isAdd) {
            class_replaceMethod(self, selB,method_getImplementation(methodA),method_getTypeEncoding(methodA));
            
        } else {
            //添加失败了说明本类中有methodB的实现，此时只需要将methodA和methodB的IMP互换一下即可。
            method_exchangeImplementations(methodA, methodB);
            
        }
        
    });
}

- (void)cj_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if ([NSDate date].timeIntervalSince1970 - self.cjLastClickTimestamp < self.cjMinClickInterval) {
        return;
    }
    
    if (self.cjMinClickInterval > 0) {
        self.cjLastClickTimestamp = [NSDate date].timeIntervalSince1970;
    }
    
    //此处methodA和methodB方法IMP互换了，实际上执行sendAction；所以不会死循环
    [self cj_sendAction:action to:target forEvent:event];
}


@end
