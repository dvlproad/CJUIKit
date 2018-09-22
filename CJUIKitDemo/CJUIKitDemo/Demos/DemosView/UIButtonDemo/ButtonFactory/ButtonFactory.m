//
//  ButtonFactory.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/3.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "ButtonFactory.h"

#ifdef CJTESTPOD
#import "UIButton+CJMoreProperty.h"
#import "UIColor+CJHex.h"
#else
#import <CJBaseUIKit/UIButton+CJMoreProperty.h>
#import <CJBaseUIKit/UIColor+CJHex.h>
#endif

@implementation ButtonFactory

+ (ButtonFactory *)sharedInstance {
    static ButtonFactory *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

+ (UIButton *)blueButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 15;
    
    /*
    button.tag = 6666;
    [button setBackgroundColor:CJColorFromHexString(@"#01adfe")];
    NSObject *observer = [ButtonFactory sharedInstance];
    [button addObserver:observer forKeyPath:@"highlighted" options:NSKeyValueObservingOptionNew context:nil];
    //*/
    button.cjNormalBGColor = CJColorFromHexString(@"#01adfe");
    button.cjHighlightedBGColor = CJColorFromHexString(@"#1393d7");
    button.cjDisabledBGColor = CJColorFromHexString(@"#d3d3d5");
    
    return button;
}

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
    NSObject *observer = [ButtonFactory sharedInstance];
    [button addObserver:observer forKeyPath:@"highlighted" options:NSKeyValueObservingOptionNew context:nil];
    //*/
    button.cjNormalBGColor = CJColorFromHexString(@"#ffffff");
    button.cjHighlightedBGColor = CJColorFromHexString(@"#e5e5e5");
    button.cjDisabledBGColor = CJColorFromHexString(@"#d3d3d5");
    
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
    [button removeObserver:[ButtonFactory sharedInstance] forKeyPath:@"highlighted"];
}

@end
