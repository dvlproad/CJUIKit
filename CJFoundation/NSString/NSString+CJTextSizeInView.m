//
//  NSString+CJTextSizeInView.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "NSString+CJTextSizeInView.h"
#import "NSString+CJTextSize.h"

@implementation NSString (CJTextSizeInView)

#pragma mark - 文本在Label中的所占高度
/*
 *  计算文本在Label中的所占高度(假设最大宽可以maxWidth)
 *
 *  @param maxWidth     最大宽可以maxWidt
 *  @param font         字符串的字体大小font
 *
 *  @return 文本/富文本大小
 */
- (CGFloat)cjTextHeightInLabelWithMaxWidth:(CGFloat)maxWidth font:(UIFont *)font
{
    if (self.length == 0) {
        return 0;
    }
    
    CGSize maxSize = CGSizeMake(maxWidth, MAXFLOAT);
    
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
    NSDictionary *labelAttributesWithFont = [NSString __labelAttributesWithFont:font];
    CGSize textSizeInView = [self cjTextSizeWithAttributes:labelAttributesWithFont maxSize:maxSize];
    
    CGFloat textHeightInLabel = textSizeInView.height + 0;
    
    return textHeightInLabel;
}

+ (NSDictionary *)__labelAttributesWithFont:(UIFont *)font {
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    //paragraphStyle.lineSpacing = 0; // 字体的行间距
    //paragraphStyle.alignment = NSTextAlignmentLeft;
    
    NSDictionary *attributes = @{NSParagraphStyleAttributeName: paragraphStyle,
                                 NSFontAttributeName:           font,
                                 //NSForegroundColorAttributeName:textColor
                                 //NSKernAttributeName:           @0.0f       //字体间距
                                 };
    
    return attributes;
}

#pragma mark - 文本在TextView中的所占高度
/*
 *  计算文本在TextView中的所占高度(假设最大宽可以maxWidth)
 *
 *  @param maxWidth     最大宽可以maxWidt
 *  @param font         字符串的字体大小font
 *
 *  @return 文本/富文本大小
 */
- (CGFloat)cjTextHeightInTextViewWithMaxWidth:(CGFloat)maxWidth font:(UIFont *)font
{
    if (self.length == 0) {
        return 0;
    }
    CGSize maxSize = CGSizeMake(maxWidth, MAXFLOAT);
    
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
    NSDictionary *textViewAttributesWithFont = [NSString __textViewAttributesWithFont:font];
    CGSize textSizeInView = [self cjTextSizeWithAttributes:textViewAttributesWithFont maxSize:maxSize];
    
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


@end
