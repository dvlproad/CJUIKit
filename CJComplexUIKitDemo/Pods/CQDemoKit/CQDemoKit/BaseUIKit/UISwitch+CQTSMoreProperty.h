//
//  UISwitch+CQTSMoreProperty.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UISwitch (CQTSMoreProperty)

@property (nonatomic, copy) void (^cqtsValueChangedBlock)(UISwitch *bSwitch);   /**< 设置switch开关值变化时候的回调事件 */

@end

NS_ASSUME_NONNULL_END
