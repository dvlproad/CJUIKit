//
//  CJDemoPopupView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/8/15.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJDemoPopupView : UIView

/**
 *  显示当前视图到window底部
 *
 *  @param popupViewHeight              弹出视图的高度
 */
- (void)popupInBottomWithHeight:(CGFloat)popupViewHeight;

/**
 *  显示当前视图到window中间
 *
 *  @param popupViewHeight              弹出视图的高度
 */
- (void)popupInCenterWithHeight:(CGFloat)popupViewHeight;

/**
 *  隐藏弹出视图
 */
- (void)hidePopupView;

@end

NS_ASSUME_NONNULL_END
