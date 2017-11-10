//
//  UIView+CJExclusiveTouch.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/3.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "UIView+CJExclusiveTouch.h"
#import <objc/runtime.h>

@implementation UIView (CJExclusiveTouch)

static NSString *cjExclusiveTouchKey = @"cjExclusiveTouchKey";

#pragma mark - runtime
//cjExclusiveTouch
- (BOOL)cjExclusiveTouch {
    return [objc_getAssociatedObject(self, &cjExclusiveTouchKey) boolValue];
}

- (void)setCjExclusiveTouch:(BOOL)cjExclusiveTouch {
    objc_setAssociatedObject(self, &cjExclusiveTouchKey, @(cjExclusiveTouch), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self cj_setExclusiveTouch:cjExclusiveTouch forButtons:self];
}

/**
 *  设置UIButton的ExclusiveTouch属性
 */
- (void)cj_setExclusiveTouch:(BOOL)exclusiveTouch forButtons:(UIView *)myView
{
    for (UIView * button in [myView subviews]) {
        if([button isKindOfClass:[UIButton class]])
        {
            [((UIButton *)button) setExclusiveTouch:exclusiveTouch];
        }
        else if ([button isKindOfClass:[UIView class]])
        {
            [self cj_setExclusiveTouch:exclusiveTouch forButtons:button];
        }
    }
}

@end
