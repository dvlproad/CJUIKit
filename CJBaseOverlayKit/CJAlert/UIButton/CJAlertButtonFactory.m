//
//  CJAlertButtonFactory.m
//  CJUIKitDemo
//
//  Created by lcQian on 2020/1/31.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CJAlertButtonFactory.h"
#import "UIButton+CJAlertProperty.h"

#import "CJBaseOverlayThemeManager.h"

@implementation CJAlertButtonFactory

/*
/// 以主题色为背景的按钮
+ (UIButton *)themeBGButton {
    UIColor *themeColor = [CJBaseOverlayThemeManager serviceThemeModel].themeColor;
    UIColor *themeDisabledColor = [CJBaseOverlayThemeManager serviceThemeModel].themeDisabledColor;
    UIColor *themeOppositeColor = [CJBaseOverlayThemeManager serviceThemeModel].themeOppositeColor;
    CGFloat buttonCornerRadius = [CJBaseOverlayThemeManager serviceThemeModel].buttonThemeModel.cornerRadius;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = buttonCornerRadius;
    
    [button setTitleColor:themeOppositeColor forState:UIControlStateNormal];
    button.cjNormalBGColor = themeColor;
    button.cjDisabledBGColor = themeDisabledColor;
    
    return button;
}

///以主题色为边框的按钮
+ (UIButton *)themeBorderButton {
    UIColor *themeColor = [CJBaseOverlayThemeManager serviceThemeModel].themeColor;
    UIColor *themeOppositeColor = [CJBaseOverlayThemeManager serviceThemeModel].themeOppositeColor;
    UIColor *themeOppositeDisabledColor = [CJBaseOverlayThemeManager serviceThemeModel].themeOppositeDisabledColor;
    CGFloat buttonCornerRadius = [CJBaseOverlayThemeManager serviceThemeModel].buttonThemeModel.cornerRadius;
    CGFloat buttonSelectedBorderWidth = [CJBaseOverlayThemeManager serviceThemeModel].buttonThemeModel.selectedBorderWidth;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = buttonCornerRadius;
    button.layer.borderWidth = buttonSelectedBorderWidth;
    button.layer.borderColor = themeColor.CGColor;
    
    [button setTitleColor:themeColor forState:UIControlStateNormal];
    button.cjNormalBGColor = themeOppositeColor;
    button.cjDisabledBGColor = themeOppositeDisabledColor;
    
    return button;
}
 */

+ (UIButton *)__okButtonWithOKButtonTitle:(NSString *)okButtonTitle
                                 okHandle:(void(^)(UIButton *button))okHandle
{
    UIColor *okButtonEnableTitleColor = [CJBaseOverlayThemeManager serviceThemeModel].themeColor;
    UIColor *okButtondisableTitleColor = [CJBaseOverlayThemeManager serviceThemeModel].themeDisabledColor;
    
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
    
//    okButton.layer.masksToBounds = YES;
//    okButton.layer.cornerRadius = 16;
    
    return okButton;
}

+ (UIButton *)__cancelButtonWithCancelButtonTitle:(NSString *)cancelButtonTitle
                                     cancelHandle:(void(^)(UIButton *button))cancelHandle
{
    UIColor *cancelButtonEnableTitleColor = [CJBaseOverlayThemeManager serviceThemeModel].text666Color;
//    UIColor *cancelButtondisableTitleColor = [CJBaseOverlayThemeManager serviceThemeModel].text666Color, 0.6);
    
    UIButton *cancelButton = [self __okButtonWithOKButtonTitle:cancelButtonTitle okHandle:cancelHandle];
    [cancelButton setTitleColor:cancelButtonEnableTitleColor forState:UIControlStateNormal];
//    [cancelButton setTitleColor:cancelButtondisableTitleColor forState:UIControlStateDisabled];
    
    return cancelButton;
}

/*
+ (UIButton *)__spaceOKButtonWithOKButtonTitle:(NSString *)okButtonTitle
                                 okHandle:(void(^)(UIButton *button))okHandle
{
    UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [okButton setTitleColor:CJColorFromHexString(@"#FFFFFF") forState:UIControlStateNormal];
    okButton.cjNormalBGColor = CJColorFromHexString(@"#2F7DE1");
    okButton.layer.masksToBounds = YES;
    okButton.layer.cornerRadius = 16;
    [okButton setTitle:okButtonTitle forState:UIControlStateNormal];
    okButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [okButton setCjTouchUpInsideBlock:okHandle];
    
    return okButton;
}

+ (UIButton *)__sapceCancelButtonWithCancelButtonTitle:(NSString *)cancelButtonTitle
                                     cancelHandle:(void(^)(UIButton *button))cancelHandle
{
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitleColor:CJColorFromHexString(@"#2F7DE1") forState:UIControlStateNormal];
    cancelButton.cjNormalBGColor = CJColorFromHexString(@"#FFFFFF");
    cancelButton.layer.cornerRadius = 16;
    cancelButton.layer.borderWidth = 1;
    cancelButton.layer.borderColor = CJColorFromHexString(@"#2F7DE1").CGColor;
    [cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [cancelButton setCjTouchUpInsideBlock:cancelHandle];
    
    return cancelButton;
}
*/

@end
