//
//  CJUIKitToastUtil.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJUIKitToastUtil.h"

@implementation CJUIKitToastUtil

+ (void)showMessage:(NSString *)message {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [self showToast:message inView:keyWindow];
}

+ (void)showToast:(NSString *)text inView:(UIView *)superView {
    if (superView == nil) {
        superView = [UIApplication sharedApplication].keyWindow;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
    label.textColor = [UIColor whiteColor];
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 10;
    label.font = [UIFont systemFontOfSize:14];
    label.text = text;
    label.numberOfLines = 0;
    
//    [label sizeToFit];
//    CGFloat textWidth = CGRectGetWidth(label.frame);
//    CGFloat textHeight = CGRectGetHeight(label.frame);
    
    CGFloat textWidth = [UIScreen mainScreen].bounds.size.width - 20;
    CGFloat textHeight = [self calculateTextHeightForText:text withFont:label.font infiniteHeightAndMaxWidth:textWidth];
    
    label.frame = CGRectMake(CGRectGetWidth(superView.frame)/2-textWidth/2,
                             CGRectGetHeight(superView.frame)/2-textHeight/2,
                             textWidth,
                             textHeight);
    [superView addSubview:label];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [label removeFromSuperview];
    });
}


//获取字符串高度(假设最大高可以MAXFLOAT)
+ (CGFloat)calculateTextHeightForText:(NSString *)text
                             withFont:(UIFont *)textFont
            infiniteHeightAndMaxWidth:(CGFloat)maxTextWidth
{
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    CGSize size = [self calculateTextSizeForText:text
                                        withFont:textFont
                                         maxSize:CGSizeMake(maxTextWidth, MAXFLOAT)
                                   lineBreakMode:NSLineBreakByWordWrapping
                                  paragraphStyle:paragraphStyle];
    CGFloat height = ceil(size.height) + 1;
    return height;
}

/**
 *  计算文本/富文本大小(假设最大宽高可以maxSize)
 *
 *  @param text             要计算的文本
 *  @param font             字符串的字体大小font
 *  @param maxSize          字符串允许占用的最大maxSize
 *  @param lineBreakMode    lineBreakMode
 *  @param paragraphStyle   paragraphStyle(可以为nil,为nil时候会用默认设置lineBreakMode)
 *
 *  @return 文本/富文本大小
 */
+ (CGSize)calculateTextSizeForText:(NSString *)text
                          withFont:(UIFont *)font
                           maxSize:(CGSize)maxSize
                     lineBreakMode:(NSLineBreakMode)lineBreakMode
                    paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle
{
    if (text.length == 0) {
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
        
        CGRect textRect = [text boundingRectWithSize:maxSize
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
        return [text sizeWithFont:font constrainedToSize:maxSize lineBreakMode:lineBreakMode];
#pragma clang diagnostic push
    }
}

+ (CGSize)calculateTextSizeForText:(NSString *)text withFont:(UIFont *)font
{
    if (text.length == 0)
        return CGSizeZero;
    if ([self respondsToSelector:@selector(sizeWithAttributes:)])
    {
        CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:font}];
        return CGSizeMake(ceil(size.width), ceil(size.height));
    }
    else
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [text sizeWithFont:font];
#pragma clang diagnostic pop
    }
}

@end
