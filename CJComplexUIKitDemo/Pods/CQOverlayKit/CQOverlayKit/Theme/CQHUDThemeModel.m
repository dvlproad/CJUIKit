//
//  CQHUDThemeModel.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CQHUDThemeModel.h"

@implementation CQHUDThemeModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _animationNamed = @"loading_default";
        _animationBundle = [CQHUDThemeModel currentHUDBundle];
    }
    return self;
}

/*
*  设置HUD加载动画对应的json文件名
*
*  @param animationNamed    动画对应的json文件名
*  @param animationBundle   动画对应的json文件所在的bundle(如果是在MainBundle中，则可直接设为nil)
*/
- (void)updateAnimationNamed:(NSString *)animationNamed animationBundle:(NSBundle *)animationBundle {
    _animationNamed = animationNamed;
    _animationBundle = animationBundle;
}

#pragma mark - Public
/// 库中加载动画的json文件所在的bundle
+ (NSBundle *)currentHUDBundle {
    NSString *refreshResourceBundlePath = [[NSBundle mainBundle] pathForResource:@"CQHUD" ofType:@"bundle"];
    NSBundle *refreshResourceBundle = [NSBundle bundleWithPath:refreshResourceBundlePath];
    return refreshResourceBundle;
}


@end
