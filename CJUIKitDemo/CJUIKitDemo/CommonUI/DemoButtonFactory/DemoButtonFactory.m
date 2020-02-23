//
//  DemoButtonFactory.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/3.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "DemoButtonFactory.h"
#import "UIImage+CJCreate.h"
#import "UIButton+CJStructure.h"

@implementation DemoButtonFactory

///蓝色背景按钮
+ (UIButton *)blueButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 15;

    button.cjNormalBGColor = CJColorFromHexString(@"#01adfe");
    button.cjHighlightedBGColor = CJColorFromHexString(@"#1393d7");
    button.cjDisabledBGColor = CJColorFromHexString(@"#d3d3d5");
    
    return button;
}

///红色背景按钮
+ (UIButton *)redButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 15;
    
    button.cjNormalBGColor = CJColorFromHexString(@"#01adfe");
    button.cjHighlightedBGColor = CJColorFromHexString(@"#1393d7");
    button.cjDisabledBGColor = CJColorFromHexString(@"#d3d3d5");
    
    return button;
}

///白色背景按钮
+ (UIButton *)whiteButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 15;
    button.layer.borderWidth = 0.6;
    button.layer.borderColor = CJColorFromHexString(@"#d2d2d2").CGColor;
    [button setTitleColor:CJColorFromHexString(@"#d2d2d2") forState:UIControlStateNormal];
    
    button.cjNormalBGColor = CJColorFromHexString(@"#ffffff");
    button.cjHighlightedBGColor = CJColorFromHexString(@"#e5e5e5");
    button.cjDisabledBGColor = CJColorFromHexString(@"#d3d3d5");
    
    return button;
}

///倒计时按钮
+ (UIButton *)timerButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5;
    [button setTitleColor:CJColorFromHexString(@"#ffffff") forState:UIControlStateNormal];
    [button setTitleColor:CJColorFromHexString(@"#01adfe") forState:UIControlStateDisabled];
    
    button.cjNormalBGColor = CJColorFromHexString(@"#01adfe");
    button.cjHighlightedBGColor = CJColorFromHexString(@"#1393d7");
    button.cjDisabledBGColor = CJColorFromHexString(@"#ffffff");
    
    return button;
}

+ (UIButton *)disableButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 15;
    button.layer.borderWidth = 0.6;
    button.layer.borderColor = CJColorFromHexString(@"#d2d2d2").CGColor;
    [button setTitleColor:CJColorFromHexString(@"#d2d2d2") forState:UIControlStateNormal];
    
    button.cjNormalBGColor = CJColorFromHexString(@"#ffffff");
    button.cjHighlightedBGColor = CJColorFromHexString(@"#e5e5e5");
    
    return button;
}

/// 测试用的"上图片+下文字"按钮
+ (UIButton *)upImage_downText_testButton {
    UIButton *button = [self __testImageAndTextButton];
    [button setTitle:@"上图下字按钮" forState:UIControlStateNormal];
    
    return button;
}

/// 测试用的"左图片+右文字"按钮
+ (UIButton *)leftImage_rightText_testButton {
    UIButton *button = [self __testImageAndTextButton];
    [button setTitle:@"左图右字按钮" forState:UIControlStateNormal];
    [button cjLeftImageOffset:10 imageAndTitleSpacing:10];
    
    return button;
}

/// 测试用的"左文字+右图片"按钮
+ (UIButton *)leftText_rightImage_testButton {
    UIButton *button = [self __testImageAndTextButton];
    [button setTitle:@"左字右图按钮" forState:UIControlStateNormal];
    [button cjLeftTextRightImageWithSpacing:10 rightOffset:10];
    
    return button;
}


/// 测试用的"图片+文字"按钮
+ (UIButton *)__testImageAndTextButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 15;

    button.cjNormalBGColor = CJColorFromHexString(@"#01adfe");
    button.cjHighlightedBGColor = CJColorFromHexString(@"#1393d7");
    button.cjDisabledBGColor = CJColorFromHexString(@"#d3d3d5");
    
    UIImage *image = [[UIImage cj_imageWithColor:[UIColor redColor] size:CGSizeMake(30, 30)] cj_circleImage];
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:@"上图下字按钮" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button.imageView setBackgroundColor:[UIColor greenColor]]; //为了方便查看imageView的范围
    [button.titleLabel setBackgroundColor:[UIColor yellowColor]]; //为了方便查看titleLabel的范围
    
    return button;
}


+ (CJBadgeButton *)defaultBadgeButton {
    CJBadgeButton *badgeButton = [CJBadgeButton buttonWithType:UIButtonTypeCustom];
    badgeButton.badgeLabel.backgroundColor = [UIColor redColor];
    badgeButton.badgeLabel.textColor = [UIColor whiteColor];
    badgeButton.layer.cornerRadius = 10;
    
    return badgeButton;
}

+ (CJBadgeButton *)goDeliverBadgeButton {
    CJBadgeButton *badgeButton = [CJBadgeButton buttonWithType:UIButtonTypeCustom];
    badgeButton.backgroundColor = [UIColor cyanColor];
    badgeButton.badgeLabel.backgroundColor = [UIColor redColor];
    badgeButton.badgeLabel.textColor = [UIColor whiteColor];
    badgeButton.badgeLabel.font = [UIFont boldSystemFontOfSize:17];
    badgeButton.badgeLabel.layer.cornerRadius = 3;
    badgeButton.badgeLabelTop = 5;
    badgeButton.badgeLabelRight = 0;
    badgeButton.badgeLabelWidth = 40;
    badgeButton.badgeLabelHeight = 23;
    [badgeButton setImage:[UIImage imageNamed:@"badgeButton_normal"] forState:UIControlStateNormal];
    [badgeButton setImage:[UIImage imageNamed:@"badgeButton_highlighted"] forState:UIControlStateHighlighted];
    badgeButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [badgeButton setTitleEdgeInsets:UIEdgeInsetsMake(44, -104, 0, 0)];
    
    return badgeButton;
}

@end
