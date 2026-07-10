//
//  CJBottomBlankView+ShowHide.m
//  CJPopupContainer
//
//  Created by ciyouzen on 2021/10/13.
//

#import "CJBottomBlankView+ShowHide.h"
#import "CJBottomBlankViewShowHelper.h"

@implementation CJBottomBlankView (ShowHide)

#pragma mark - 设置使用自己的弹出方法类(遵守指定协议)
static Class<CJBottomBlankViewShowHelperProtocal> _bottomPanlineBlankViewShowHelper;
+ (void)updateShowHelper:(Class<CJBottomBlankViewShowHelperProtocal>)showHelper {
    _bottomPanlineBlankViewShowHelper = showHelper;
}



#pragma mark - Show And Hide

/*
 *  显示最完整弹窗视图blankView
 *
 *  @param blankView            要显示的含点击背景的最完整弹窗视图blankView
 *  @param popupSuperview       要显示在什么视图上(为nil时候，显示在keyWindow上)
 */
- (void)showBlankViewSelfInView:(nullable UIView *)popupSuperview {
    if (_bottomPanlineBlankViewShowHelper == nil) { // 如果未设置弹出方法，则使用默认的弹出方法
        _bottomPanlineBlankViewShowHelper = [CJBottomBlankViewShowHelper class];
    }
    [_bottomPanlineBlankViewShowHelper __showBlankView:self inView:popupSuperview];
}

/*
 *  隐藏最完整弹窗视图blankView
 *
 *  @param blankView            要隐藏的含点击背景的最完整弹窗视图blankView
 */
- (void)hideBlankViewSelf {
    if (_bottomPanlineBlankViewShowHelper == nil) { // 如果未设置弹出方法，则使用默认的弹出方法
        _bottomPanlineBlankViewShowHelper = [CJBottomBlankViewShowHelper class];
    }
    [_bottomPanlineBlankViewShowHelper __hideBlankView:self];
}





@end
