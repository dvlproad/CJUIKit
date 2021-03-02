//
//  UITextInputHeightCJHelper.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "UITextInputHeightCJHelper.h"

@implementation UITextInputHeightCJHelper


#pragma mark - Private Method
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
+ (CGFloat)textHeightInTextViewForText:(NSString *)text ithMaxWidth:(CGFloat)maxWidth font:(UIFont *)font
{
    if (text.length == 0) {
        return 0;
    }
    CGSize maxSize = CGSizeMake(maxWidth, MAXFLOAT);
    
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = font;
//    CGSize placeholderSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
//    CGFloat placeholderHeight = placeholderSize.height;
//    return placeholderHeight;
    
    NSDictionary *textViewAttributesWithFont = [self __textViewAttributesWithFont:font];
    CGSize textSizeInView = [self textSizeForText:text withAttributes:textViewAttributesWithFont maxSize:maxSize];
    
    CGFloat textHeightInTextView = textSizeInView.height + 14;
    
    return textHeightInTextView;
}

+ (NSDictionary *)__textViewAttributesWithFont:(UIFont *)font {
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.lineSpacing = 1; // 字体的行间距
//    paragraphStyle.headIndent = 4;
//    paragraphStyle.tailIndent = -4;
    //paragraphStyle.alignment = NSTextAlignmentLeft;
    
    NSDictionary *attributes = @{NSParagraphStyleAttributeName: paragraphStyle,
                                 NSFontAttributeName:           font,
                                 //NSForegroundColorAttributeName:textColor
                                 NSKernAttributeName:           @0.2f       //字体间距
                                 };
    
    return attributes;
}

/*
 *  计算文本/富文本大小(假设最大宽高可以maxSize)
 *
 *  @param text         要计算的文本
 *  @param attributes   字符串各属性（字体font、对齐方式paragraphStyle、行尾方式lineBreakMode）
 *  @param maxSize      字符串允许占用的最大maxSize
 *
 *  @return 文本/富文本大小
 */
+ (CGSize)textSizeForText:(NSString *)text
           withAttributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attributes
                  maxSize:(CGSize)maxSize
{
    if (text.length == 0) {
        return CGSizeZero;
    }
    
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
    
    CGRect textRect = [text boundingRectWithSize:maxSize
                                         options:options
                                      attributes:attributes
                                         context:nil];
    CGSize size = textRect.size;
    return CGSizeMake(ceil(size.width), ceil(size.height));
}

@end
