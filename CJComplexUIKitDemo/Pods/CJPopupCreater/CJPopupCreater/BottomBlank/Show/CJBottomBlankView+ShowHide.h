//
//  CJBottomBlankView+ShowHide.h
//  CJPopupContainer
//
//  Created by ciyouzen on 2021/10/13.
//

#import <Foundation/Foundation.h>
#import "CJBottomBlankViewShowHelperProtocal.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJBottomBlankView (ShowHide)

#pragma mark - 设置使用自己的弹出方法类(遵守指定协议)
+ (void)updateShowHelper:(Class<CJBottomBlankViewShowHelperProtocal>)showHelper;



#pragma mark - Show And Hide
/*
 *  显示最完整弹窗视图blankView
 *
 *  @param blankView            要显示的含点击背景的最完整弹窗视图blankView
 *  @param popupSuperview       要显示在什么视图上(为nil时候，显示在keyWindow上)
 */
- (void)showBlankViewSelfInView:(nullable UIView *)popupSuperview;

/*
 *  隐藏最完整弹窗视图blankView
 *
 *  @param blankView            要隐藏的含点击背景的最完整弹窗视图blankView
 */
- (void)hideBlankViewSelf;

@end

NS_ASSUME_NONNULL_END
