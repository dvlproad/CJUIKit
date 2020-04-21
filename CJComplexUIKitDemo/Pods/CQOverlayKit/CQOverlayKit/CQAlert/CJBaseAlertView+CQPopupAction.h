//
//  CJBaseAlertView+CQPopupAction.h
//  CJUIKitDemo
//
//  Created by lcQian on 2020/2/14.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <CJBaseOverlayKit/CJBaseAlertView.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJBaseAlertView (CQPopupAction)

/*
*  显示弹窗
*
*  @param shouldFitHeight  是否自动适应高度
*/
- (void)showWithShouldFitHeight:(BOOL)shouldFitHeight;

@end

NS_ASSUME_NONNULL_END
