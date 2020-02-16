//
//  CJBaseOverlayThemeModel.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJBaseOverlayThemeModel.h"

@implementation CJBaseOverlayThemeModel
/**
 *  总的默认主题
 *
 *  @return 总的默认主题
 */
+ (CJBaseOverlayThemeModel *)defaultThemeModel {
    CJBaseOverlayThemeModel *totalThemeModel = [[CJBaseOverlayThemeModel alloc] init];
    
    totalThemeModel.themeColor = [UIColor colorWithRed:1/255.0f green:173/255.0f blue:254/255.0f alpha:1.0];  // @"#01adfeFF");
    totalThemeModel.themeDisabledColor = [UIColor colorWithRed:1/255.0f green:173/255.0f blue:254/255.0f alpha:0.6];  // (@"#01adfe66");
    totalThemeModel.themeOppositeColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0];  // (@"#FFFFFF");
    totalThemeModel.themeOppositeDisabledColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:0.4];  // (@"#FFFFFF4C");
    
    
    totalThemeModel.separateLineColor = [UIColor colorWithRed:224/255.0f green:224/255.0f blue:224/255.0f alpha:1.0];  // (@"#E5E5E5");
    totalThemeModel.textMainColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];  // (@"#333333");
    totalThemeModel.text666Color = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0];  // (@"#666666");
    totalThemeModel.textAssistColor = [UIColor colorWithRed:144/255.0f green:144/255.0f blue:144/255.0f alpha:1.0];  // (@"#999999");
    totalThemeModel.placeholderTextColor = [UIColor colorWithRed:192/255.0f green:192/255.0f blue:192/255.0f alpha:1.0];  // (@"#CCCCCC");
    
    totalThemeModel.blankBGColor = [UIColor colorWithRed:40/255.0f green:40/255.0f blue:40/255.0f alpha:0.4];  // (@"#28282878");
    totalThemeModel.alertThemeModel = [CJAlertThemeModel defaultAlertThemeModel];
    
    return totalThemeModel;
}

@end


@implementation CJAlertThemeModel

- (instancetype)initWithCloseWithActionButtonHeight:(CGFloat)actionButtonHeight {
    self = [super init];
    if (self) {
        _isSpaceButtons = NO;
        _actionButtonHeight = actionButtonHeight;
        _bottomButtonsLeftOffset = 0;
        _bottomButtonsFixedSpacing = 1;
    }
    return self;
}

- (instancetype)initWithSpaceWithActionButtonHeight:(CGFloat)actionButtonHeight
                            bottomButtonsLeftOffset:(CGFloat)bottomButtonsLeftOffset
                          bottomButtonsFixedSpacing:(CGFloat)bottomButtonsFixedSpacing
{
    self = [super init];
    if (self) {
        _isSpaceButtons = YES;
        _actionButtonHeight = actionButtonHeight;
        _bottomButtonsLeftOffset = bottomButtonsLeftOffset;
        _bottomButtonsFixedSpacing = _bottomButtonsFixedSpacing;
    }
    return self;
}

/**
 *  Alert的默认主题
 *
 *  @return 默认主题
 */
+ (CJAlertThemeModel *)defaultAlertThemeModel {
//    CJAlertThemeModel *alertThemeModel = [[CJAlertThemeModel alloc] initWithCloseWithActionButtonHeight:45];
    CJAlertThemeModel *alertThemeModel = [[CJAlertThemeModel alloc] initWithSpaceWithActionButtonHeight:45 bottomButtonsLeftOffset:15 bottomButtonsFixedSpacing:10];
    
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    alertThemeModel.alertWidth = screenWidth - 2*60;
    
    alertThemeModel.backgroundColor = [UIColor whiteColor];  // (@"#FFFFFF");
    alertThemeModel.textFieldBackgroundColor = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1.0];  // (@"#F1F1F1");
    
    // alert 水平上的左间距:LeftOffset
    alertThemeModel.titleLabelLeftOffset    = 20;
    alertThemeModel.messageLabelLeftOffset  = 20;
    
    // alert 竖直上的间距:alertMarginVertical
    alertThemeModel.marginVertical_flagImage_title_message_buttons  = @[@20, @20, @10, @20, @0];
    alertThemeModel.marginVertical_title_message_buttons            = @[@20, @10, @20, @0];
    alertThemeModel.marginVertical_title_buttons                    = @[@30, @30, @0];
    alertThemeModel.marginVertical_message_buttons                  = @[@30, @30, @0];
    
    alertThemeModel.marginVertical_title_textField_buttons          = @[@30, @30, @30, @0];
    
    return alertThemeModel;
}

@end
