//
//  UIView+CJDragAction.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/05.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "UIView+CJDragAction.h"
#import <objc/runtime.h>

@interface UIView ()

@property (nonatomic, assign) UIPanGestureRecognizer *cjPanGestureRecognizer;

@end

@implementation UIView (CJDragAction)

static NSString * const cjDragEnableKey = @"cjDragEnableKey";
static NSString * const cjDragBeginBlockKey = @"cjDragBeginBlockKey";
static NSString * const cjDragDuringBlockKey = @"cjDragDuringBlockKey";
static NSString * const cjDragEndBlockKey = @"cjDragEndBlockKey";

static NSString * const cjPanGestureRecognizerKey = @"cjPanGestureRecognizerKey";

#pragma mark - runtime
//cjDragEnable
- (BOOL)cjDragEnable {
    return [objc_getAssociatedObject(self, &cjDragEnableKey) boolValue];
}

- (void)setCjDragEnable:(BOOL)cjDragEnable {
    objc_setAssociatedObject(self, &cjDragEnableKey, @(cjDragEnable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (cjDragEnable && !self.cjPanGestureRecognizer) {
        //添加拖动手势
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragAction:)];
        panGestureRecognizer.minimumNumberOfTouches = 1;
        panGestureRecognizer.maximumNumberOfTouches = 1;
        [self addGestureRecognizer:panGestureRecognizer];
        
        self.cjPanGestureRecognizer = panGestureRecognizer;
    }
}

//cjDragBeginBlock
- (void (^)(UIView *))cjDragBeginBlock {
    return objc_getAssociatedObject(self, &cjDragBeginBlockKey);
}

- (void)setCjDragBeginBlock:(void (^)(UIView *))cjDragBeginBlock {
    objc_setAssociatedObject(self, &cjDragBeginBlockKey, cjDragBeginBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

//cjDragDuringBlock
- (void (^)(UIView *))cjDragDuringBlock {
    return objc_getAssociatedObject(self, &cjDragDuringBlockKey);
}

- (void)setCjDragDuringBlock:(void (^)(UIView *))cjDragDuringBlock {
    objc_setAssociatedObject(self, &cjDragDuringBlockKey, cjDragDuringBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

//cjDragEndBlock
- (void (^)(UIView *))cjDragEndBlock {
    return objc_getAssociatedObject(self, &cjDragEndBlockKey);
}

- (void)setCjDragEndBlock:(void (^)(UIView *))cjDragEndBlock {
    objc_setAssociatedObject(self, &cjDragEndBlockKey, cjDragEndBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

//cjPanGestureRecognizer
- (UIPanGestureRecognizer *)cjPanGestureRecognizer {
    return objc_getAssociatedObject(self, &cjPanGestureRecognizerKey);
}

- (void)setCjPanGestureRecognizer:(UIPanGestureRecognizer *)cjPanGestureRecognizer {
    objc_setAssociatedObject(self, &cjPanGestureRecognizerKey, cjPanGestureRecognizer, OBJC_ASSOCIATION_ASSIGN);
}


/**
 *  拖动事件
 *
 *  @param pan    拖动的手势
 */
- (void)dragAction:(UIPanGestureRecognizer *)pan {
    if (self.cjDragEnable == NO) {    //不可以拖动，直接返回
        return;
    }
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: //拖动开始
        {
            if (self.cjDragBeginBlock) {
                self.cjDragBeginBlock(self);
            }
            break;
        }
        case UIGestureRecognizerStateChanged:   //拖动中
        {
            if ([self isKindOfClass:[UIWindow class]]) {
                CGPoint panPoint = [pan locationInView:self];
                CGFloat centerX = CGRectGetMinX(self.frame) + panPoint.x;
                CGFloat centerY = CGRectGetMinY(self.frame) + panPoint.y;
                self.center = CGPointMake(centerX, centerY);
            } else {
                CGPoint panPoint = [pan locationInView:self.superview];
                self.center = CGPointMake(panPoint.x, panPoint.y);
            }
            
            if (self.cjDragDuringBlock) {
                self.cjDragDuringBlock(self);
            }
            break;
        }
        case UIGestureRecognizerStateEnded: //拖动结束
        {
            if (self.cjDragEndBlock) {
                self.cjDragEndBlock(self);
            }
            
            break;
        }
        default:
            break;
    }
}

@end
