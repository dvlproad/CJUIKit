//
//  CJAlertButtonFactory.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/1/31.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CJAlertButtonFactory.h"
#import "UIButton+CJAlertProperty.h"

#import "CJBaseOverlayThemeManager.h"

@implementation CJAlertButtonFactory

#pragma mark - OK Button
+ (UIButton *)okButtonWithTitle:(NSString *)okButtonTitle
                         handle:(void(^)(UIButton *button))okHandle
{
    UIColor *okButtonEnableTitleColor = [CJBaseOverlayThemeManager serviceThemeModel].commonThemeModel.themeColor;
    UIColor *okButtondisableTitleColor = [CJBaseOverlayThemeManager serviceThemeModel].commonThemeModel.themeDisabledColor;
    
    
    UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [okButton setTitleColor:okButtonEnableTitleColor forState:UIControlStateNormal];
    [okButton setTitleColor:okButtondisableTitleColor forState:UIControlStateDisabled];
//    okButton.cjNormalBGColor = [UIColor clearColor];
//    okButton.cjHighlightedBGColor = [UIColor clearColor];
//    okButton.cjDisabledBGColor = [UIColor clearColor];
    UIImage *normalBGImage = cjbaseoverlay_buttonBGImage([UIColor clearColor]);
    [okButton setBackgroundImage:normalBGImage forState:UIControlStateNormal];
    UIImage *highlightedBGImage = cjbaseoverlay_buttonBGImage([UIColor clearColor]);
    [okButton setBackgroundImage:highlightedBGImage forState:UIControlStateHighlighted];
    UIImage *disabledBGImage = cjbaseoverlay_buttonBGImage([UIColor clearColor]);
    [okButton setBackgroundImage:disabledBGImage forState:UIControlStateNormal | UIControlStateDisabled];
    
    [okButton setTitle:okButtonTitle forState:UIControlStateNormal];
    okButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [okButton setCjTouchUpInsideBlock:okHandle];
    
    CJAlertThemeModel *alertThemeModel = [CJBaseOverlayThemeManager serviceThemeModel].alertThemeModel;
    okButton.layer.masksToBounds = YES;
    okButton.layer.cornerRadius = alertThemeModel.actionButtonCornerRadius;
    okButton.layer.borderWidth = alertThemeModel.actionButtonBorderWidth;
    
    
    return okButton;
}


#pragma mark - Cancel Button
+ (UIButton *)cancelButtonWithTitle:(NSString *)cancelButtonTitle
                             handle:(void(^)(UIButton *button))cancelHandle
{
    UIColor *cancelButtonEnableTitleColor = [CJBaseOverlayThemeManager serviceThemeModel].commonThemeModel.text666Color;
//    UIColor *cancelButtondisableTitleColor = [CJBaseOverlayThemeManager serviceThemeModel].text666Color, 0.6);
    
    UIButton *cancelButton = [self okButtonWithTitle:cancelButtonTitle handle:cancelHandle];
    [cancelButton setTitleColor:cancelButtonEnableTitleColor forState:UIControlStateNormal];
//    [cancelButton setTitleColor:cancelButtondisableTitleColor forState:UIControlStateDisabled];
    
    return cancelButton;
}


@end
