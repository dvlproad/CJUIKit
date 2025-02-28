//
//  UIView+CQAuxiliaryText.h
//  CQDemoKit
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

// 包含上下中的枚举： UIControl.ContentVerticalAlignment
// 包含上下中左右的枚举： UIStackView.Alignment ,但只适用于Swift
// 包含左右中的枚举： NSTextAlignment
typedef NS_ENUM(NSInteger, CQAuxiliaryAlignment) {
    CQAuxiliaryAlignmentCenter,
    CQAuxiliaryAlignmentTop,
    CQAuxiliaryAlignmentBottom,
    CQAuxiliaryAlignmentFill
};

// 辅助文本的移除顺序（当有多个相同tag的辅助文本的时候需要）
typedef NS_ENUM(NSInteger, CQAuxiliaryRemoveOrder) {
    CQAuxiliaryRemoveOrderPositive,     // 正序：按添加顺序移除
    CQAuxiliaryRemoveOrderNegative,     // 逆序：后添加到先移除
    CQAuxiliaryRemoveOrderAll,          // 所有的都移除
};

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Prompt)

#pragma mark - 添加辅助文本(含删除）
/// 添加辅助文本
- (void)cqdemo_addPromptText:(NSString *)text layout:(CQAuxiliaryAlignment)layout height:(CGFloat)height;
/// 删除辅助文本
- (void)cqdemo_removePromptText:(CQAuxiliaryRemoveOrder)order;

#pragma mark - 添加任意辅助视图
- (void)cqdemo_addPromptView:(UIView *)promptView layout:(CQAuxiliaryAlignment)layout height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
