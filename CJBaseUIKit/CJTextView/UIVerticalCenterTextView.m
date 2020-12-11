//
//  UIVerticalCenterTextView.m
//  CJUIKitDemo
//
//  Created by qian on 2020/12/11.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "UIVerticalCenterTextView.h"
#import "UITextView+CJVerticalCenter.h"

@interface UIVerticalCenterTextView () {
    
}

@end

@implementation UIVerticalCenterTextView

- (void)dealloc {
    [self removeNotification];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [self registerNotification];
}

#pragma mark - KVO Rigister & Remove
- (void)registerNotification {
    [self addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
}

- (void)removeNotification {
    [self removeObserver:self forKeyPath:@"contentSize"];
    [self removeObserver:self forKeyPath:@"frame"];
}


#pragma mark - KVO CallBack
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentSize"] || [keyPath isEqualToString:@"frame"]) {
        [self uiTextView_adjustedContentInsetToTextCenter:0];
    }
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
- (void)uiTextView_adjustedContentInsetToTextCenter:(CGFloat)delay {
    [self cj_adjustedContentInsetToTextCenter:delay];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
