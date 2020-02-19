//
//  CJButtonFactory.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/1/31.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJButtonFactory : NSObject

/// 以主题色为背景的按钮
+ (CJButton *)themeBGButton;

///以主题色为边框的按钮
+ (UIButton *)themeBorderButton;

/// 有状态切换的按钮
+ (CJButton *)themeNormalSelectedButton;

@end

NS_ASSUME_NONNULL_END
