//
//  UIVerticalCenterTextView.h
//  CJUIKitDemo
//
//  Created by qian on 2020/12/11.
//  Copyright © 2020 dvlproad. All rights reserved.
//
//  文本竖直居中的继承自UITextView的文本框（已完成KVO监听contentSize自动让文本居中的事项）
//  （CJTextView除了有自身textView和placeholderTextView所以独立UITextVIew和CJTextView的文本竖直居中为不同类）

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIVerticalCenterTextView : UITextView {
    
}

#pragma mark - Event
/**
 *  让文本框中的文本在竖直方向上居中显示
 *  需要使用的场合有，如下三个：
 *  ①KVO监听contentSize自动让文本居中；
 *  ②当外部mas_makeConstraints初始设置文本框约束的时候，直接立即调用（不需要在vc的viewDidLayoutSubviews或者view的layoutSubviews中执行）
 *  ③当外部mas_remakeConstraints更新文本框位置或大小的时候，延迟0.2秒手动调用此方法（必须延迟执行，否则文本竖直居中无效）
 *
 *  @param delay delay秒后执行（当外部使用mas_remakeConstraints更新文本框位置或大小的时候，必须延迟执行，否则文本竖直居中无效）
 */
- (void)uiTextView_adjustedContentInsetToTextCenter:(CGFloat)delay;

@end

NS_ASSUME_NONNULL_END
