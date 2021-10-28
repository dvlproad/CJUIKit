//
//  CJUIKitConstant.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJUIKitConstant : NSObject {
    
}

/// 屏幕高度
+ (CGFloat)screenWidth;
/// 屏幕高度
+ (CGFloat)screenHeight;
/// 屏幕最大边的长度
+ (CGFloat)screenMaxLength;


/// 是否是全面屏
+ (BOOL)isScreenFull;


/// 屏幕底部高度
+ (CGFloat)screenBottomHeight;
/// 状态栏高度
+ (CGFloat)statusBarHeight;

@end

NS_ASSUME_NONNULL_END
