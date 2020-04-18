//
//  CJOverlayAlertThemeModel.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJOverlayAlertThemeModel.h"

@implementation CJAlertThemeModel

- (instancetype)initWithCloseWithActionButtonHeight:(CGFloat)actionButtonHeight {
    self = [super init];
    if (self) {
        _isSpaceButtons = NO;
        _actionButtonHeight = actionButtonHeight;
        _actionButtonCornerRadius = 0;
        _actionButtonBorderWidth = 0;
        _bottomButtonsLeftOffset = 0;
        _bottomButtonsFixedSpacing = 1;
        
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithSpaceWithActionButtonHeight:(CGFloat)actionButtonHeight
                           actionButtonCornerRadius:(CGFloat)actionButtonCornerRadius
                            actionButtonBorderWidth:(CGFloat)actionButtonBorderWidth
                            bottomButtonsLeftOffset:(CGFloat)bottomButtonsLeftOffset
                          bottomButtonsFixedSpacing:(CGFloat)bottomButtonsFixedSpacing
{
    self = [super init];
    if (self) {
        _isSpaceButtons = YES;
        _actionButtonHeight = actionButtonHeight;
        _actionButtonCornerRadius = actionButtonCornerRadius;
        _actionButtonBorderWidth = actionButtonBorderWidth;
        _bottomButtonsLeftOffset = bottomButtonsLeftOffset;
        _bottomButtonsFixedSpacing = bottomButtonsFixedSpacing;
        
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    // Alert的默认主题
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    _alertWidth = screenWidth - 2*60;
    
    _backgroundColor = [UIColor whiteColor];  // (@"#FFFFFF");
    _textFieldBackgroundColor = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1.0];  // (@"#F1F1F1");
    
    // alert 水平上的左间距:LeftOffset
    _titleLabelLeftOffset    = 20;
    _messageLabelLeftOffset  = 20;
    
    // alert 竖直上的间距:alertMarginVertical
    _marginVertical_flagImage_title_message_buttons  = @[@20, @20, @10, @20, @0];
    _marginVertical_title_message_buttons            = @[@20, @10, @20, @0];
    _marginVertical_title_buttons                    = @[@30, @30, @0];
    _marginVertical_message_buttons                  = @[@30, @30, @0];
    
    _marginVertical_title_textField_buttons          = @[@30, @30, @30, @0];
}


@end
