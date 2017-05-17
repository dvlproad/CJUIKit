//
//  UIScrollView+CJAddScaleHead.m
//  CJUIKitDemo
//
//  Created by 李超前 on 2017/5/16.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "UIScrollView+CJAddScaleHead.h"
#import <objc/runtime.h>

@interface UIScrollView ()

//@property (nonatomic, strong) NSLayoutConstraint *cjScaleHeadViewTopConstraint;
//@property (nonatomic, strong) NSLayoutConstraint *cjScaleHeadViewHeightConstraint;

@end

@implementation UIScrollView (CJAddScaleHead)

#pragma mark - runtime
static NSString *kCJScaleHeadViewKey = @"kCJScaleHeadViewKey";

- (CJScaleHeadView *)cjScaleHeadView {
    return objc_getAssociatedObject(self, &kCJScaleHeadViewKey);
}

- (void)setCjScaleHeadView:(CJScaleHeadView *)cjScaleHeadView {
    objc_setAssociatedObject(self, &kCJScaleHeadViewKey, cjScaleHeadView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self cj_addScaleHeadView:self.cjScaleHeadView];
}

- (void)cj_addScaleHeadView:(UIView *)scaleHeadView {
    scaleHeadView.clipsToBounds = YES;   //剪切多余部分
    self.alwaysBounceVertical = YES;     //设置UIScrollView永远支持垂直弹簧效果
    
    CGFloat scaleHeadViewHeight = CGRectGetHeight(scaleHeadView.frame);
    
    //设置contentInset
    UIEdgeInsets contentInset = self.contentInset;
    contentInset.top += scaleHeadViewHeight;
    self.contentInset = contentInset;
    
    //设置contentOffset
    CGPoint contentOffset = self.contentOffset;
    contentOffset.y -= scaleHeadViewHeight;
    self.contentOffset = contentOffset;
    
    [self addSubview:scaleHeadView];
}


@end
