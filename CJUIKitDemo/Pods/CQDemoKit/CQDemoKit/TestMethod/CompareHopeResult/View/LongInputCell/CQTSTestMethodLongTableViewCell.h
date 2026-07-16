//
//  CQTSTestMethodLongTableViewCell.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/12/29.
//  Copyright © 2017年 dvlproad. All rights reserved.
//
//  Cell视图【多行排列】的文本列表单元

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CQTSMethodValidateResult) {
    CQTSMethodValidateResultNoHopeResultText,   /**< 未提供 hopeResultText，无法比较，自行验证 → 黄色 */
    CQTSMethodValidateResultMatch,              /**< 有提供 hopeResultText，文本未改，结果一致 → 绿色 */
    CQTSMethodValidateResultMismatch,           /**< 有提供 hopeResultText，文本未改，结果不一致 → 红色 */
    CQTSMethodValidateResultModified,           /**< 有提供 hopeResultText，文本已改，自行验证 → 蓝色 */
};

// 按钮位置(中间：适合按钮文字长，左侧：适合按钮文字短），设置后自动更新布局
typedef NS_ENUM(NSInteger, CJValidateButtonPosition) {
    CJValidateButtonPositionMiddle,  /**< 按钮在中间（默认）：适合按钮文字长 */
    CJValidateButtonPositionLeft,    /**< 按钮在左侧：适合按钮文字短 */
};

typedef NS_ENUM(NSInteger, CJValidateTriggerType) {
    CJValidateTriggerTypeValidateButtonClick,        /**< 用户点击按钮触发 */
    CJValidateTriggerTypeTextChanged,   /**< 文本内容变化触发 */
    CJValidateTriggerTypeCellInitial,   /**< cell首次显示自动触发 */
};

@interface CQTSTestMethodLongTableViewCell : UITableViewCell <UITextViewDelegate> {
    
}
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *resultLabel;
@property (nonatomic, assign) CGFloat fixTextViewHeight;  /**< 固定textView的视图高度（该值大于44才生效），默认固定为44 */
@property (nonatomic, strong) NSIndexPath *indexPath;      /**< 设置后自动按 section 设置左侧竖线颜色 */

@property (nonatomic, copy) CQTSMethodValidateResult (^validateHandle)(CQTSTestMethodLongTableViewCell *mcell, CJValidateTriggerType triggerType);

@property (nonatomic, copy) void(^textDidChangeBlock)(NSString *bText); /**< 文本框内容变化的回调 */

/**
 *  cell执行既定操作
 *
 *  @param triggerType   触发验证的来源
 */
- (void)validateWithTriggerType:(CJValidateTriggerType)triggerType;

#pragma mark - Config
/*
 *  设置执行按钮的title
 *
 *  @param buttonTitle      按钮的title
 *  @param buttonPosition   按钮位置(中间：适合按钮文字长，左侧：适合按钮文字短），设置后自动更新布局
 */
- (void)configButtonTitle:(NSString *)buttonTitle buttonPosition:(CJValidateButtonPosition)buttonPosition;

@end

NS_ASSUME_NONNULL_END
