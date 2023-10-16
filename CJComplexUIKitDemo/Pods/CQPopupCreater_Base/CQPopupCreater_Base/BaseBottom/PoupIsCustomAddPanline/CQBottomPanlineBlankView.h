//
//  CQBottomPanlineBlankView.h
//  CJPopupCreater
//
//  Created by ciyouzen on 2021/10/13.
//

#import <CJPopupCreater/CJBottomBlankView.h>
#import "CQBottomBlankAndPanlinePopupEnum.h"
#import <CJPopupCreater/CQEffectEnum.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQBottomPanlineBlankView : CJBottomBlankView {
    
}

#pragma mark - Init
/*
 *  初始化包含popupView的【底部完整弹出框视图】
 *
 *  @param showPanLine                      是否显示下拉线
 *  @param customViewWithoutPanline         下拉线视图除外的其他视图
 *  @param customViewWithoutPanlineHeight   下拉线视图除外的其他视图的高度
 *  @param tapBlankHandle                   点击视图的回调（每一个弹窗的背景点击回调都不一样）
 *  @param panCompleteDismissBlock          拖动结束需要执行dimiss的回调(showPanLine为NO的时候，此值无效，相当于设为nil)
 *
 *  @return 包含popupView的【底部完整弹出框视图】
 */
- (instancetype)initWithShowPanLine:(BOOL)showPanLine
           customViewWithoutPanline:(UIView *)customViewWithoutPanline
     customViewWithoutPanlineHeight:(CGFloat)customViewWithoutPanlineHeight
            panCompleteDismissBlock:(void(^ _Nullable)(CQBottomPanlineBlankView *bBlankView))panCompleteDismissBlock
                     tapBlankHandle:(void(^ _Nullable)(CQBottomPanlineBlankView *bBlankView))tapBlankHandle NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithPopupView:(UIView *)popupView
                  popupViewHeight:(CGFloat)popupViewHeight
                   tapBlankHandle:(void(^ _Nullable)(CJBasePopupBlankView *bSelf))tapBlankHandle NS_UNAVAILABLE;


#pragma mark - 设置模糊化和圆角化
/*
 *  对弹出视图进行【模糊指定区域】和【圆角化指定区域】
 *
 *  @param effectViewPart       要添加模糊化的是视图的哪个部分
 *  @param effectStyle          要添加的模糊效果是【什么类型】
 *  @param cornerViewPart       圆角化（注:如果圆角的区域刚好等于被进行模糊的区域，则模糊的区域也要圆角）
 */
- (void)effectAndCornerWithEffectViewPart:(CQBottomBlankAndPanlinePopupPart)effectViewPart
                              effectStyle:(CQEffectStyle)effectStyle
                           cornerViewPart:(CQBottomBlankAndPanlinePopupPart)cornerViewPart;

@end

NS_ASSUME_NONNULL_END
