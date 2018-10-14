//
//  DemoButtonFactory.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/3.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "DemoButtonFactory.h"

@implementation DemoButtonFactory

+ (DemoButtonFactory *)sharedInstance {
    static DemoButtonFactory *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

///蓝色背景按钮
+ (UIButton *)blueButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 15;
    
    /*
    button.tag = 6666;
    [button setBackgroundColor:CJColorFromHexString(@"#01adfe")];
    NSObject *observer = [DemoButtonFactory sharedInstance];
    [button addObserver:observer forKeyPath:@"highlighted" options:NSKeyValueObservingOptionNew context:nil];
    //*/
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
    
    /*
    button.tag = 7777;
    [button setBackgroundColor:[UIColor whiteColor]];
    NSObject *observer = [DemoButtonFactory sharedInstance];
    [button addObserver:observer forKeyPath:@"highlighted" options:NSKeyValueObservingOptionNew context:nil];
    //*/
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

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([object isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)object;
        if (button.tag == 6666) {
            if ([keyPath isEqualToString:@"highlighted"]) {
                if (button.highlighted) {
                    [button setBackgroundColor:CJColorFromHexString(@"#1393d7")];
                } else {
                    [button setBackgroundColor:CJColorFromHexString(@"#01adfe")];
                }
            }
            
        } else if (button.tag == 7777) {
            if ([keyPath isEqualToString:@"highlighted"]) {
                if (button.highlighted) {
                    [button setBackgroundColor:CJColorFromHexString(@"#e5e5e5")];
                } else {
                    [button setBackgroundColor:[UIColor whiteColor]];
                }
            }
        }
        
    }
}


+ (void)removeObserveForButton:(UIButton *)button {
    [button removeObserver:[DemoButtonFactory sharedInstance] forKeyPath:@"highlighted"];
}

@end
