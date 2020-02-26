//
//  TSButtonFactory.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/1/31.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJButton.h"

/// 文字+图片 按钮 中 图片的位置类型
typedef NS_ENUM(NSUInteger, DemoTextImageButtonLocation) {
    DemoTextImageButtonLocationDefault,
    DemoTextImageButtonLocationLeftImageRightText,  // "左图片+右文字"按钮
    DemoTextImageButtonLocationLeftTextRightImage,  // "左文字+右图片"按钮
    DemoTextImageButtonLocationImageTop,  // "上图片+下文字"按钮
};

NS_ASSUME_NONNULL_BEGIN

@interface TSButtonFactory : NSObject

#pragma mark - 只文字按钮
/// 以主题色为背景的按钮
+ (UIButton *)themeBGButton;

///以主题色为边框的按钮
+ (UIButton *)themeBorderButton;

/// 有状态切换的按钮
+ (CJButton *)themeNormalSelectedButtonWithNormalTitle:(NSString *)normalTitle selectedTitle:(NSString *)selectedTitle;

#pragma mark - 图片文字按钮
/// 测试用的 文字+图片 按钮
+ (UIButton *)textImageButtonWithTitle:(NSString *)title
                                 image:(UIImage *)image
                         imagePosition:(DemoTextImageButtonLocation)location;

@end

NS_ASSUME_NONNULL_END
