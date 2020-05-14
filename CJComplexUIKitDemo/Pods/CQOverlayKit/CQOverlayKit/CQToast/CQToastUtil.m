//
//  CQToastUtil.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2018/9/20.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CQToastUtil.h"
#import <CJBaseOverlayKit/CJToast.h>
#import "CQOverlayTheme.h"

@implementation CQToastUtil

/**
*  在window上短暂的显示文字(灰底黑字，2秒后自动消失)
*
*  @param message  要显示的信息
*/
+ (void)showMessage:(NSString *)message
{
    UIView *view = [UIApplication sharedApplication].keyWindow;
    
    [self showMessage:message inView:view];
}


/**
*  在指定的view上短暂的显示文字(灰底黑字，2秒后自动消失)
*
*  @param message  要显示的信息
*  @param view     信息要显示的位置
*/
+ (void)showMessage:(NSString *)message inView:(UIView *)view {
    CQToastThemeModel *toastThemeModel = [CJBaseOverlayThemeManager serviceThemeModel].toastThemeModel;
    UIColor *textColor = toastThemeModel.textColor;
    UIColor *bezelViewColor = toastThemeModel.bezelViewColor;
    CGFloat hideAfterDelay = toastThemeModel.hideAfterDelay;
    [CJToast showMessage:message
                      inView:view
          withLabelTextColor:textColor
              bezelViewColor:bezelViewColor
              hideAfterDelay:hideAfterDelay];
}


///显示含图片和文字的错误提示
+ (void)showErrorMessage:(NSString *)errorMessage {
    UIImage *errorImage = [UIImage imageNamed:@"demo_toast_error"];
    UIView *view = [UIApplication sharedApplication].keyWindow;
    [CJToast showMessage:errorMessage image:errorImage toView:view hideAfterDelay:0.7];
}

///显示 "errorToast" 的 alertView
+ (void)showErrorToastAlertViewTitle:(NSString *)title
{
    if (title.length == 0) {
        return;
    }
    
    /// TODO:
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
