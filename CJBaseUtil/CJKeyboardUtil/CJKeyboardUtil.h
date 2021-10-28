//
//  CJKeyboardUtil.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2017/1/18.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJKeyboardUtil : NSObject {
    
}
@property (nonatomic, copy) void (^keyboardWillChangeFrameBlock)(CGFloat keyboardHeight);   /**< 键盘大小即将变化的回调 */

///注册键盘通知
- (void)registerKeyboardNotifications;

///取消注册键盘通知
- (void)unregisterKeyboardNotifications;


@end

NS_ASSUME_NONNULL_END
