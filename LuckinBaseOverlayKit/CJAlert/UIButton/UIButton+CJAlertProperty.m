//
//  UIButton+CJAlertProperty.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "UIButton+CJAlertProperty.h"
#import <objc/runtime.h>

static NSString * const cjTouchUpInsideBlockKey = @"cjTouchUpInsideBlockKey";

@implementation UIButton (CJAlertProperty)

#pragma mark - runtime

/// 使用颜色构建的背景图片
UIImage *cjbaseoverlay_buttonBGImage(UIColor *bgColor) {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [bgColor CGColor]);
    CGContextFillRect(context, rect);
    UIImage *normalBGImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return normalBGImage;
}

//cjTouchUpInsideBlock
- (void (^)(UIButton *))cjTouchUpInsideBlock {
    return objc_getAssociatedObject(self, (__bridge const void *)(cjTouchUpInsideBlockKey));
}

- (void)setCjTouchUpInsideBlock:(void (^)(UIButton *))cjTouchUpInsideBlock {
    objc_setAssociatedObject(self, (__bridge const void *)(cjTouchUpInsideBlockKey), cjTouchUpInsideBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    //设置的时候，就给他添加方法，省得再多个接口处理
    [self addTarget:self action:@selector(cjTouchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
}

// 按钮点击
- (void)cjTouchUpInsideAction:(UIButton *)button {
    if (self.cjTouchUpInsideBlock) {
        self.cjTouchUpInsideBlock(button);
    }
}

@end
