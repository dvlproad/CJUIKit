//
//  UITextView+CJVerticalCenter.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "UITextView+CJVerticalCenter.h"

@implementation UITextView (CJVerticalCenter)


/**
 *  让文本框中的文本在竖直方向上居中显示
 *  需要使用的场合有，如下三个：
 *  ①KVO监听contentSize自动让文本居中；
 *  ②当外部mas_makeConstraints初始设置文本框约束的时候，直接立即调用（不需要在vc的viewDidLayoutSubviews或者view的layoutSubviews中执行）
 *  ③当外部mas_remakeConstraints更新文本框位置或大小的时候，延迟0.2秒手动调用此方法（必须延迟执行，否则文本竖直居中无效）
 *
 *  @param delay delay秒后执行（当外部使用mas_remakeConstraints更新文本框位置或大小的时候，必须延迟执行，否则文本竖直居中无效）
 */
- (void)cj_adjustedContentInsetToTextCenter:(CGFloat)delay {
    [self layoutIfNeeded]; // 本行代码是为了避免或为了修复如下情况：mas_makeConstraints或mas_updateConstraints等更新高度会出现偶尔延迟的情况而导致居中错误
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGFloat height = self.bounds.size.height;
        //NSAssert(self.scrollEnabled == YES, @"执行此方法时候，scrollEnabled不能为NO，否则会导致contentSize值不一定正确，最终导致无法竖直居中");
//        CGRect textFrame = [[self layoutManager] usedRectForTextContainer:[self textContainer]];
//        CGFloat contentHeight = CGRectGetHeight(textFrame);
        CGFloat contentHeight = self.contentSize.height;    // 注：如果你设置了self.scrollEnabled = NO;则会导致contentSize有时候不会正确变化，导致无法竖直居中
        CGFloat deadSpace = height - contentHeight;
        CGFloat inset = MAX(0, deadSpace/2.0);
        
        UIEdgeInsets contentInset = self.contentInset;
        contentInset.top = inset;
        contentInset.bottom = inset;
        self.contentInset = contentInset;
    });
}

@end
