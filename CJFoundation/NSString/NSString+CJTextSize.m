//
//  NSString+CJTextSize.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "NSString+CJTextSize.h"

@implementation NSString (CJCalculateSize)

/** 完整的描述请参见文件头部 */
- (CGFloat)cjTextHeightWithFont:(UIFont *)textFont infiniteHeightAndMaxWidth:(CGFloat)maxTextWidth {
    CGSize size = [self cjTextSizeWithFont:textFont
                                   maxSize:CGSizeMake(maxTextWidth, MAXFLOAT)
                            lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat height = ceil(size.height) + 1;
    return height;
}

/** 完整的描述请参见文件头部 */
- (CGFloat)cjTextWidthWithFont:(UIFont *)textFont infiniteWidthAndMaxHeight:(CGFloat)maxTextHeight {
    CGSize size = [self cjTextSizeWithFont:textFont
                                   maxSize:CGSizeMake(MAXFLOAT, maxTextHeight)
                            lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat width = ceil(size.width) + 1;
    return width;
}

/* 完整的描述请参见文件头部 */
- (CGSize)cjTextSizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize lineBreakMode:(NSLineBreakMode)lineBreakMode {
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = lineBreakMode;
    
    CGSize size = [self cjTextSizeWithFont:font maxSize:maxSize lineBreakMode:lineBreakMode paragraphStyle:paragraphStyle];
    return size;
}


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
              paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle
{
    if (self.length == 0) {
        return CGSizeZero;
    }
    
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        if (paragraphStyle == nil) {
            paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
            paragraphStyle.lineBreakMode = lineBreakMode;
        }
        
        NSDictionary *attributes = @{NSParagraphStyleAttributeName: paragraphStyle,
                                     NSFontAttributeName:           font,
                                     //NSForegroundColorAttributeName:textColor
                                     //NSKernAttributeName:           @1.5f       //字体间距
                                     };
        
        NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
        
        CGRect textRect = [self boundingRectWithSize:maxSize
                                             options:options
                                          attributes:attributes
                                             context:nil];
        CGSize size = textRect.size;
        return CGSizeMake(ceil(size.width), ceil(size.height));
    }
    else
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [self sizeWithFont:font constrainedToSize:maxSize lineBreakMode:lineBreakMode];
#pragma clang diagnostic push
    }
}


#pragma mark - <#Section#>
/** 完整的描述请参见文件头部 */
- (CGFloat)cjTextHeightWithFont:(UIFont *)textFont {
    return [self cjTextSizeWithFont:textFont].height;
}

/** 完整的描述请参见文件头部 */
- (CGFloat)cjTextWidthWithFont:(UIFont *)textFont {
    return [self cjTextSizeWithFont:textFont].width;
}


- (CGSize)cjTextSizeWithFont:(UIFont *)font
{
    if (self.length == 0)
        return CGSizeZero;
    if ([self respondsToSelector:@selector(sizeWithAttributes:)])
    {
        CGSize size = [self sizeWithAttributes:@{NSFontAttributeName:font}];
        return CGSizeMake(ceil(size.width), ceil(size.height));
    }
    else
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [self sizeWithFont:font];
#pragma clang diagnostic pop
    }
}

@end
