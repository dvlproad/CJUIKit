//
//  NSString+CJTextSizeInView.h
//  CJFoundationDemo
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//
//  计算在各种视图里所占的大小

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSString (CJTextSizeInView)


#pragma mark - 文本在Label中的所占高度
/*
 *  计算文本在Label中的所占高度(假设最大宽可以maxWidth)
 *
 *  @param maxWidth     最大宽可以maxWidt
 *  @param font         字符串的字体大小font
 *
 *  @return 文本/富文本大小
 */
- (CGFloat)cjTextHeightInLabelWithMaxWidth:(CGFloat)maxWidth font:(UIFont *)font;

#pragma mark - 文本在TextView中的所占高度
/*
 *  计算文本在TextView中的所占高度(假设最大宽可以maxWidth)
 *
 *  @param maxWidth     最大宽可以maxWidt
 *  @param font         字符串的字体大小font
 *
 *  @return 文本/富文本大小
 */
- (CGFloat)cjTextHeightInTextViewWithMaxWidth:(CGFloat)maxWidth font:(UIFont *)font;


#pragma mark - Private Method
+ (NSDictionary *)__labelAttributesWithFont:(UIFont *)font;
+ (NSDictionary *)__textViewAttributesWithFont:(UIFont *)font;



@end
