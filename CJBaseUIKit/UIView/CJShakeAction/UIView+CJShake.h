//
//  UIView+CJShake.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  UIView的抖动效果
 */
@interface UIView (CJShake)

/**
*  短暂抖动(常见于密码输入错误)
*/
- (void)cjShake;

/**
 *  持续抖动(常见于拖动操作)
 */
- (void)cjShakeKeeping;

@end
