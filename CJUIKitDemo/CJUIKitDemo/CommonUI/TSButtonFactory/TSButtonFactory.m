//
//  TSButtonFactory.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/1/31.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "TSButtonFactory.h"
#import "UIColor+CJHex.h"
#import "UIButton+CJMoreProperty.h"
#import "UIButton+CJStructure.h"

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


#pragma mark - 只文字按钮
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
+ (CJButton *)themeNormalSelectedButtonWithNormalTitle:(NSString *)normalTitle selectedTitle:(NSString *)selectedTitle {
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
    
    [button setTitle:normalTitle forState:UIControlStateNormal];
    [button setTitleColor:themeOppositeColor forState:UIControlStateNormal];
//    [button setTitleColor:themeOppositeColor forState:UIControlStateNormal | UIControlStateDisabled];
    button.cjNormalBGColor = themeColor;
    button.cjNormalBorderColor = themeColor;
    button.cjDisabledBGColor = themeDisabledColor;
    button.cjDisabledBorderColor = themeDisabledColor;
    
    [button setTitle:selectedTitle forState:UIControlStateSelected];
    [button setTitleColor:themeColor forState:UIControlStateSelected];
//    [button setTitleColor:themeColor forState:UIControlStateSelected | UIControlStateNormal];
    [button setTitleColor:themeDisabledColor forState:UIControlStateSelected | UIControlStateDisabled];
    button.cjSelectedBGColor = themeOppositeColor;
    button.cjSelectedBorderColor = themeColor;
    button.cjSelectedDisabledBGColor = themeOppositeDisabledColor;
    button.cjSelectedDisabledBorderColor = themeDisabledColor;
    
    return button;
}

#pragma mark - 图片文字按钮
/// 测试用的 文字+图片 按钮
+ (UIButton *)textImageButtonWithTitle:(NSString *)title
                                 image:(UIImage *)image
                         imagePosition:(DemoTextImageButtonLocation)location
{
    UIButton *button = [self __textImageButtonWithTitle:title image:image];
    
    switch (location) {
        case DemoTextImageButtonLocationLeftImageRightText: // "左图片+右文字"按钮
        {
            
            [button cjLeftImageOffset:10 imageAndTitleSpacing:10];
            break;
        }
        case DemoTextImageButtonLocationLeftTextRightImage: // "左文字+右图片"按钮
        {
            [button cjLeftTextRightImageWithSpacing:10 rightOffset:10];
        }
        case DemoTextImageButtonLocationImageTop: // "上图片+下文字"按钮
        {
            [button cjVerticalImageAndTitle:10];
        }
        default:    // 默认是 "左文字+右图片"按钮
        {
            [button cjLeftTextRightImageWithSpacing:10 rightOffset:10];
            break;
        }
    }
    
    return button;
}


#pragma mark - Private Method
/// 测试用的"图片+文字"按钮
+ (UIButton *)__textImageButtonWithTitle:(NSString *)title image:(UIImage *)image {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 15;

    button.cjNormalBGColor = CJColorFromHexString(@"#01adfe");
    button.cjHighlightedBGColor = CJColorFromHexString(@"#1393d7");
    button.cjDisabledBGColor = CJColorFromHexString(@"#d3d3d5");
    
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button.imageView setBackgroundColor:[UIColor greenColor]]; //为了方便查看imageView的范围
    [button.titleLabel setBackgroundColor:[UIColor yellowColor]]; //为了方便查看titleLabel的范围
    
    return button;
}


@end
