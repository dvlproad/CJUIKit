//
//  CJCenterBlankViewShowHelperProtocal.h
//  CQPopupCreater_Other
//
//  Created by ciyouzen on 2021/10/14.
//

#ifndef CJCenterBlankViewShowHelperProtocal_h
#define CJCenterBlankViewShowHelperProtocal_h

#import "CJCenterBlankView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CJCenterBlankViewShowHelperProtocal <NSObject>

@required
/*
 *  显示最完整弹窗视图blankView
 *
 *  @param blankView            要显示的含点击背景的最完整弹窗视图blankView
 *  @param popupSuperview       要显示在什么视图上(为nil时候，显示在keyWindow上)
 */
+ (void)__showBlankView:(CJCenterBlankView *)blankView inView:(nullable UIView *)popupSuperview;


/*
 *  隐藏最完整弹窗视图blankView
 *
 *  @param blankView            要隐藏的含点击背景的最完整弹窗视图blankView
 */
+ (void)__hideBlankView:(CJCenterBlankView *)blankView;

@end

#endif /* CJCenterBlankViewShowHelperProtocal_h */

NS_ASSUME_NONNULL_END
