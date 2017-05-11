//
//  CJToast.m
//  CJUIKitDemo
//
//  Created by 李超前 on 2017/5/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJToast.h"

@implementation CJToast

#pragma mark - MBProgressHUD

+ (void)showMessage:(NSString *)message
{
    UIView *view = [[UIApplication sharedApplication].delegate window];
    
    [CJToast showMessage:message inView:view];
}

+ (void)showMessage:(NSString *)message inView:(UIView *)view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    CGFloat margin = 10;
    
    hud.userInteractionEnabled = NO;
    hud.removeFromSuperViewOnHide = YES;
    hud.margin = margin;
    
    CGFloat labelMaxWidth = CGRectGetWidth(view.frame) - 4*margin;
    UIFont *hudLabelFont = hud.label.font;
    CGFloat textWidth = [self getTextSizeFromString:message withFont:hudLabelFont].width;
    
    if (textWidth < labelMaxWidth) {
        hud.mode = MBProgressHUDModeText;
        hud.minSize = CGSizeMake(200, 30);
        
        hud.label.text = message;
        
    } else {
        hud.mode = MBProgressHUDModeCustomView;
        
        CGFloat labelWidth = labelMaxWidth;
        CGSize maxSize = CGSizeMake(labelWidth, CGFLOAT_MAX);
        CGSize textSize = [self getTextSizeFromString:message withFont:hudLabelFont maxSize:maxSize mode:NSLineBreakByCharWrapping];
        
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = hudLabelFont;
        label.textColor = hud.label.textColor;
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByCharWrapping;
        
        CGFloat labelHeight = MIN(CGRectGetHeight(view.frame)-4*margin, textSize.height);
        CGRect frame = label.frame;
        frame.size = CGSizeMake(labelWidth, labelHeight);
        label.frame = frame;
        
        label.text = message;
        
        hud.customView = label;
    }
    [hud hideAnimated:YES afterDelay:2.f];
}


//以下两个获取textSize取自NSString+CJTextSize
+ (CGSize)getTextSizeFromString:(NSString *)string withFont:(UIFont *)font
{
    if (string.length == 0)
        return CGSizeZero;
    if ([string respondsToSelector:@selector(sizeWithAttributes:)])
    {
        CGSize size = [string sizeWithAttributes:@{NSFontAttributeName:font}];
        return CGSizeMake(ceil(size.width), ceil(size.height));
    }
    else
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [string sizeWithFont:font];
#pragma clang diagnostic pop
    }
}

+ (CGSize)getTextSizeFromString:(NSString *)string withFont:(UIFont *)font maxSize:(CGSize)maxSize mode:(NSLineBreakMode)mode
{
    if (string.length == 0) {
        return CGSizeZero;
    }
    
    if ([string respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = mode;
        NSDictionary *attributes = @{NSFontAttributeName:           font,
                                     NSParagraphStyleAttributeName: paragraphStyle};
        
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
        return [string sizeWithFont:font constrainedToSize:maxSize lineBreakMode:mode];
#pragma clang diagnostic push
    }
}



@end
