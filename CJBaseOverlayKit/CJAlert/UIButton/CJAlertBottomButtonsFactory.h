//
//  CJAlertBottomButtonsFactory.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/1/31.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJAlertBottomButtonsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJAlertBottomButtonsFactory : NSObject

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
                                                       fixedSpacing:(CGFloat)fixedSpacing;

@end

NS_ASSUME_NONNULL_END
