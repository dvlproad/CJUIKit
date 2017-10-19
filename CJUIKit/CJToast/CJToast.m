//
//  CJToast.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJToast.h"

@implementation CJToast

#pragma mark - Only Text
/* 完整的描述请参见文件头部 */
+ (void)shortShowMessage:(NSString *)message
{
    UIView *view = [[UIApplication sharedApplication].delegate window];
    
    [CJToast shortShowMessage:message inView:view];
}

+ (void)shortShowWhiteMessage:(NSString*)message {
    UIView *view = [[UIApplication sharedApplication].delegate window];
    
    [CJToast shortShowWhiteMessage:message inView:view];
}

/* 完整的描述请参见文件头部 */
+ (void)shortShowMessage:(NSString *)message inView:(UIView *)view {
    [self shortShowMessage:message inView:view withLabelTextColor:nil bezelViewColor:nil hideAfterDelay:2.f];
}

/* 完整的描述请参见文件头部 */
+ (void)shortShowWhiteMessage:(NSString *)message inView:(UIView *)view {
    [self shortShowMessage:message inView:view withLabelTextColor:[UIColor whiteColor] bezelViewColor:[UIColor blackColor] hideAfterDelay:2.f];
}

/* 完整的描述请参见文件头部 */
+ (void)shortShowMessage:(NSString *)message
                  inView:(UIView *)view
      withLabelTextColor:(UIColor *)labelTextColor
          bezelViewColor:(UIColor *)bezelViewColor
          hideAfterDelay:(NSTimeInterval)delay
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
        if (labelTextColor) {
            hud.label.textColor = labelTextColor;
        }
        if (bezelViewColor) {
            hud.bezelView.color = bezelViewColor;
        }
        
        
        hud.minSize = CGSizeMake(200, 30);
        
        hud.label.text = message;
        
    } else {
        hud.mode = MBProgressHUDModeCustomView;
        if (labelTextColor) {
            hud.label.textColor = labelTextColor;
        }
        if (bezelViewColor) {
            hud.bezelView.color = bezelViewColor;
        }
        
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
    [hud hideAnimated:YES afterDelay:delay];
}


#pragma mark - Text And Image
+ (void)shortShowError:(NSString *)error toView:(UIView *)view
{
    //NSString *imageName = @"CJToast.bundle/error";
    NSString *imageName = @"CJToast_error.png";
    UIImage *image = [UIImage imageNamed:imageName];
    [self shortShowMessage:error image:image toView:view];
}

+ (void)shortShowSuccess:(NSString *)success toView:(UIView *)view
{
    //NSString *imageName = @"CJToast.bundle/success";
    NSString *imageName = @"CJToast_success.png";
    UIImage *image = [UIImage imageNamed:imageName];
    [self shortShowMessage:success image:image toView:view];
}

/* 完整的描述请参见文件头部 */
+ (void)shortShowMessage:(NSString *)message image:(UIImage *)image toView:(UIView *)view
{
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    hud.customView = [[UIImageView alloc] initWithImage:image]; // 设置图片
    hud.mode = MBProgressHUDModeCustomView; // 再设置模式
    
    hud.removeFromSuperViewOnHide = YES;    // 隐藏时候从父控件中移除
    [hud hideAnimated:YES afterDelay:0.7];  // 0.7秒之后再消失
}

#pragma mark - Text And 菊花
/* 完整的描述请参见文件头部 */
+ (void)showChrysanthemumAndMessage:(NSString *)message
                             toView:(UIView *)view
          withShowingOperationBlock:(void(^)(MBProgressHUD *hud))showingOperationBlock
{
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
    hud.contentColor = [UIColor colorWithRed:0.f green:0.6f blue:0.7f alpha:1.f];
    
    if (message) {
        hud.label.text = message;
    }
    
    if (showingOperationBlock) {
        showingOperationBlock(hud);
    } else {
        [hud hideAnimated:YES afterDelay:2];
    }
}


#pragma mark - HUD
+ (void)showHUDAddedTo:(UIView *)view animated:(BOOL)animated {
    [MBProgressHUD showHUDAddedTo:view animated:animated];
    //TODO:UIActivityIndicatorView
}

+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated {
    return [MBProgressHUD hideHUDForView:view animated:animated];
}




#pragma mark - Private
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
