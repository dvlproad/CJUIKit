//
//  CJBaseAlertView+CQPopupAction.m
//  CJUIKitDemo
//
//  Created by lcQian on 2020/2/14.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CJBaseAlertView+CQPopupAction.h"
#import <CJBaseUIKit/UIView+CJPopupInView.h>

@implementation CJBaseAlertView (CQPopupAction)

/*
*  显示弹窗
*
*  @param shouldFitHeight  是否自动适应高度
*/
- (void)showWithShouldFitHeight:(BOOL)shouldFitHeight
{
    void(^alertDismissHandle)(CJBaseAlertView *bAlertView) = ^(CJBaseAlertView *bAlertView) {
        CGFloat delay = 0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [bAlertView cj_hidePopupViewWithAnimationType:CJAnimationTypeNone];
        });
    };
    self.alertDismissHandle = alertDismissHandle;
    
    UIColor *blankBGColor = [CJBaseOverlayThemeManager serviceThemeModel].commonThemeModel.blankBGColor;
    
    CGFloat fixHeight = [self calculateAlertHeightWithShouldAutoFitHeight:shouldFitHeight];
    
    CGSize popupViewSize = CGSizeMake(self.size.width, fixHeight);
    [self cj_popupInCenterWindow:CJAnimationTypeNormal
                        withSize:popupViewSize
                    blankBGColor:blankBGColor
                    showComplete:nil tapBlankComplete:nil];
}

@end
