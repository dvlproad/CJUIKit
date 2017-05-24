//
//  UITextField+CJTextChangeBlock.h
//  CJUIKitDemo
//
//  Created by dvlproad on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//
//其他可参考：如何实现UITextField值变化的实时监视http://www.cocoachina.com/bbs/read.php?tid=233583

#import <UIKit/UIKit.h>

/**
 *  可监听文本框文本变化的block（包括在代码中setText以及在文本框视图中输入）
 */
@interface UITextField (CJTextChangeBlock)

@property (nonatomic, copy) void (^cjTextChangeBlock)(UITextField *textField);  /**< 文本改变的通知事件 */

@end
