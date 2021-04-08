//
//  PopupViewAddCJHelper.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import "PopupViewAddCJHelper.h"
#import <objc/runtime.h>
#import "UIButton+CJMoreProperty.h"

static NSString *cjTapViewKey = @"cjTapView";


@implementation PopupViewAddCJHelper

/*
 *  在popupSuperview上添加BlankView和popupView
 *
 *  @param popupSuperview           被添加到的地方
 *  @param blankViewBelong          blankView用哪个视图的属性来标记
 *  @param popupView                要被添加的视图
 *  @param tapBlankHandle           点击blankView后，要执行的方法
 *
 *  @return 添加的blankView和popupView
 */
+ (CJBasePopupInfo *)addSubviewForPopupSuperview:(nullable UIView *)popupSuperview
                             withBlankViewBelong:(CJBlankViewBelong)blankViewBelong
                                       popupView:(UIView *)popupView
                                  tapBlankHandle:(void(^ _Nullable)(void))tapBlankHandle
{
    if ([popupSuperview.subviews containsObject:popupView]) {
        return nil;
    }
    
    /* 1、popupSuperview添加空白的点击区域blankView */
    UIView *blankView;
    if (blankViewBelong == CJBlankViewBelongPopupView) {
        blankView = objc_getAssociatedObject(popupView, &cjTapViewKey);
    } else if (blankViewBelong == CJBlankViewBelongSuper) {
        blankView = objc_getAssociatedObject(popupSuperview, &cjTapViewKey);
    } else {
        blankView = objc_getAssociatedObject(popupView, &cjTapViewKey);
    }
    
    if (blankView == nil) { // 确保只有一个背景（否则弹出多个弹窗，容易叠加）
        blankView = [[UIView alloc] initWithFrame:CGRectZero];
        
        // 为了解决bug:将手势改为button，防止弹出的视图上有tableView或collectionView的时候，点击上面的cell会无法响应cell的点击事件，而变成响应tap的事件的bug
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:popupView action:@selector(cj_TapBlankViewAction:)];
//        [blankView addGestureRecognizer:tapGesture];
        UIButton *tapButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //tapButton.backgroundColor = [UIColor redColor];
        //[tapButton addTarget:blankTarget action:blankAction forControlEvents:UIControlEventTouchUpInside];
        tapButton.cjTouchUpInsideBlock = ^(UIButton *button) {
            !tapBlankHandle ?: tapBlankHandle();
        };
        [PopupViewAddCJHelper cjPopup_makeView:blankView addSubView:tapButton withEdgeInsets:UIEdgeInsetsZero];
        
        
        [PopupViewAddCJHelper cjPopup_makeView:popupSuperview addSubView:blankView withEdgeInsets:UIEdgeInsetsZero];
//        [popupSuperview addSubview:blankView];
//        CGFloat blankViewWidth = CGRectGetWidth(popupSuperview.frame);
//        CGFloat blankViewHeight = CGRectGetHeight(popupSuperview.frame);
//        CGRect blankViewFrame = CGRectMake(0, 0, blankViewWidth, blankViewHeight);
//        [blankView setFrame:blankViewFrame];    // blankView直接添加上去，popupView的Frame才用来控制动画
    }
    
    if (blankViewBelong == CJBlankViewBelongPopupView) {
        objc_setAssociatedObject(popupView, &cjTapViewKey, blankView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    } else if (blankViewBelong == CJBlankViewBelongSuper) {
        objc_setAssociatedObject(popupSuperview, &cjTapViewKey, blankView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    } else {
        objc_setAssociatedObject(popupView, &cjTapViewKey, blankView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    /* 2、blankView添加popupView */
    [blankView addSubview:popupView];   // popupView改成添加到blankView中
    
    CJBasePopupInfo *popupInfo = [[CJBasePopupInfo alloc] init];
    popupInfo.blankView = blankView;
    popupInfo.popupView = popupView;
    
    return popupInfo;
}


#pragma mark - Private Method
+ (void)cjPopup_makeView:(UIView *)superView addSubView:(UIView *)subView withEdgeInsets:(UIEdgeInsets)edgeInsets {
    [superView addSubview:subView];
    subView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeLeft   //left
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:1
                                   constant:edgeInsets.left]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeRight  //right
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:edgeInsets.right]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeTop    //top
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeTop
                                 multiplier:1
                                   constant:edgeInsets.top]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeBottom //bottom
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1
                                   constant:edgeInsets.bottom]];
}


@end
