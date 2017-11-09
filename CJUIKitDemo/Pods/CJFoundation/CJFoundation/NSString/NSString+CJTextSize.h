//
//  NSString+CJTextSize.h
//  CJFoundationDemo
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 ciyouzen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSString (CJCalculateSize)

/**
 *  获取字符串高度
 *
 *  @param textFont         字符串对应的字体
 *  @param maxTextWidth     字符串最大的宽度
 */
- (CGFloat)cjTextHeightWithFont:(UIFont *)textFont maxTextWidth:(CGFloat)maxTextWidth;

/**
 *  获取字符串宽度
 *
 *  @param textFont         字符串对应的字体
 *  @param maxTextHeight    字符串最大的高度
 */
- (CGFloat)cjTextWidthWithFont:(UIFont *)textFont maxTextHeight:(CGFloat)maxTextHeight;


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
