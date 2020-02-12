//
//  CJButtonFactory.m
//  CJUIKitDemo
//
//  Created by lcQian on 2020/1/31.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CJButtonFactory.h"
#import "UIButton+CJMoreProperty.h"
#import "UIColor+CJHex.h"

#import "CJThemeManager.h"

@implementation CJButtonFactory

/// 以主题色为背景的按钮
+ (UIButton *)themeBGButton {
    UIColor *themeColor = CJColorFromHexString([CJThemeManager serviceThemeModel].themeColor);
    UIColor *themeDisabledColor = CJColorFromHexString([CJThemeManager serviceThemeModel].themeDisabledColor);
    UIColor *themeOppositeColor = CJColorFromHexString([CJThemeManager serviceThemeModel].themeOppositeColor);
    CGFloat buttonCornerRadius = [CJThemeManager serviceThemeModel].buttonThemeModel.cornerRadius;
    
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
    UIColor *themeColor = CJColorFromHexString([CJThemeManager serviceThemeModel].themeColor);
    UIColor *themeOppositeColor = CJColorFromHexString([CJThemeManager serviceThemeModel].themeOppositeColor);
    UIColor *themeOppositeDisabledColor = CJColorFromHexString([CJThemeManager serviceThemeModel].themeOppositeDisabledColor);
    CGFloat buttonCornerRadius = [CJThemeManager serviceThemeModel].buttonThemeModel.cornerRadius;
    CGFloat buttonSelectedBorderWidth = [CJThemeManager serviceThemeModel].buttonThemeModel.selectedBorderWidth;
    
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

/// 有状态切换的按钮
+ (CJButton *)themeNormalSelectedButton {
    UIColor *themeColor = CJColorFromHexString([CJThemeManager serviceThemeModel].themeColor);
    UIColor *themeDisabledColor = CJColorFromHexString([CJThemeManager serviceThemeModel].themeDisabledColor);
    UIColor *themeOppositeColor = CJColorFromHexString([CJThemeManager serviceThemeModel].themeOppositeColor);
    UIColor *themeOppositeDisabledColor = CJColorFromHexString([CJThemeManager serviceThemeModel].themeOppositeDisabledColor);
    CGFloat buttonCornerRadius = [CJThemeManager serviceThemeModel].buttonThemeModel.cornerRadius;
    CGFloat buttonSelectedBorderWidth = [CJThemeManager serviceThemeModel].buttonThemeModel.selectedBorderWidth;
    
    CJButton *button = [CJButton buttonWithType:UIButtonTypeCustom];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = buttonCornerRadius;
    button.cjNormalBorderWidth = 0;
    button.cjSelectedBorderWidth = buttonSelectedBorderWidth;
    
    [button setTitleColor:themeOppositeColor forState:UIControlStateNormal];
//    [button setTitleColor:themeOppositeColor forState:UIControlStateNormal | UIControlStateDisabled];
    button.cjNormalBGColor = themeColor;
    button.cjNormalBorderColor = themeColor;
    button.cjDisabledBGColor = themeDisabledColor;
    button.cjDisabledBorderColor = themeDisabledColor;
    
    [button setTitleColor:themeColor forState:UIControlStateSelected];
//    [button setTitleColor:themeColor forState:UIControlStateSelected | UIControlStateNormal];
    [button setTitleColor:themeDisabledColor forState:UIControlStateSelected | UIControlStateDisabled];
    button.cjSelectedBGColor = themeOppositeColor;
    button.cjSelectedBorderColor = themeColor;
    button.cjSelectedDisabledBGColor = themeOppositeDisabledColor;
    button.cjSelectedDisabledBorderColor = themeDisabledColor;
    
    return button;
}


@end
