//
//  CQToast.m
//  CJDemoModuleLoginDemoCommonDemo
//
//  Created by ciyouzen on 2018/9/20.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CQToast.h"
#import <CJBaseOverlayKit/CJToast.h>
//#import <CJBaseOverlayKit/CJBaseAlertView.h>
#import <CJFoundation/NSString+CJTextSize.h>

#ifdef TEST_CJBASEUIKIT_POD
#import "UIColor+CJHex.h"
#else
#import <CJBaseUIKit/UIColor+CJHex.h>
#endif

@implementation CQToast

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
    [CJToast shortShowMessage:message inView:view withLabelTextColor:nil bezelViewColor:nil hideAfterDelay:2.f];
    // 黑底白字
    // [CJToast shortShowMessage:message inView:view withLabelTextColor:[UIColor whiteColor] bezelViewColor:[UIColor blackColor] hideAfterDelay:2.f];
}


///显示含图片和文字的错误提示
+ (void)showErrorMessage:(NSString *)errorMessage {
//    UIImage *errorImage = [UIImage imageNamed:@"demo_toast_error"];
//    UIView *view = [[UIApplication sharedApplication].delegate window];
//    [CJToast shortShowMessage:errorMessage image:errorImage toView:view];
    [self showErrorToastAlertViewTitle:errorMessage];
    
}

///显示 "errorToast" 的 alertView
+ (void)showErrorToastAlertViewTitle:(NSString *)title
{
    if (title.length == 0) {
        return;
    }
    
//    CGFloat textWidth = [title cjTextWidthWithFont:[UIFont systemFontOfSize:17.0]] > 160 ? 290 : 160;
//    CGSize popupViewSize = CGSizeMake(textWidth, 150); //登录时候的账号密码错误是160的宽
//    
//    CJBaseAlertView *alertView = [[CJBaseAlertView alloc] initWithSize:popupViewSize firstVerticalInterval:20 secondVerticalInterval:15 thirdVerticalInterval:0 bottomMinVerticalInterval:19];
//    
//    alertView.backgroundColor = CJColorFromHexStringAndAlpha(@"#000000", 0.76);
//    
//    //image
//    UIImage *errorImage = [UIImage imageNamed:@"cjdemo_toast_error"];
//    [alertView addFlagImage:errorImage size:CGSizeMake(27, 27)];
//    
//    //title
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
//    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
//    paragraphStyle.lineSpacing = 5;
//    [alertView addTitleWithText:title font:[UIFont systemFontOfSize:17.0] textAlignment:NSTextAlignmentCenter margin:10 paragraphStyle:paragraphStyle];
//    [alertView updateTitleTextColor:[UIColor whiteColor]];
//    
//    [alertView showWithShouldFitHeight:YES blankBGColor:[UIColor clearColor]];
//    
//    // dismiss
//    [alertView dismissWithDelay:0.7];
}



@end
