//
//  UIView+CJShake.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CJShakeType) {
    CJShakeTypeNever = 0,   /** 从来不需要抖动(默认值)   */
    CJShakeTypeMoving,      /** 抖动中   */
    CJShakeTypeEnd,         /** 抖动结束   */
};

/**
 *  UIView的抖动效果
 */
@interface UIView (CJShake) {
    
}
@property (nonatomic, assign) CJShakeType cjShakeType;

/**
*  短暂抖动(常见于密码输入错误)
*/
- (void)cjShake;

/**
 *  持续抖动(常见于拖动操作)
 */
- (void)cjShakeKeeping;

@end
