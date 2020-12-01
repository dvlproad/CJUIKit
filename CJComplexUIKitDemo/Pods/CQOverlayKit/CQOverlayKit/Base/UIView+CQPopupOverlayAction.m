//
//  UIView+CQPopupOverlayAction.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2019/8/13.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "UIView+CQPopupOverlayAction.h"
#import <CJBaseUIKit/UIView+CJPopupInView.h>
#import <CJBaseOverlayKit/CJBaseOverlayThemeManager.h>

static NSString *cqOverlay_popupHideFromBottomBlockKey = @"cqOverlay_popupHideFromBottomBlockKey";
static NSString *cqOverlay_popupHideFromCenterBlockKey = @"cqOverlay_popupHideFromCenterBlockKey";


@interface UIView () {
    
}
@property (nonatomic, copy) void(^cqOverlay_popupHideFromBottomBlock)(void);  /**< 对应于当前视图的从底部弹出的隐藏方法 */
@property (nonatomic, copy) void(^cqOverlay_popupHideFromCenterBlock)(void);  /**< 对应于当前视图的从中间弹出的隐藏方法 */

@end



@implementation UIView (CQPopupOverlayAction)

#pragma mark - 从底部弹出当前视图的相关代码
#pragma mark runtime
// cqOverlay_popupHideFromBottomBlock
- (void (^)(void))cqOverlay_popupHideFromBottomBlock {
    return objc_getAssociatedObject(self, &cqOverlay_popupHideFromBottomBlockKey);
}

- (void)setCqOverlay_popupHideFromBottomBlock:(void (^)(void))cqOverlay_popupHideFromBottomBlock {
    return objc_setAssociatedObject(self, &cqOverlay_popupHideFromBottomBlockKey, cqOverlay_popupHideFromBottomBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark Event
/**
 *  显示当前视图到window底部(以直角)
 *
 *  @param popupViewHeight              弹出视图的高度
 */
- (void)cqOverlay_popupInBottomWithHeight:(CGFloat)popupViewHeight {
    UIColor *blankBGColor = [CJBaseOverlayThemeManager serviceThemeModel].commonThemeModel.blankBGColor;
    UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
    
    // 执行显示弹窗的方法
    [self cj_popupInBottomWindow:CJAnimationTypeNormal withHeight:popupViewHeight edgeInsets:edgeInsets blankBGColor:blankBGColor showComplete:nil tapBlankComplete:^{
        [self cqOverlay_popupHideBottom];
    }];
    
    // 设置隐藏弹窗的方法
    __weak typeof(UIView *)weakPopupView = self;
    self.cqOverlay_popupHideFromBottomBlock = ^(void){
        [weakPopupView cj_hidePopupView];
    };
}


/**
 *  从window底部隐藏当前视图
 */
- (void)cqOverlay_popupHideBottom {
    if (self.cqOverlay_popupHideFromBottomBlock) {
        self.cqOverlay_popupHideFromBottomBlock();
    }
}




#pragma mark - 从window中间弹出当前视图的相关代码
#pragma mark runtime
// cqOverlay_popupHideFromCenterBlock
- (void (^)(void))cqOverlay_popupHideFromCenterBlock {
    return objc_getAssociatedObject(self, &cqOverlay_popupHideFromCenterBlockKey);
}

- (void)setCqOverlay_popupHideFromCenterBlock:(void (^)(void))cqOverlay_popupHideFromCenterBlock {
    return objc_setAssociatedObject(self, &cqOverlay_popupHideFromCenterBlockKey, cqOverlay_popupHideFromCenterBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark Event
/**
 *  显示当前视图到window中间
 *
 *  @param popupViewHeight              弹出视图的高度
 */
- (void)cqOverlay_popupInCenterWindowWithHeight:(CGFloat)popupViewHeight {
    UIColor *blankBGColor = [CJBaseOverlayThemeManager serviceThemeModel].commonThemeModel.blankBGColor;
    
    // 执行显示弹窗的方法
    CJAlertThemeModel *alertThemeModel = [CJBaseOverlayThemeManager serviceThemeModel].alertThemeModel;
    CGFloat popupViewWidth = alertThemeModel.alertWidth;
    CGSize popupViewSize = CGSizeMake(popupViewWidth, popupViewHeight);
    [self cj_popupInCenterWindow:CJAnimationTypeNormal
                        withSize:popupViewSize
                    centerOffset:CGPointZero
                    blankBGColor:blankBGColor
                    showComplete:nil tapBlankComplete:nil];
    
    // 设置隐藏弹窗的方法
    __weak typeof(UIView *)weakPopupView = self;
    self.cqOverlay_popupHideFromCenterBlock = ^(void){
        [weakPopupView cj_hidePopupView];
    };
}


/**
 *  从window中间隐藏当前视图
 */
- (void)cqOverlay_popupHideCenter {
    if (self.cqOverlay_popupHideFromCenterBlock) {
        self.cqOverlay_popupHideFromCenterBlock();
    }
}

@end
