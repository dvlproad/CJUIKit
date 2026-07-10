//
//  CJBaseAlertView+TSPopupAction.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/2/14.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CJBaseAlertView+TSPopupAction.h"
#import <CJPopupAction/UIView+CJPopupInView.h>

@implementation CJBaseAlertView (TSPopupAction)

/*
*  显示弹窗
*
*  @param shouldFitHeight  是否自动适应高度
*/
- (void)showWithShouldFitHeight:(BOOL)shouldFitHeight
{
    UIColor *blankBGColor = [CJBaseOverlayThemeManager serviceThemeModel].commonThemeModel.blankBGColor;
    
    CGSize fixSize = [self alertSizeWithShouldAutoFitHeight:YES];
    CGFloat fixHeight = fixSize.height;
    
    CGSize popupViewSize = CGSizeMake(self.size.width, fixHeight);
    [self cj_popupInCenterWindow:CJAnimationTypeNormal
                            withSize:popupViewSize
                        blankBGColor:blankBGColor
                        showComplete:nil tapBlankComplete:nil];
}

/*
*  关闭弹窗
*
*  @param delay         多长时间后执行
*/
- (void)dismissAfterDelay:(CGFloat)delay {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self cj_hidePopupViewWithAnimationType:CJAnimationTypeNone];
    });
}

@end
