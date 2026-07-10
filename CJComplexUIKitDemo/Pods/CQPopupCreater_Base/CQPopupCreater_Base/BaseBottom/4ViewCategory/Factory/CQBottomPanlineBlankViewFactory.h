//
//  CQBottomPanlineBlankViewFactory.h
//  CQPopupCreater_Other
//
//  Created by ciyouzen on 2021/10/15.
//

#import <Foundation/Foundation.h>
#import "CQBottomPanlineBlankView.h"
#import <CJPopupCreater/CJBottomBlankView+ShowHide.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQBottomPanlineBlankViewFactory : NSObject

/*
 *  创建含顶部下拉线的弹出视图(可自定制点击空白区域执行的是确认还是取消操作)
 *
 *  @param selfHeight                   本视图被干净弹出的高度
            （即使本视图最终是由其他视图包着弹出,这里也只输入本视图被干净弹出的高度,实际最终的弹窗高度,内部会自动计算后以最终高度弹出)
 *  @param shouldEnableTapBlank         是否允许点击空白区域（常设为YES，来实现点击空白区域来隐藏弹窗的功能）
 *  @param tapBlankViewCompleteBlock    当允许点击空白区域时候的执行事件(为nil时，点击会自动隐藏；非nil时候需要自己调用隐藏)
 *  @param shouldAddPanAction           是否添加仿抖音评论的下拉拖动手势(附对于那些会弹出键盘的视图，一般设为NO，即不添加)
 *  @param panCompleteDismissBlock      拖动结束需要执行dimiss的回调(shouldAddPanAction为NO的时候，此值无效，相当于设为nil)
 */
+ (CQBottomPanlineBlankView *)blankViewWithCustomView:(UIView *)withouPanlineView
                                     customViewHeight:(CGFloat)withoutPanlineViewHeight
                                 shouldEnableTapBlank:(BOOL)shouldEnableTapBlank
                                     tapBlankComplete:(void(^ _Nullable)(void))tapBlankViewCompleteBlock
                                   shouldAddPanAction:(BOOL)shouldAddPanAction
                              panCompleteDismissBlock:(void(^ _Nullable)(void))panCompleteDismissBlock;

@end

NS_ASSUME_NONNULL_END
