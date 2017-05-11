//
//  UITextField+CJLimitTextLength.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

//限制textField的长度
@interface UITextField (CJLimitTextLength)

/**
 *  设置限制的最大长度
 *
 *  @param length               允许输入的最大长度
 */
- (void)cj_limitTextLength:(int)length;

/**
 *  设置限制的最大长度
 *
 *  @param length               允许输入的最大长度
 *  @param limitCompleteBlock   超过限制的长度时候要执行的方法
 */
- (void)cj_limitTextLength:(int)length withLimitCompleteBlock:(void(^)(void))limitCompleteBlock;

@end
