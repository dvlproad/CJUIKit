//
//  UIButton+CQTSMoreProperty.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (CQTSMoreProperty)

@property (nonatomic, copy) void (^cqtsTouchUpInsideBlock)(UIButton *bButton);   /**< 设置按钮操作的事件 */

@end

NS_ASSUME_NONNULL_END
