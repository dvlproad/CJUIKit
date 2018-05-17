//
//  UIButton+CJFixMultiClick.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/1/4.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CJFixMultiClick)

@property (nonatomic, assign) NSTimeInterval cjMinClickInterval;    /**< 重复点击的最小间隔 */
@property (nonatomic, assign) NSTimeInterval cjLastClickTimestamp;  /**< 上一次点击的时间戳 */


@end
