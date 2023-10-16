//
//  CJAlertButtonFactory.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/1/31.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJAlertButtonFactory : NSObject

#pragma mark - OK Button
+ (UIButton *)okButtonWithTitle:(NSString *)okButtonTitle
                         handle:(void(^)(UIButton *button))okHandle;

#pragma mark - Cancel Button
+ (UIButton *)cancelButtonWithTitle:(NSString *)cancelButtonTitle
                             handle:(void(^)(UIButton *button))cancelHandle;

@end

NS_ASSUME_NONNULL_END
