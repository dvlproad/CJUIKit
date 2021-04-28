//
//  CQTSSuspendWindowFactory.h
//  CQDemoKit
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQTSSuspendWindowFactory : NSObject {
    
}

/*
 *  显示按钮样式的悬浮视图
 *
 *  @param buttonTitle              按钮的大小
 *  @param buttonTitle              按钮的标题
 *  @param buttonClickCompleteBlock 点击按钮后执行的动作（已内置执行悬浮视图消失）
 *
 *  @return 悬浮视图
 */
+ (UIWindow *)showSuspendButtonWithSize:(CGSize)size
                                  title:(NSString *)buttonTitle
                      clickCompleteBlock:(void(^ _Nullable)(void))buttonClickCompleteBlock;

@end

NS_ASSUME_NONNULL_END
