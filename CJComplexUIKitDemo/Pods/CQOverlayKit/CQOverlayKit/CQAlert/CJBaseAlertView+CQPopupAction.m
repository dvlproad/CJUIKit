//
//  CJBaseAlertView+CQPopupAction.m
//  CJUIKitDemo
//
//  Created by lcQian on 2020/2/14.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CJBaseAlertView+CQPopupAction.h"
#import "UIView+CQPopupOverlayAction.h"

@implementation CJBaseAlertView (CQPopupAction)

/*
*  显示弹窗
*
*  @param shouldFitHeight  是否自动适应高度
*/
- (void)showAlertWithShouldFitHeight:(BOOL)shouldFitHeight
{
    void(^alertDismissHandle)(CJBaseAlertView *bAlertView) = ^(CJBaseAlertView *bAlertView) {
        CGFloat delay = 0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [bAlertView cqOverlay_popupHideCenter];
        });
    };
    self.alertDismissHandle = alertDismissHandle;
    
    CGFloat fixHeight = [self calculateAlertHeightWithShouldAutoFitHeight:shouldFitHeight];
    [self cqOverlay_popupInCenterWindowWithHeight:fixHeight];
}

@end
