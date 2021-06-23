//
//  UITextView+CJVerticalCenter.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CJVerticalAlignment) {
    CJVerticalAlignmentCenterByOne = 0, /**< 这种方式，能修复发现卡片滚动的问题 */
    CJVerticalAlignmentCenterByTwo,     /**< 这种方式，能修复编辑里卡片的一句话的居中问题 */
    CJVerticalAlignmentCenterGiveUp,    /**< 这种方式，用于临时放弃居中功能，如编辑资料里的文字修改 */
};

@interface UITextView (CJVerticalCenter)

/**
 *  让文本框中的文本在竖直方向上居中显示
 *  需要使用的场合有，如下三个：
 *  ①KVO监听contentSize自动让文本居中；
 *  ②当外部mas_makeConstraints初始设置文本框约束的时候，直接立即调用（不需要在vc的viewDidLayoutSubviews或者view的layoutSubviews中执行）
 *  ③当外部mas_remakeConstraints更新文本框位置或大小的时候，延迟0.2秒手动调用此方法（必须延迟执行，否则文本竖直居中无效）
 *
 *  @param delay delay秒后执行（当外部使用mas_remakeConstraints更新文本框位置或大小的时候，必须延迟执行，否则文本竖直居中无效）
 */
- (void)cj_adjustedContentInsetToTextCenter:(CGFloat)delay verticalAlignment:(CJVerticalAlignment)verticalAlignment;

@end

NS_ASSUME_NONNULL_END
