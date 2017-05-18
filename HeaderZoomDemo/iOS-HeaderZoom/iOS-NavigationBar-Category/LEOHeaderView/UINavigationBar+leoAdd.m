//
//  UINavigationBar+Color.m
//  iOS-NavigationBar-Category
//
//  Created by 雷亮 on 16/7/29.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "UINavigationBar+leoAdd.h"
#import <objc/message.h>

@interface UINavigationBar ()

@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation UINavigationBar (leoAdd)

LEOSYNTH_DYNAMIC_PROPERTY_OBJECT(backgroundView, setBackgroundView, RETAIN_NONATOMIC, UIView *)

- (void)leo_setBackgroundColor:(UIColor *)color {
    if (!self.backgroundView) {
        [self setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        
        self.backgroundView = [[UIView alloc] init];
        self.backgroundView.frame = CGRectMake(0, -20, self.bounds.size.width, 20 + self.bounds.size.height);
        [self insertSubview:self.backgroundView atIndex:0];
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.backgroundView.userInteractionEnabled = NO;
    }
    self.backgroundView.backgroundColor = color;
}

- (void)leo_removeUnderline {
    [self setShadowImage:[[UIImage alloc] init]];
}

@end
