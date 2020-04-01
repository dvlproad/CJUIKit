//
//  UIButton+CJMoreProperty.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "UIButton+CJMoreProperty.h"
#import <objc/runtime.h>

static NSString * const cjNormalBGColorKey = @"cjNormalBGColorKey";
static NSString * const cjHighlightedBGColorKey = @"cjHighlightedBGColorKey";
static NSString * const cjDisabledBGColorKey = @"cjDisabledBGColorKey";


static NSString * const cjSelectedBGColorKey = @"cjSelectedBGColorKey";
static NSString * const cjSelectedDisabledBGColorKey = @"cjSelectedDisabledBGColorKey";

static NSString * const cjTouchUpInsideBlockKey = @"cjTouchUpInsideBlockKey";

static NSString * const cjDataModelKey = @"cjDataModelKey";

@implementation UIButton (CJMoreProperty)

#pragma mark - runtime
//cjNormalBGColor
- (UIColor *)cjNormalBGColor {
    return objc_getAssociatedObject(self, &cjNormalBGColorKey) ;
}

- (void)setCjNormalBGColor:(UIColor *)cjNormalBGColor {
    objc_setAssociatedObject(self, &cjNormalBGColorKey, cjNormalBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UIImage *normalBGImage = cj_buttonBGImage(cjNormalBGColor);
    [self setBackgroundImage:normalBGImage forState:UIControlStateNormal];
}

//cjHighlightedBGColor
- (UIColor *)cjHighlightedBGColor {
    return objc_getAssociatedObject(self, &cjHighlightedBGColorKey) ;
}

- (void)setCjHighlightedBGColor:(UIColor *)cjHighlightedBGColor {
    objc_setAssociatedObject(self, &cjHighlightedBGColorKey, cjHighlightedBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UIImage *highlightedBGImage = cj_buttonBGImage(cjHighlightedBGColor);
    [self setBackgroundImage:highlightedBGImage forState:UIControlStateHighlighted];
}

//cjDisabledBGColor
- (UIColor *)cjDisabledBGColor {
    return objc_getAssociatedObject(self, &cjDisabledBGColorKey) ;
}

- (void)setCjDisabledBGColor:(UIColor *)cjDisabledBGColor {
    objc_setAssociatedObject(self, &cjDisabledBGColorKey, cjDisabledBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UIImage *disabledBGImage = cj_buttonBGImage(cjDisabledBGColor);
    [self setBackgroundImage:disabledBGImage forState:UIControlStateNormal | UIControlStateDisabled];
}

//cjSelectedDisabledBGColor
- (UIColor *)cjSelectedDisabledBGColor {
    return objc_getAssociatedObject(self, &cjSelectedDisabledBGColorKey) ;
}

- (void)setCjSelectedDisabledBGColor:(UIColor *)cjSelectedDisabledBGColor {
    objc_setAssociatedObject(self, &cjSelectedDisabledBGColorKey, cjSelectedDisabledBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UIImage *disabledBGImage = cj_buttonBGImage(cjSelectedDisabledBGColor);
    [self setBackgroundImage:disabledBGImage forState:UIControlStateSelected | UIControlStateDisabled];
}


//cjSelectedBGColor
- (UIColor *)cjSelectedBGColor {
    return objc_getAssociatedObject(self, &cjSelectedBGColorKey) ;
}

- (void)setCjSelectedBGColor:(UIColor *)cjSelectedBGColor {
    objc_setAssociatedObject(self, &cjSelectedBGColorKey, cjSelectedBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UIImage *selectedBGImage = cj_buttonBGImage(cjSelectedBGColor);
    [self setBackgroundImage:selectedBGImage forState:UIControlStateSelected];
}

/// 使用颜色构建的背景图片
UIImage *cj_buttonBGImage(UIColor *bgColor) {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [bgColor CGColor]);
    CGContextFillRect(context, rect);
    UIImage *normalBGImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return normalBGImage;
}

//cjDataModel
- (id)cjDataModel {
    return objc_getAssociatedObject(self, &cjDataModelKey) ;
}

- (void)setCjDataModel:(id)cjDataModel {
    return objc_setAssociatedObject(self, &cjDataModelKey, cjDataModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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
