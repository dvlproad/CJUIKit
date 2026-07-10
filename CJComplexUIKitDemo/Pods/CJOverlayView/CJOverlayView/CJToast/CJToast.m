//
//  CJToast.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJToast.h"
#import "CJOverlayTextSizeUtil.h"

@implementation CJToast

#pragma mark - Only Text
/*
*  在指定的view上显示文字，并在delay秒后自动消失
*
*  @param message          要显示的信息
*  @param view             信息要显示的位置
*  @param labelTextColor   文字的颜色
*  @param bezelViewColor   文字所在背景框的颜色
*  @param delay            多少秒后自动消失
*/
+ (void)showMessage:(NSString *)message
            inView:(UIView *)view
withLabelTextColor:(UIColor * _Nullable)labelTextColor
    bezelViewColor:(UIColor * _Nullable)bezelViewColor
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
    CGSize textSize = [CJOverlayTextSizeUtil getTextSizeFromString:message withFont:hudLabelFont maxSize:maxSize lineBreakMode:NSLineBreakByCharWrapping paragraphStyle:nil];
    
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
            hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
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

/**
 *  在指定的view上短暂的显示文字及图片（delay秒后自动消失）
 *
 *  @param message  要显示的文字
 *  @param image    要显示的图片
 *  @param view     要显示在的视图
 */
+ (void)showMessage:(NSString *)message
              image:(UIImage *)image
             toView:(UIView *)view
     hideAfterDelay:(NSTimeInterval)delay
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
    [hud hideAnimated:YES afterDelay:delay];  // 0.7秒之后再消失
}

#pragma mark - Text And 菊花
/* 完整的描述请参见文件头部 */
+ (MBProgressHUD *)createChrysanthemumHUDWithMessage:(NSString *)message
                                              toView:(UIView * _Nullable)view
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

/**
 *  exec operation With HUD
 *
 *  @param startProgressMessage startProgressMessage
 *  @param endProgressMessage   endProgressMessage
 *  @param operationHandle      operationHandle
 */
+ (void)execOperationWithStartMessage:(NSString *)startProgressMessage
                           endMessage:(NSString *)endProgressMessage
                      operationHandle:(void (^ _Nullable)(void))operationHandle
{
    UIView *hudAddedToView = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:hudAddedToView animated:YES];
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
    hud.contentColor = [UIColor colorWithRed:0.f green:0.6f blue:0.7f alpha:1.f];
    
    hud.label.text = startProgressMessage;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        !operationHandle ?: operationHandle();
        
        dispatch_async(dispatch_get_main_queue(), ^{
            hud.label.text = endProgressMessage;
            [hud hideAnimated:YES afterDelay:0.7];
        });
    });
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

@end
