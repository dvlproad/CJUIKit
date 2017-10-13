//
//  UIView+CJFind.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/18.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "UIView+CJFind.h"

@implementation UIView (CJFind)

- (nullable UIViewController *)belongViewController {
    UIResponder *responder = self;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]]) {
            return (UIViewController *)responder;
        }
    return nil;
}

////通过view找到拥有这个View的Controller
//- (UIViewController *)belongViewController
//{
//    for (UIView *next = [self superview]; next; next = next.superview) {
//        UIResponder *nextResponder = [next nextResponder];
//        if ([nextResponder isKindOfClass:[UIViewController class]]) {
//            return (UIViewController *)nextResponder;
//        }
//    }
//    return nil;
//}

@end
