//
//  CQTSSuspendWindow.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CQTSSuspendWindow.h"

@implementation CQTSSuspendWindow

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
        [self makeKeyAndVisible];
    }
    return self;
}

- (void)commonInit {
    self.windowLevel = 1000000;
    self.clipsToBounds = YES;
    
    // 添加pan拖动手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragAction:)];
    panGestureRecognizer.minimumNumberOfTouches = 1;
    panGestureRecognizer.maximumNumberOfTouches = 1;
    [self addGestureRecognizer:panGestureRecognizer];
}


#pragma mark - Event
- (void)removeFromScreen {
    self.hidden = YES;
    self.rootViewController = nil;
}


#pragma mark - Private Method
/*
 *  拖动事件
 *
 *  @param pan    拖动的手势
 */
- (void)dragAction:(UIPanGestureRecognizer *)pan {
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: //拖动开始
        {
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
            
            break;
        }
        case UIGestureRecognizerStateEnded: //拖动结束
        {
            //NSLog(@"拖动结束(一般会加上边缘限制)");
            break;
        }
        default:
            break;
    }
}

@end
