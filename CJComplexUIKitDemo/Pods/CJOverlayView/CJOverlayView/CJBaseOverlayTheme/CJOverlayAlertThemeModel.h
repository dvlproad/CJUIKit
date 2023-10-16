//
//  CJOverlayAlertThemeModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CJAlertThemeModel : NSObject {
    
}
@property (nonatomic, assign) CGFloat alertWidth;

@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *textFieldBackgroundColor;

// alert 竖直上的间距:alertMarginVertical
@property (nonatomic, strong) NSArray *marginVertical_title_buttons;
@property (nonatomic, strong) NSArray *marginVertical_title_message_buttons;
@property (nonatomic, strong) NSArray *marginVertical_message_buttons;
@property (nonatomic, strong) NSArray *marginVertical_flagImage_title_message_buttons;
@property (nonatomic, strong) NSArray *marginVertical_title_textField_buttons;

// alert 水平上的左间距:LeftOffset
@property (nonatomic, assign) CGFloat titleLabelLeftOffset;
@property (nonatomic, assign) CGFloat messageLabelLeftOffset;

@property (nonatomic, assign, readonly) BOOL isSpaceButtons;
@property (nonatomic, assign, readonly) CGFloat actionButtonHeight;
// 以下几个字段 当且仅当shouldSpaceButtons为YES时候才可外部设置
@property (nonatomic, assign, readonly) CGFloat actionButtonCornerRadius;
@property (nonatomic, assign, readonly) CGFloat actionButtonBorderWidth;
@property (nonatomic, assign, readonly) CGFloat bottomButtonsLeftOffset;
@property (nonatomic, assign, readonly) CGFloat bottomButtonsFixedSpacing;


- (instancetype)initWithCloseWithActionButtonHeight:(CGFloat)actionButtonHeight;

- (instancetype)initWithSpaceWithActionButtonHeight:(CGFloat)actionButtonHeight
                           actionButtonCornerRadius:(CGFloat)actionButtonCornerRadius
                            actionButtonBorderWidth:(CGFloat)actionButtonBorderWidth
                            bottomButtonsLeftOffset:(CGFloat)bottomButtonsLeftOffset
                          bottomButtonsFixedSpacing:(CGFloat)bottomButtonsFixedSpacing;






@end
