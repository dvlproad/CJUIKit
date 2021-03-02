//
//  UITextInputHeightCJHelper.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//
//  文本输入高度计算的帮助方法

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextInputHeightCJHelper : NSObject {
    
}
#pragma mark - 文本在TextView中的所占高度
/*
 *  计算文本在TextView中的所占高度(假设最大宽可以maxWidth)
 *
 *  @param text         要计算的文本
 *  @param maxWidth     最大宽可以maxWith
 *  @param font         字符串的字体大小font
 *
 *  @return 文本/富文本大小
 */
+ (CGFloat)textHeightInTextViewForText:(NSString *)text ithMaxWidth:(CGFloat)maxWidth font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
