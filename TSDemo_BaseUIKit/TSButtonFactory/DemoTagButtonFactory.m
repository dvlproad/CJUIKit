//
//  DemoTagButtonFactory.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/3.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "DemoTagButtonFactory.h"

@implementation DemoTagButtonFactory

+ (DemoTagButtonFactory *)sharedInstance {
    static DemoTagButtonFactory *_sharedInstance = nil;
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
    button.cjNormalBGColor = CJColorFromHexString(@"#01adfe");
    button.cjHighlightedBGColor = CJColorFromHexString(@"#1393d7");
    button.cjDisabledBGColor = CJColorFromHexString(@"#d3d3d5");
    //*/
    button.tag = 6666;
    [button setBackgroundColor:CJColorFromHexString(@"#01adfe")];
    NSObject *observer = [DemoTagButtonFactory sharedInstance];
    [button addObserver:observer forKeyPath:@"highlighted" options:NSKeyValueObservingOptionNew context:nil];
    
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
    button.cjNormalBGColor = CJColorFromHexString(@"#ffffff");
    button.cjHighlightedBGColor = CJColorFromHexString(@"#e5e5e5");
    button.cjDisabledBGColor = CJColorFromHexString(@"#d3d3d5");
    //*/
    button.tag = 7777;
    [button setBackgroundColor:[UIColor whiteColor]];
    NSObject *observer = [DemoTagButtonFactory sharedInstance];
    [button addObserver:observer forKeyPath:@"highlighted" options:NSKeyValueObservingOptionNew context:nil];
    
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
    [button removeObserver:[DemoTagButtonFactory sharedInstance] forKeyPath:@"highlighted"];
}

@end
