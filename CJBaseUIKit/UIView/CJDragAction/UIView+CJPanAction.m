//
//  UIView+CJPanAction.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/05/10.
//  Copyright © 2019年 dvlproad. All rights reserved.
//

#import "UIView+CJPanAction.h"
#import <objc/runtime.h>

@interface UIView () <UIGestureRecognizerDelegate> {
    
}
@property (nonatomic, copy) void(^cjPaningOffsetBlock)(BOOL isDown, CGPoint offset);
@property (nonatomic, copy) void(^cjPanCompleteBlock)(BOOL isFast);

@property (nonatomic, strong) UIPanGestureRecognizer *cjPan_PanGestureRecognizer;
//当前正在拖拽的是否是tableView
@property (nonatomic, assign) BOOL cjPan_isDragScrollView;
@property (nonatomic, strong) UIScrollView *cjPan_scrollerView;
//向下拖拽最后时刻的位移(设置成CGFloat类型，不知道为什么在runtime中会崩溃)
@property (nonatomic, assign) NSInteger cjPan_lastDrapDistance;


@end


@implementation UIView (CJPanAction)

#pragma mark - runtime:block
- (void (^)(BOOL, CGPoint))cjPaningOffsetBlock {
    return objc_getAssociatedObject(self, @selector(cjPaningOffsetBlock));
}

