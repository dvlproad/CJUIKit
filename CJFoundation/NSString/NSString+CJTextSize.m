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
- (CGFloat)cjTextHeightWithFont:(UIFont *)textFont maxTextWidth:(CGFloat)maxTextWidth {
    return [self cjTextSizeWithFont:textFont
                            maxSize:CGSizeMake(maxTextWidth, MAXFLOAT)
                               mode:NSLineBreakByWordWrapping].height;
}

/** 完整的描述请参见文件头部 */
- (CGFloat)cjTextWidthWithFont:(UIFont *)textFont maxTextHeight:(CGFloat)maxTextHeight {
    return [self cjTextSizeWithFont:textFont
                            maxSize:CGSizeMake(MAXFLOAT, maxTextHeight)
                               mode:NSLineBreakByWordWrapping].width;
}

- (CGSize)cjTextSizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize mode:(NSLineBreakMode)mode
{
    if (self.length == 0) {
        return CGSizeZero;
    }
    
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = mode;
        NSDictionary *attributes = @{NSFontAttributeName:           font,
                                     NSParagraphStyleAttributeName: paragraphStyle};
        
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
        return [self sizeWithFont:font constrainedToSize:maxSize lineBreakMode:mode];
#pragma clang diagnostic push
    }
}

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
