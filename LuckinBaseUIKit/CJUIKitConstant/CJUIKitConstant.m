//
//  CJUIKitConstant.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJUIKitConstant.h"


@implementation CJUIKitConstant

/// 屏幕高度
+ (CGFloat)screenWidth {
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    return screenWidth;
}

/// 屏幕高度
+ (CGFloat)screenHeight {
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    return screenHeight;
}

/// 屏幕最大边的长度
+ (CGFloat)screenMaxLength {
    CGFloat screenWidth = [self screenWidth];
    CGFloat screenHeight = [self screenHeight];
    CGFloat screenMaxLength = MAX(screenWidth, screenHeight);
    return screenMaxLength;
}

/// 是否是全面屏
+ (BOOL)isScreenFull {
    CGFloat screenHeight = [self screenHeight];
    BOOL isScreenFull = screenHeight >= 812 && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
    return isScreenFull;
}

/// 屏幕底部高度
+ (CGFloat)screenBottomHeight {
    BOOL isScreenFull = [self isScreenFull];
    CGFloat screenBottomHeight = isScreenFull ?  34.0 : 0.0;
    return screenBottomHeight;
}

/// 状态栏高度
+ (CGFloat)statusBarHeight {
    // 导航栏告诉，第一次值无法获取
    //CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    //BOOL isScreenFull = screenHeight >= 812 && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;  // 是否是全面屏
    BOOL isScreenFull = [self isScreenFull];
    CGFloat statusBarHeight = isScreenFull ? 44 : 20;
    
    //CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    //CGFloat statusBarHeight = CGRectGetHeight(statusBarFrame);
    
    return statusBarHeight;
}

@end
