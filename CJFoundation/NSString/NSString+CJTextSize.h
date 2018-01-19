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
 *  当宽或高不固定（比如地图应用的中心点地址信息）
 *
 *  @param font     字符串的字体大小font
 *  @param maxSize  字符串允许占用的最大maxSize
 *  @param mode     mode
 *
 *  @return 字符串实际占用的size
 */
- (CGSize)cjTextSizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize mode:(NSLineBreakMode)mode;




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
