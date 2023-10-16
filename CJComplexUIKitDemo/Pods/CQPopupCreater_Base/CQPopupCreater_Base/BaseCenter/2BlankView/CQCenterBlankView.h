//
//  CQCenterBlankView.h
//  CJPopupCreater
//
//  Created by ciyouzen on 2021/10/13.
//

#import <CJPopupCreater/CJCenterBlankView.h>
#import "CQCenterBlankAndNormalPopupEnum.h"
#import <CJPopupCreater/CQEffectAndCornerHelper.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQCenterBlankView : CJCenterBlankView {
    
}

#pragma mark - 设置模糊化和圆角化
/*
 *  对弹出视图进行【模糊指定区域】和【圆角化指定区域】
 *
 *  @param effectType           模糊化
 *  @param effectStyle          要添加的模糊效果是【什么类型】
 *  @param cornerType           圆角化（注:如果圆角的区域刚好等于被进行模糊的区域，则模糊的区域也要圆角）
 */
- (void)effectAndCornerWithEffectViewPart:(CQCenterBlankAndNormalPopupPart)effectViewPart
                              effectStyle:(CQEffectStyle)effectStyle
                           cornerViewPart:(CQCenterBlankAndNormalPopupPart)cornerViewPart;

@end

NS_ASSUME_NONNULL_END
