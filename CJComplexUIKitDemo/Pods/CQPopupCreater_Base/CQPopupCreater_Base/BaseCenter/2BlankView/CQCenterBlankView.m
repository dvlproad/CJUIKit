//
//  CQCenterBlankView.m
//  CJPopupCreater
//
//  Created by ciyouzen on 2021/10/13.
//

#import "CQCenterBlankView.h"

@interface CQCenterBlankView () {
    
}
@property (nullable, nonatomic, strong, readonly) UIVisualEffectView *effectView;   /**< 本视图中被添加模糊效果后，生成的新效果视图(未执行模糊或模糊未生成新视图则为nil)*/

@end


@implementation CQCenterBlankView


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
                           cornerViewPart:(CQCenterBlankAndNormalPopupPart)cornerViewPart
{
    UIView *popupView = self.popupView;
    
    if (effectViewPart == CQCenterBlankAndNormalPopupPartBlankView) {
        [self effectWithEffectStyle:effectStyle];

//    } else if (effectViewPart == CQCenterBlankAndNormalPopupPartPopupView) {
//        [popupView effectWithViewPart:CQPanlinePopupViewPartAll effectStyle:effectStyle];
//
//    } else if (effectViewPart == CQCenterBlankAndNormalPopupPartPopupViewWithoutPanLine) {
//        [popupView effectWithViewPart:CQPanlinePopupViewPartWithoutPanLine effectStyle:effectStyle];
    }
    
//    if (cornerViewPart == CQCenterBlankAndNormalPopupPartPopupViewWithoutPanLine) {
//        [popupView cornerWithViewPart:CQPanlinePopupViewPartWithoutPanLine cornerRadius:30];
//
//    } else if (cornerViewPart == CQCenterBlankAndPanlinePopupPartPopupView) {
//        [popupView cornerWithViewPart:CQPanlinePopupViewPartAll cornerRadius:30];
//    }
}


#pragma mark - 设置本视图的模糊化
/*
 *  对本视图的进行【模糊指定区域】
 *
 *  @param effectStyle          要添加的模糊效果是【什么类型】
 */
- (void)effectWithEffectStyle:(CQEffectStyle)effectStyle {
    UIVisualEffectView *effectView =
        [CQEffectAndCornerHelper createEffectViewWithEffectStyle:effectStyle
                                          newEffectViewAddToView:self
                                 newEffectViewCloseToViewSubView:self];
    _effectView = effectView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
