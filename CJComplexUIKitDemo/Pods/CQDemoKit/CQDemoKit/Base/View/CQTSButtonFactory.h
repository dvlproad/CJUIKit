//
//  CQTSButtonFactory.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/1/31.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQTSButtonFactory : NSObject

#pragma mark - 只文字按钮
/// 以主题色为背景的按钮
+ (UIButton *)themeBGButton;

///以主题色为边框的按钮
+ (UIButton *)themeBorderButton;


@end

NS_ASSUME_NONNULL_END
