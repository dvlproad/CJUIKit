//
//  CJBottomBlankViewShowHelperProtocal.h
//  CQPopupCreater_Other
//
//  Created by ciyouzen on 2021/10/14.
//

#ifndef CJBottomBlankViewShowHelperProtocal_h
#define CJBottomBlankViewShowHelperProtocal_h

#import "CJBottomBlankView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CJBottomBlankViewShowHelperProtocal <NSObject>

@required
/*
 *  显示最完整弹窗视图blankView
 *
 *  @param blankView            要显示的含点击背景的最完整弹窗视图blankView
 *  @param popupSuperview       要显示在什么视图上(为nil时候，显示在keyWindow上)
 */
+ (void)__showBlankView:(CJBottomBlankView *)blankView inView:(nullable UIView *)popupSuperview;


/*
 *  隐藏最完整弹窗视图blankView
 *
 *  @param blankView            要隐藏的含点击背景的最完整弹窗视图blankView
 */
+ (void)__hideBlankView:(CJBottomBlankView *)blankView;

@end

#endif /* CJBottomBlankViewShowHelperProtocal_h */

NS_ASSUME_NONNULL_END
