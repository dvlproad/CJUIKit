//
//  CJAlertBottomButtonsFactory.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/1/31.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CJAlertBottomButtonsFactory.h"
#import <Masonry/Masonry.h>

@implementation CJAlertBottomButtonsFactory

#pragma mark - Horizontal TwoButtons
/**
 *  添加 "Cancel" + "OK" 的 水平组合按钮
 *
 *  @param cancelButton                             取消按钮
 *  @param okButton                                      确认按钮
 *  @param actionButtonHeight                按钮的高
 *  @param bottomButtonsLeftOffset     按钮与左边的间距
 *  @param fixedSpacing                             水平中间距
 */
+ (CJAlertBottomButtonsModel *)horizontalTwoButtonsWithCancelButton:(UIButton *)cancelButton
                                                           okButton:(UIButton *)okButton
                                                 actionButtonHeight:(CGFloat)actionButtonHeight
                                            bottomButtonsLeftOffset:(CGFloat)bottomButtonsLeftOffset
                                                       fixedSpacing:(CGFloat)fixedSpacing
                                            
{
    UIView *bottomButtonView = [[UIView alloc] init];
    
    //bottomButtons
    NSArray<UIButton *> *bottomButtons = @[cancelButton, okButton];
    for (UIButton *bottomButton in bottomButtons) {
        [bottomButtonView addSubview:bottomButton];
    }
    [bottomButtons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(bottomButtonView);
        make.height.mas_equalTo(actionButtonHeight);
    }];
    [bottomButtons mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:fixedSpacing leadSpacing:bottomButtonsLeftOffset tailSpacing:-bottomButtonsLeftOffset];
    
    CGFloat bottomPartHeight = actionButtonHeight;
    
    CJAlertBottomButtonsModel *bottomButtonsModel = [[CJAlertBottomButtonsModel alloc] init];
    bottomButtonsModel.bottomButtonView = bottomButtonView;
    bottomButtonsModel.bottomPartHeight = bottomPartHeight;
    bottomButtonsModel.okButton = okButton;
    bottomButtonsModel.cancelButton = cancelButton;
    
    return bottomButtonsModel;
}

#pragma mark - Vertical TwoButtons
/**
 *  添加 "Cancel" + "OK" 的 竖直组合按钮
 *
 *  @param cancelButton                             取消按钮
 *  @param okButton                                      确认按钮
 *  @param actionButtonHeight                按钮的高
 *  @param bottomButtonsLeftOffset     按钮与左边的间距
 *  @param fixedSpacing                             竖直中间距
 */
+ (CJAlertBottomButtonsModel *)verticalButtonsWithCancelButton:(UIButton *)cancelButton
                                                      okButton:(UIButton *)okButton
                                            actionButtonHeight:(CGFloat)actionButtonHeight
                                       bottomButtonsLeftOffset:(CGFloat)bottomButtonsLeftOffset
                                                  fixedSpacing:(CGFloat)fixedSpacing
{
    UIView *bottomButtonView = [[UIView alloc] init];
    
    //bottomButtons
    NSArray<UIButton *> *bottomButtons = @[cancelButton, okButton];
    for (UIButton *bottomButton in bottomButtons) {
        [bottomButtonView addSubview:bottomButton];
    }
    [bottomButtons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bottomButtonView);
        make.left.mas_equalTo(bottomButtonsLeftOffset);
        make.height.mas_equalTo(actionButtonHeight);
    }];
    [bottomButtons mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:fixedSpacing leadSpacing:0 tailSpacing:0];
    
    
    NSInteger buttonCount = bottomButtons.count;
    CGFloat bottomPartHeight = buttonCount*(actionButtonHeight+fixedSpacing) - fixedSpacing;
    
    CJAlertBottomButtonsModel *bottomButtonsModel = [[CJAlertBottomButtonsModel alloc] init];
    bottomButtonsModel.bottomButtonView = bottomButtonView;
    bottomButtonsModel.bottomPartHeight = bottomPartHeight;
    bottomButtonsModel.okButton = okButton;
    bottomButtonsModel.cancelButton = cancelButton;
    
    return bottomButtonsModel;
}

@end
