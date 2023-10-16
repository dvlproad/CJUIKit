//
//  CJOverlayTextSizeUtil.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJOverlayTextSizeUtil.h"

@implementation CJOverlayTextSizeUtil

#pragma mark --  size helper
+ (CGSize)sizeOfText:(NSString *)text WithMaxSize:(CGSize)maxSize font:(UIFont *)font {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

//以下获取textSize方法取自NSString+CJTextSize
+ (CGSize)getTextSizeFromString:(NSString *)string
                       withFont:(UIFont *)font
                        maxSize:(CGSize)maxSize
                  lineBreakMode:(NSLineBreakMode)lineBreakMode
                 paragraphStyle:(nullable NSMutableParagraphStyle *)paragraphStyle
{
    if (string.length == 0) {
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
        
        CGRect textRect = [string boundingRectWithSize:maxSize
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
        return [string sizeWithFont:font constrainedToSize:maxSize lineBreakMode:lineBreakMode];
#pragma clang diagnostic push
    }
}


@end
