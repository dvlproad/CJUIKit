//
//  CJTextView.h
//  CJTextView
//
//  Created by dvlproad on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJTextView : UITextView

@property (nonatomic, strong) NSString *placeholder;        /**< 占位文字 */
@property (nonatomic, strong) UIColor *placeholderColor;    /**< 占位文字颜色 */
@property (nonatomic, assign) NSUInteger cornerRadius;      /**< 设置圆角 */

/**
 *  设置文本框最大行数 及 监听文本框文字高度改变
 *
 *  @param maxNumberOfLines         textView的最大行数
 *  @param textHeightChangeBlock    文字高度改变block（文字高度改变会自动调用）
 *  block参数(text) → 文字内容
 *  block参数(textHeight) → 文字高度
 */
- (void)setMaxNumberOfLines:(NSUInteger)maxNumberOfLines textHeightChangeBlock:(void(^)(NSString *text,CGFloat textHeight))textHeightChangeBlock;

@end
