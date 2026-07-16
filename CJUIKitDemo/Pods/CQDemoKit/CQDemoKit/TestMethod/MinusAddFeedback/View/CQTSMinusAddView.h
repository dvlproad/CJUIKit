//
//  CQTSMinusAddView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 12/7/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//
//  本视图介绍：中间是文本框，左侧"-"按钮，右侧"+"按钮 的视图（常用于时间加减、数值加减)
//  本视图独立封装，而不是放在cell中，是为了后续可能有其他非列表cell里地方需要这个视图的时候，可以直接拿来使用，避免重复开发

#import <UIKit/UIKit.h>
#import "CQTSManualTestMethodModel.h"

@interface CQTSMinusAddView : UIView {
    
}
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, copy, readonly) NSString *text;

#pragma mark - Setter
- (void)setText:(NSString *)text;

#pragma mark - Init
/*
 *  初始化
 *
 *  @param minusHandle      左侧"-"按钮的点击事件
 *  @param addHandle        右侧"+"按钮的点击事件
 *
 *  @return 中间是文本框，左侧"-"按钮，右侧"+"按钮 的视图
 */
- (instancetype)initWithMinusHandle:(void(^)(UIButton *button))minusHandle
                          addHandle:(void(^)(UIButton *button))addHandle;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end
