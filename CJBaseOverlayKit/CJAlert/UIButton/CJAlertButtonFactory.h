//
//  CJAlertButtonFactory.h
//  CJUIKitDemo
//
//  Created by lcQian on 2020/1/31.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJAlertButtonFactory : NSObject

///// 以主题色为背景的按钮
//+ (UIButton *)themeBGButton;
//
/////以主题色为边框的按钮
//+ (UIButton *)themeBorderButton;

+ (UIButton *)__okButtonWithOKButtonTitle:(NSString *)okButtonTitle
                                 okHandle:(void(^)(UIButton *button))okHandle;

+ (UIButton *)__cancelButtonWithCancelButtonTitle:(NSString *)cancelButtonTitle
                                     cancelHandle:(void(^)(UIButton *button))cancelHandle;


//+ (UIButton *)__spaceOKButtonWithOKButtonTitle:(NSString *)okButtonTitle
//                                      okHandle:(void(^)(UIButton *button))okHandle;
//
//+ (UIButton *)__sapceCancelButtonWithCancelButtonTitle:(NSString *)cancelButtonTitle
//                                          cancelHandle:(void(^)(UIButton *button))cancelHandle;

@end

NS_ASSUME_NONNULL_END
