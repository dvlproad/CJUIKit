//
//  NSString+CJTextSize.h
//  CJFoundationDemo
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSString (CJCalculateSize)

///获取字符串高度(假设最大高可以MAXFLOAT)
- (CGFloat)cjTextHeightWithFont:(UIFont *)textFont infiniteHeightAndMaxWidth:(CGFloat)maxTextWidth;

///获取字符串宽度(假设最大宽可以MAXFLOAT)
- (CGFloat)cjTextWidthWithFont:(UIFont *)textFont infiniteWidthAndMaxHeight:(CGFloat)maxTextHeight;

///计算文本/富文本大小(假设最大宽高可以maxSize)
- (CGSize)cjTextSizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize lineBreakMode:(NSLineBreakMode)lineBreakMode;

/**
 *  计算文本/富文本大小(假设最大宽高可以maxSize)
 *
 *  @param font             字符串的字体大小font
 *  @param maxSize          字符串允许占用的最大maxSize
 *  @param lineBreakMode    lineBreakMode
 *  @param paragraphStyle   paragraphStyle(可以为nil,为nil时候会用默认设置lineBreakMode)
 *
 *  @return 文本/富文本大小
 */
- (CGSize)cjTextSizeWithFont:(UIFont *)font
                     maxSize:(CGSize)maxSize
               lineBreakMode:(NSLineBreakMode)lineBreakMode
              paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle;



#pragma mark - <#Section#>
/**
 *  获取字符串高度
 *
 *  @param textFont         字符串对应的字体
 */
- (CGFloat)cjTextHeightWithFont:(UIFont *)textFont;

/**
 *  获取字符串宽度
 *
 *  @param textFont         字符串对应的字体
 */
- (CGFloat)cjTextWidthWithFont:(UIFont *)textFont;

@end
