//
//  UIButton+CJTouchEvent.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CJTouchEvent)

@property (nonatomic, copy) void (^cjTouchEventBlock)(UIButton *button);   /**< 按钮操作的事件 */


@end
