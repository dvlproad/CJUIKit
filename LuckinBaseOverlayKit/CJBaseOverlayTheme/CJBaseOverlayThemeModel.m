//
//  CJBaseOverlayThemeModel.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJBaseOverlayThemeModel.h"

@implementation CJBaseOverlayThemeModel

- (instancetype)init {
    self = [super init];
    if (self) {
        // 总的默认主题
        _themeColor = [UIColor colorWithRed:1/255.0f green:173/255.0f blue:254/255.0f alpha:1.0];  // @"#01adfeFF");
        _themeDisabledColor = [UIColor colorWithRed:1/255.0f green:173/255.0f blue:254/255.0f alpha:0.6];  // (@"#01adfe66");
        _themeOppositeColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0];  // (@"#FFFFFF");
        _themeOppositeDisabledColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:0.4];  // (@"#FFFFFF4C");
        
        
        _separateLineColor = [UIColor colorWithRed:224/255.0f green:224/255.0f blue:224/255.0f alpha:1.0];  // (@"#E5E5E5");
        _textMainColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];  // (@"#333333");
        _text666Color = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0];  // (@"#666666");
        _textAssistColor = [UIColor colorWithRed:144/255.0f green:144/255.0f blue:144/255.0f alpha:1.0];  // (@"#999999");
        _placeholderTextColor = [UIColor colorWithRed:192/255.0f green:192/255.0f blue:192/255.0f alpha:1.0];  // (@"#CCCCCC");
        
        _blankBGColor = [UIColor colorWithRed:40/255.0f green:40/255.0f blue:40/255.0f alpha:0.4];  // (@"#28282878");
        _alertThemeModel = [[CJAlertThemeModel alloc] initWithCloseWithActionButtonHeight:45];
        //_alertThemeModel = [[CJAlertThemeModel alloc] initWithSpaceWithActionButtonHeight:45 bottomButtonsLeftOffset:15 bottomButtonsFixedSpacing:10];
    }
    return self;
}

@end


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
