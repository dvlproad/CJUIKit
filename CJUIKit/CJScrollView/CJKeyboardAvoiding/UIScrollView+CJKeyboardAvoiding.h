//
//  UIScrollView+CJKeyboardAvoiding.h
//  AllScrollViewDemo
//
//  Created by lichq on 8/10/13.
//  Copyright (c) 2013 ciyouzen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UIScrollView (CJKeyboardAvoiding)

@property (nonatomic, assign) CGFloat cjKeyboardAvoidingOffset;  /**< 当键盘会遮挡时候，文本底部离键盘的距离(默认20) */


- (void)cj_registerKeyboardNotifications;
- (void)cj_unRegisterKeyboardNotifications;

@end
