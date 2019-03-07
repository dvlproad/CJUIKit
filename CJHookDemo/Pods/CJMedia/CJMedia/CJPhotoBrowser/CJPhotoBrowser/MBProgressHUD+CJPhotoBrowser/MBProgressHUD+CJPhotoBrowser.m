//
//  MBProgressHUD+CJPhotoBrowser.m
//  CJPickerDemo
//
//  Created by ciyouzen on 2015/8/31.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "MBProgressHUD+CJPhotoBrowser.h"

@implementation MBProgressHUD (CJPhotoBrowser)

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view
{
    NSString *imageName = @"error.png";
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"CJPhotoBrowser.bundle/%@", imageName]];
    [self showMessage:error image:image view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    NSString *imageName = @"success.png";
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"CJPhotoBrowser.bundle/%@", imageName]];
    [self showMessage:success image:image view:view];
}


+ (void)showMessage:(NSString *)message image:(UIImage *)image view:(UIView *)view
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



#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
    
    return hud;
}
@end
