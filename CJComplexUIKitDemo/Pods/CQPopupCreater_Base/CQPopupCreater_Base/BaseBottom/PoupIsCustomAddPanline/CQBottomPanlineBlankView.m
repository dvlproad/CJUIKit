//
//  CQBottomPanlineBlankView.m
//  CJPopupCreater
//
//  Created by ciyouzen on 2021/10/13.
//

#import "CQBottomPanlineBlankView.h"
#import "CQBottomCustomWithPanlineView.h"
#import <CJBaseUIKit/UIView+CJPanAction.h>

@interface CQBottomPanlineBlankView () {
    
}
@property (nullable, nonatomic, strong, readonly) UIVisualEffectView *effectView;   /**< 本视图中被添加模糊效果后，生成的新效果视图(未执行模糊或模糊未生成新视图则为nil)*/

@end


@implementation CQBottomPanlineBlankView

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
                     tapBlankHandle:(void(^ _Nullable)(CQBottomPanlineBlankView *bBlankView))tapBlankHandle
{
    // 1、创建【含下拉线的视图】
    CQBottomCustomWithPanlineView *popupView = [[CQBottomCustomWithPanlineView alloc] initWithShowPanLine:showPanLine customView:customViewWithoutPanline];
    CGFloat popupViewHeight = [popupView viewHeightWithCustomViewHeight:customViewWithoutPanlineHeight];
    
    // 2、将【含下拉线的视图】添加到【背景视图blankView】中
    self = [super initWithPopupView:popupView popupViewHeight:popupViewHeight tapBlankHandle:^(CJBasePopupBlankView * _Nonnull bSelf) {
        !tapBlankHandle ?: tapBlankHandle((CQBottomPanlineBlankView *)bSelf);
    }];
    
    __weak typeof(self)weakSelf = self;
    if (showPanLine) {
        [popupView cj_addPanWithPanCompleteDismissBlock:^{
            !panCompleteDismissBlock ?: panCompleteDismissBlock(weakSelf);
        }];
    }
    
    return self;
}

//- (instancetype)initWithPopupView:(UIView *)popupView popupViewHeight:(CGFloat)popupViewHeight tapBlankHandle:(void (^)(CJBasePopupBlankView * _Nonnull))tapBlankHandle // 已在.h中禁用掉
//{
//    NSAssert([popupView isKindOfClass:[CQBottomCustomWithPanlineView class]], @"此视图的popupView不是CQBottomCustomWithPanlineView类型，请不用使用此类创建blankView");
//    return [super initWithPopupView:popupView popupViewHeight:popupViewHeight tapBlankHandle:tapBlankHandle];
//}


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
                           cornerViewPart:(CQBottomBlankAndPanlinePopupPart)cornerViewPart
{
    CQBottomCustomWithPanlineView *popupView = (CQBottomCustomWithPanlineView *)self.popupView;
    
    if (effectViewPart == CQBottomBlankAndPanlinePopupPartBlankView) {
        [self effectWithEffectStyle:effectStyle];

    } else if (effectViewPart == CQBottomBlankAndPanlinePopupPartPopupView) {
        [popupView effectWithViewPart:CQPanlinePopupViewPartAll effectStyle:effectStyle];
        
    } else if (effectViewPart == CQBottomBlankAndPanlinePopupPartPopupViewWithoutPanLine) {
        [popupView effectWithViewPart:CQPanlinePopupViewPartWithoutPanLine effectStyle:effectStyle];
    }
    
    if (cornerViewPart == CQBottomBlankAndPanlinePopupPartPopupViewWithoutPanLine) {
        [popupView cornerWithViewPart:CQPanlinePopupViewPartWithoutPanLine cornerRadius:30];
        
    } else if (cornerViewPart == CQBottomBlankAndPanlinePopupPartPopupView) {
        [popupView cornerWithViewPart:CQPanlinePopupViewPartAll cornerRadius:30];
    }
}


#pragma mark - 设置本视图的模糊化
/*
 *  对本视图的进行【模糊指定区域】
 *
 *  @param effectStyle          要添加的模糊效果是【什么类型】
 */
- (void)effectWithEffectStyle:(CQEffectStyle)effectStyle {
    UIVisualEffectView *effectView = [CQEffectAndCornerHelper createEffectViewWithEffectStyle:effectStyle
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
