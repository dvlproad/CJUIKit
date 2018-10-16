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
    if (message.length == 0) {
        NSLog(@"toast message length == 0");
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    CGFloat margin = 10;
    
    hud.userInteractionEnabled = NO;
    hud.removeFromSuperViewOnHide = YES;
    hud.margin = margin;
    
    CGFloat labelMaxWidth = CGRectGetWidth(view.frame) - 4*margin;
    UIFont *hudLabelFont = hud.label.font;
    CGFloat labelWidth = labelMaxWidth;
    CGSize maxSize = CGSizeMake(labelWidth, CGFLOAT_MAX);
    CGSize textSize = [self getTextSizeFromString:message withFont:hudLabelFont maxSize:maxSize lineBreakMode:NSLineBreakByCharWrapping paragraphStyle:nil];
    
    //由于 MBProgressHUD 的label的numberOfLines为1，所以label只支持单行显示。(附detailsLabel支持多行)
    //情况①当文本太长时候，需要多行显示，所以如果要显示的字符串超过单行最大长度，我们则改为用自定义的label显示；
    //情况②当使用\n时候，一样的道理，也无法显示多行，所以干脆直接放弃到原本的label
//    if (textSize.width < labelMaxWidth) {
//        hud.mode = MBProgressHUDModeText;
//        //hud.label.numberOfLines = 0;
//        if (labelTextColor) {
//            hud.label.textColor = labelTextColor;
//            //hud.detailsLabel.textColor = labelTextColor;
//        }
//        if (bezelViewColor) {
//            hud.bezelView.color = bezelViewColor;
//        }
//
//
//        hud.minSize = CGSizeMake(200, 80);
//
//        hud.label.text = message;
//        //hud.detailsLabel.text = message;
//
//    }
//    else
    {
        hud.mode = MBProgressHUDModeCustomView;
        if (labelTextColor) {
            hud.label.textColor = labelTextColor;
        }
        if (bezelViewColor) {
            hud.bezelView.color = bezelViewColor;
        }
        
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
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
/*
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
*/

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
+ (MBProgressHUD *)createChrysanthemumHUDWithMessage:(NSString *)message
                                              toView:(UIView *)view
{
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
    hud.contentColor = [UIColor whiteColor]; //等待框文字颜色
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.76]; //等待框背景色
    
    if (message) {
        hud.label.text = message;
    }
    
    return hud;
}

///* 完整的描述请参见文件头部 */
//+ (MBProgressHUD *)createChrysanthemumHUDWithRightMessage:(NSString *)message toView:(UIView *)view
//{
//    if (view == nil) {
//        view = [UIApplication sharedApplication].keyWindow;
//    }
//    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    
//    // Set the custom view mode to show any view.
//    hud.mode = MBProgressHUDModeCustomView;
//    // Set an image view with a checkmark.
//    
//    
//    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 200)];
//    customView.backgroundColor = [UIColor redColor];
//    
//    UIImage *image = [[UIImage imageNamed:@"CJToast_success"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100-40/2, 40, 40)];
//    imageView.image = image;
//    [customView addSubview:imageView];
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 100-30/2, 140, 30)];
//    label.backgroundColor = [UIColor orangeColor];
//    label.text = message;
//    label.textAlignment = NSTextAlignmentCenter;
//    [customView addSubview:label];
//   
//    hud.customView = customView;
//    hud.square = YES;
//    hud.label.text = message;
//    
//    return hud;
//}


#pragma mark - HUD
+ (void)showHUDAddedTo:(UIView *)view animated:(BOOL)animated {
    [MBProgressHUD showHUDAddedTo:view animated:animated];
    //TODO:UIActivityIndicatorView
}

+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated {
    return [MBProgressHUD hideHUDForView:view animated:animated];
}




#pragma mark - Private
//以下获取textSize方法取自NSString+CJTextSize
+ (CGSize)getTextSizeFromString:(NSString *)string withFont:(UIFont *)font
                        maxSize:(CGSize)maxSize
                  lineBreakMode:(NSLineBreakMode)lineBreakMode
                 paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle
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
