//
//  UIView+CJFind.m
//  CJUIKitDemo
//
//  Created by 李超前 on 2017/5/18.
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

@end