- (void)setCjPaningOffsetBlock:(void (^)(BOOL, CGPoint))cjPaningOffsetBlock {
    objc_setAssociatedObject(self, @selector(cjPaningOffsetBlock), cjPaningOffsetBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(BOOL))cjPanCompleteBlock {
    return objc_getAssociatedObject(self, @selector(cjPanCompleteBlock));
}

- (void)setCjPanCompleteBlock:(void (^)(BOOL))cjPanCompleteBlock {
    objc_setAssociatedObject(self, @selector(cjPanCompleteBlock), cjPanCompleteBlock, OBJC_ASSOCIATION_COPY);
}


#pragma mark - runtime:view
- (UIScrollView *)cjPan_scrollerView {
    return objc_getAssociatedObject(self, @selector(cjPan_scrollerView));
}

- (void)setCjPan_scrollerView:(UIScrollView *)cjPan_scrollerView {
    objc_setAssociatedObject(self, @selector(cjPan_scrollerView), cjPan_scrollerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - runtime:GR
- (UIPanGestureRecognizer *)cjPan_PanGestureRecognizer {
    return objc_getAssociatedObject(self, @selector(cjPan_PanGestureRecognizer));
}

- (void)setCjPan_PanGestureRecognizer:(UIPanGestureRecognizer *)cjPan_PanGestureRecognizer {
    objc_setAssociatedObject(self, @selector(cjPan_PanGestureRecognizer), cjPan_PanGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - rumtime:frame
- (CGRect)cjPanStartFrame {
    NSString *frameString = objc_getAssociatedObject(self, @selector(cjPanStartFrame));
    return CGRectFromString(frameString);
}

- (void)setCjPanStartFrame:(CGRect)cjPanStartFrame {
    NSString *frameString = NSStringFromCGRect(cjPanStartFrame);
    objc_setAssociatedObject(self, @selector(cjPanStartFrame), frameString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark - runtime:data
- (BOOL)cjPan_isDragScrollView {
    return [objc_getAssociatedObject(self, @selector(cjPan_isDragScrollView)) boolValue];
}

- (void)setCjPan_isDragScrollView:(BOOL)cjPan_isDragScrollView {
    objc_setAssociatedObject(self, @selector(cjPan_isDragScrollView), @(cjPan_isDragScrollView), OBJC_ASSOCIATION_ASSIGN);
}


- (NSInteger)cjPan_lastDrapDistance {
    return [objc_getAssociatedObject(self, @selector(cjPan_lastDrapDistance)) integerValue];
}

- (void)setCjPan_lastDrapDistance:(NSInteger)cjPan_lastDrapDistance {
    objc_setAssociatedObject(self, @selector(cjPan_lastDrapDistance), [NSNumber numberWithFloat:cjPan_lastDrapDistance], OBJC_ASSOCIATION_ASSIGN);
}


#pragma mark - Event
/*
 *  添加pan手势
 *
 *  @param panCompleteDismissBlock      拖动结束需要执行dimiss的回调(其他部分已自动内部设置frame)
 */
- (void)cj_addPanWithPanCompleteDismissBlock:(void(^)(void))panCompleteDismissBlock {
    //添加拖拽手势
    [self cj_addPanWithPaningOffsetBlock:^(BOOL isDown, CGPoint transP) {
        CGRect oldFrame = self.frame;
        
        if (isDown) {
            //向下拖 transP.y > 0
            oldFrame.origin.y += transP.y;
            self.frame = oldFrame;
            
        } else {
            //向上拖 transP.y < 0
            CGFloat containerPanStartY = CGRectGetMinY(self.cjPanStartFrame);
            CGFloat containerCurrentY = CGRectGetMinY(self.frame);
            if(containerCurrentY > containerPanStartY){
                NSLog(@"currentY2=%.0f, originY=%0.f", containerCurrentY, containerPanStartY);
                oldFrame.origin.y += transP.y;
                oldFrame.origin.y = MAX(oldFrame.origin.y, containerPanStartY);
                self.frame = oldFrame;
            }
        }
    } panCompleteBlock:^(BOOL isFast) {
        if (isFast) {
            !panCompleteDismissBlock ?: panCompleteDismissBlock();
        } else {
            //如果是普通拖拽
            CGFloat containerCurrentY = CGRectGetMinY(self.frame);
            if(containerCurrentY >=  CGRectGetMidY(self.cjPanStartFrame)) {
                !panCompleteDismissBlock ?: panCompleteDismissBlock();
            } else {
                [UIView animateWithDuration:0.15f
                                      delay:0.0f
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     self.frame = self.cjPanStartFrame;
                                 }
                                 completion:^(BOOL finished) {
                                     NSLog(@"结束");
                                 }];
            }
        }
    }];
}

/*
 *  添加pan手势
 *
 *  @param paningOffsetBlockpan         拖动进行中的回调(isDown:是否是向下，offset:偏移量)
 *  @param cjPanCompleteBlock           拖动结束的回调(isFast:是类似轻扫的那种)
 */
- (void)cj_addPanWithPaningOffsetBlock:(void(^)(BOOL isDown, CGPoint offset))paningOffsetBlock
                      panCompleteBlock:(void(^)(BOOL isFast))panCompleteBlock
{
    NSAssert([self isKindOfClass:[UIScrollView class]] == NO, @"调用此方法的视图不能是UIScrollView或其子类，否则下拉滑动会有问题。解决方式，请将你想要的那个UIScrollView或其子类视图用个UIView包起来，再调用此方法。不信你自己注释掉此行代码，执行下就知道");
    
    self.cjPaningOffsetBlock = paningOffsetBlock;
    self.cjPanCompleteBlock = panCompleteBlock;
    
    
    self.cjPan_isDragScrollView = NO;
    self.cjPan_lastDrapDistance = 0.0;
    
    //添加拖拽手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:panGestureRecognizer];
    panGestureRecognizer.delegate = self;
    self.cjPan_PanGestureRecognizer = panGestureRecognizer;
}



#pragma mark - UIGestureRecognizerDelegate
//1
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch
{
    if(gestureRecognizer == self.cjPan_PanGestureRecognizer) {
        UIView *touchView = touch.view;
        while (touchView != nil) {
            if([touchView isKindOfClass:[UIScrollView class]]) {
                self.cjPan_isDragScrollView = YES;
                self.cjPan_scrollerView = (UIScrollView *)touchView;
                break;
            } else if(touchView == self) {
                self.cjPan_isDragScrollView = NO;
                break;
            }
            touchView = [touchView nextResponder];
        }
    }
    return YES;
}

//2.
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if(gestureRecognizer == self.cjPan_PanGestureRecognizer){
        //如果是自己加的拖拽手势
        NSLog(@"gestureRecognizerShouldBegin");
    }
    return YES;
}

//3. 是否与其他手势共存，一般使用默认值(默认返回NO：不与任何手势共存)
- (BOOL)gestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if(gestureRecognizer == self.cjPan_PanGestureRecognizer) {
        if ([otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIScrollViewPanGestureRecognizer")] || [otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIPanGestureRecognizer")] ) {
            if([otherGestureRecognizer.view isKindOfClass:[UIScrollView class]] ) {

                return YES;
            }
            
        }
    }
    return NO;
}

//拖拽手势
- (void)pan:(UIPanGestureRecognizer *)panGestureRecognizer {
    if(panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        self.cjPanStartFrame = self.frame;
        NSLog(@"cjPanStartFrame=%@", NSStringFromCGRect(self.cjPanStartFrame));
    }
    
    
    // 获取手指的偏移量
    CGPoint transP = [panGestureRecognizer translationInView:self];
    if(self.cjPan_isDragScrollView) {
        //如果当前拖拽的是tableView
        if(self.cjPan_scrollerView.contentOffset.y <= 0) {
            //如果tableView置于顶端
            if(transP.y > 0) {
                //如果向下拖拽
                self.cjPan_scrollerView.contentOffset = CGPointMake(0, 0 );
                self.cjPan_scrollerView.panGestureRecognizer.enabled = NO;
                self.cjPan_scrollerView.panGestureRecognizer.enabled = YES;
                self.cjPan_isDragScrollView = NO;
                //向下拖
                !self.cjPaningOffsetBlock ?: self.cjPaningOffsetBlock(YES, transP);
                
            } else {
                //如果向上拖拽
            }
        }
    } else {
        if(transP.y > 0) {
            //向下拖
            !self.cjPaningOffsetBlock ?: self.cjPaningOffsetBlock(YES, transP);
            
        } else if(transP.y < 0){
            //向上拖
            !self.cjPaningOffsetBlock ?: self.cjPaningOffsetBlock(NO, transP);
        } else {

        }
    }

    [panGestureRecognizer setTranslation:CGPointZero inView:self];
    if(panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        NSLog(@"paneEnded transP : %@",NSStringFromCGPoint(transP));
        if(self.cjPan_lastDrapDistance > 10.0 && self.cjPan_isDragScrollView == NO) {
            //如果是类似轻扫的那种
            !self.cjPanCompleteBlock ?: self.cjPanCompleteBlock(YES);
        } else {
            //如果是普通拖拽
            !self.cjPanCompleteBlock ?: self.cjPanCompleteBlock(NO);
        }
    }
    self.cjPan_lastDrapDistance = transP.y;
}


@end
