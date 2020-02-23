//
//  TSButtonFactory.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/1/31.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "TSButtonFactory.h"
#import "UIButton+CJMoreProperty.h"
#import "UIColor+CJHex.h"

@interface TSButtonFactory () {
    
}
@property (nonatomic, strong) UIColor *themeColor;
@property (nonatomic, strong) UIColor *themeDisabledColor;
@property (nonatomic, strong) UIColor *themeOppositeColor;
@property (nonatomic, strong) UIColor *themeOppositeDisabledColor;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) CGFloat selectedBorderWidth;

@end

@implementation TSButtonFactory

+ (TSButtonFactory *)sharedInstance {
    static TSButtonFactory *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _themeColor = CJColorFromHexString(@"#01adfeFF");
        _themeDisabledColor = CJColorFromHexString(@"#01adfe66");
        _themeOppositeColor = CJColorFromHexString(@"#FFFFFF");
        _themeOppositeDisabledColor = CJColorFromHexString(@"#FFFFFF4C");

        _cornerRadius = 15;
        _selectedBorderWidth = 0.5;
    }
    return self;
}

/// 以主题色为背景的按钮
+ (UIButton *)themeBGButton {
    UIColor *themeColor = [TSButtonFactory sharedInstance].themeColor;
    UIColor *themeDisabledColor = [TSButtonFactory sharedInstance].themeDisabledColor;
    UIColor *themeOppositeColor = [TSButtonFactory sharedInstance].themeOppositeColor;
    CGFloat buttonCornerRadius = [TSButtonFactory sharedInstance].cornerRadius;
    
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
    UIColor *themeColor = [TSButtonFactory sharedInstance].themeColor;
    UIColor *themeOppositeColor = [TSButtonFactory sharedInstance].themeOppositeColor;
    UIColor *themeOppositeDisabledColor = [TSButtonFactory sharedInstance].themeOppositeDisabledColor;
    CGFloat buttonCornerRadius = [TSButtonFactory sharedInstance].cornerRadius;
    CGFloat buttonSelectedBorderWidth = [TSButtonFactory sharedInstance].selectedBorderWidth;
    
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
    UIColor *themeColor = [TSButtonFactory sharedInstance].themeColor;
    UIColor *themeDisabledColor = [TSButtonFactory sharedInstance].themeDisabledColor;
    UIColor *themeOppositeColor = [TSButtonFactory sharedInstance].themeOppositeColor;
    UIColor *themeOppositeDisabledColor = [TSButtonFactory sharedInstance].themeOppositeDisabledColor;
    CGFloat buttonCornerRadius = [TSButtonFactory sharedInstance].cornerRadius;
    CGFloat buttonSelectedBorderWidth = [TSButtonFactory sharedInstance].selectedBorderWidth;
    
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
