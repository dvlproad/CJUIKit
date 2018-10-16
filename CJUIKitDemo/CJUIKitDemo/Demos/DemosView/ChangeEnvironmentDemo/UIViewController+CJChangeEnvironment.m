//
//  UIViewController+CJChangeEnvironment.m
//  CJUIKitDemo
//
//  Created by 李超前 on 2018/10/12.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "UIViewController+CJChangeEnvironment.h"
#import <objc/runtime.h>

@implementation UIViewController (CJChangeEnvironment)

#pragma mark - runtime
//cjChangeEnvironmentButton
- (UIButton *)cjChangeEnvironmentButton {
    return objc_getAssociatedObject(self, @selector(cjChangeEnvironmentButton));
}

- (void)setCjChangeEnvironmentButton:(UIButton *)cjChangeEnvironmentButton {
    objc_setAssociatedObject(self, @selector(cjChangeEnvironmentButton), cjChangeEnvironmentButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//cjCurrentEnvironmentIndex
- (NSInteger)cjCurrentEnvironmentIndex {
    return [objc_getAssociatedObject(self, @selector(cjCurrentEnvironmentIndex)) integerValue];
}

- (void)setCjCurrentEnvironmentIndex:(NSInteger)cjCurrentEnvironmentIndex {
    objc_setAssociatedObject(self, @selector(cjCurrentEnvironmentIndex), @(cjCurrentEnvironmentIndex), OBJC_ASSOCIATION_ASSIGN);
}


//cjEnvironmentTitles
- (NSMutableArray<NSString *> *)cjEnvironmentTitles {
    return objc_getAssociatedObject(self, @selector(cjEnvironmentTitles));
}

- (void)setCjEnvironmentTitles:(NSMutableArray<NSString *> *)cjEnvironmentTitles {
    objc_setAssociatedObject(self, @selector(cjEnvironmentTitles), cjEnvironmentTitles, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//cjCurrentEnvironmentTitle
- (NSString *)cjCurrentEnvironmentTitle {
    return objc_getAssociatedObject(self, @selector(cjCurrentEnvironmentTitle));
}

- (void)setCjCurrentEnvironmentTitle:(NSString *)cjCurrentEnvironmentTitle {
    objc_setAssociatedObject(self, @selector(cjCurrentEnvironmentTitle), cjCurrentEnvironmentTitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
