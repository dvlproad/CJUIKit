//
//  UIViewController+CJSystemComposeView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/10/10.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "UIViewController+CJSystemComposeView.h"
#import <objc/runtime.h>

@implementation UIViewController (CJSystemComposeView)

#pragma mark - runtime
//cjComposeView
- (UIView *)cjComposeView {
    return objc_getAssociatedObject(self, @selector(cjComposeView));
}

- (void)setCjComposeView:(UIView *)cjComposeView {
    objc_setAssociatedObject(self, @selector(cjComposeView), cjComposeView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//cjComponentViewControllers
- (NSMutableArray<UIViewController *> *)cjComponentViewControllers {
    return objc_getAssociatedObject(self, @selector(cjComponentViewControllers));
}

- (void)setCjComponentViewControllers:(NSMutableArray<UIViewController *> *)cjComponentViewControllers {
    objc_setAssociatedObject(self, @selector(cjComponentViewControllers), cjComponentViewControllers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    for (UIViewController *childViewController in self.childViewControllers) {
        [childViewController.view removeFromSuperview];
        [childViewController removeFromParentViewController];
    }
    
    NSInteger count = cjComponentViewControllers.count;
    for (NSInteger index = 0; index < count; index++) {
        if (index == self.cjCurrentSelectedIndex) {
            UIViewController *childViewController = [self.cjComponentViewControllers objectAtIndex:index];
            [self addChildViewController:childViewController];
            [self cjSystemComposeView_makeView:self.cjComposeView addSubView:childViewController.view withEdgeInsets:UIEdgeInsetsZero];
        }
    }
}

//cjCurrentSelectedIndex
- (NSInteger)cjCurrentSelectedIndex {
    return [objc_getAssociatedObject(self, @selector(cjCurrentSelectedIndex)) integerValue];
}

- (void)setCjCurrentSelectedIndex:(NSInteger)cjCurrentSelectedIndex {
    objc_setAssociatedObject(self, @selector(cjCurrentSelectedIndex), @(cjCurrentSelectedIndex), OBJC_ASSOCIATION_ASSIGN);
}

- (void)cjReplaceChildViewControllerIndex:(NSInteger)index_old
              newChildViewControllerIndex:(NSInteger)index_new
                            completeBlock:(void(^)(NSInteger index_cur))completeBlock;
{
    if (index_new == index_old) {
        return;
    }
    
    UIViewController *oldShowViewController = [self.cjComponentViewControllers objectAtIndex:index_old];
    UIViewController *newShowViewController = [self.cjComponentViewControllers objectAtIndex:index_new];
    
    [self addChildViewController:newShowViewController];
    [self transitionFromViewController:oldShowViewController toViewController:newShowViewController duration:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
    } completion:^(BOOL finished) {
        if (finished) {
            [newShowViewController didMoveToParentViewController:self];
            [oldShowViewController willMoveToParentViewController:nil];
            [oldShowViewController.view removeFromSuperview];
            [oldShowViewController removeFromParentViewController];
            [self cjSystemComposeView_makeView:self.cjComposeView addSubView:newShowViewController.view withEdgeInsets:UIEdgeInsetsZero];
            
            self.cjCurrentSelectedIndex = index_new;
            if (completeBlock) {
                completeBlock(index_new);
            }
            
        } else {
            self.cjCurrentSelectedIndex = index_old;
            if (completeBlock) {
                completeBlock(index_old);
            }
        }
    }];
}

#pragma mark - addSubView
- (void)cjSystemComposeView_makeView:(UIView *)superView addSubView:(UIView *)subView withEdgeInsets:(UIEdgeInsets)edgeInsets {
    [superView addSubview:subView];
    subView.translatesAutoresizingMaskIntoConstraints = NO;
    //left
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeLeft
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:1
                                   constant:edgeInsets.left]];
    //right
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeRight
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:edgeInsets.right]];
    //top
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeTop
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeTop
                                 multiplier:1
                                   constant:edgeInsets.top]];
    //bottom
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeBottom
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1
                                   constant:edgeInsets.bottom]];
}


@end
