//
//  TSToast.m
//  CJDemoModuleLoginDemoCommonDemo
//
//  Created by ciyouzen on 2018/9/20.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "TSToast.h"
#import <LuckinBaseOverlayKit/LuckinToast.h>
#import <LuckinBaseOverlayKit/CJMessageAlertView.h>
#import <CJFoundation/NSString+CJTextSize.h>

#ifdef TEST_CJBASEUIKIT_POD
#import "UIColor+CJHex.h"
#else
#import <LuckinBaseUIKit/UIColor+CJHex.h>
#endif

@implementation TSToast

/**
*  在window上短暂的显示文字(灰底黑字，2秒后自动消失)
*
*  @param message  要显示的信息
*/
+ (void)showMessage:(NSString *)message
{
    UIView *view = [[UIApplication sharedApplication].delegate window];
    
    [self showMessage:message inView:view];
}


/**
*  在指定的view上短暂的显示文字(灰底黑字，2秒后自动消失)
*
*  @param message  要显示的信息
*  @param view     信息要显示的位置
*/
+ (void)showMessage:(NSString *)message inView:(UIView *)view {
    // 灰底黑字
    [LuckinToast showMessage:message inView:view withLabelTextColor:nil bezelViewColor:nil hideAfterDelay:2.f];
    // 黑底白字
    // [LuckinToast showMessage:message inView:view withLabelTextColor:[UIColor whiteColor] bezelViewColor:[UIColor blackColor] hideAfterDelay:2.f];
}

@end
