//
//  CJBottomBlankView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import "CJBottomBlankView.h"
#import <Masonry/Masonry.h>
#import <CJBaseUIKit/UIView+CJPanAction.h>

@interface CJBottomBlankView () {
    
}
@property (nullable, nonatomic, strong, readonly) UIVisualEffectView *effectView;   /**< 本视图中被添加模糊效果后，生成的新效果视图(未执行模糊或模糊未生成新视图则为nil)*/

@end

@implementation CJBottomBlankView

#pragma mark - Init
/*
 *  初始化包含popupView的【底部完整弹出框视图】
 *
 *  @param popupView            弹出视图的内容视图
 *  @param popupViewHeight      弹出视图的高度
 *  @param tapBlankHandle       点击视图的回调（每一个弹窗的背景点击回调都不一样）
 *
 *  @return 包含popupView的【底部完整弹出框视图】
 */
- (instancetype)initWithPopupView:(UIView *)popupView
                  popupViewHeight:(CGFloat)popupViewHeight
                   tapBlankHandle:(void(^ _Nullable)(CJBottomBlankView *bSelf))tapBlankHandle
{
    self = [super initWithTapBlankHandle:^(CJBasePopupBlankView * _Nonnull bSelf) {
        !tapBlankHandle ?: tapBlankHandle(bSelf);
    }];
    if (self) {
        _popupView = popupView;
        _popupViewHeight = popupViewHeight;
        
        self.layer.masksToBounds = YES; // 修复底部弹窗隐藏时候，使用维持高度不变，改变bottom的约束导致的超出视图区域可见的问题
        
        [self addSubview:popupView];   // popupView改成添加到blankView中
        [popupView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(0);
            make.right.mas_equalTo(self).mas_offset(0);
            make.bottom.mas_equalTo(self).mas_offset(0);
            make.height.mas_equalTo(popupViewHeight);
        }];
    }
    
    return self;
}


#pragma mark - Add PanGR For PopupView(为弹出视图添加手势)
/*
 *  添加pan手势：设置视图拖动结束且应该消失时候，应该执行的操作
 */
- (void)addPanWithPanCompleteDismissBlock:(void(^)(CJBottomBlankView *bSelf))panCompleteDismissBlock {
    [self.popupView cj_addPanWithPanCompleteDismissBlock:^{
        !panCompleteDismissBlock ?: panCompleteDismissBlock(self);
    }];
}


#pragma mark - updateConstraints
/*
 *  更新约束，根据是否显示popupView
 *
 *  @param show     是否显示popupView
 */
- (void)updateConstraintsForPopupViewWithShow:(BOOL)show {
    UIView *popupView = self.popupView;
    if (show) {
        popupView.alpha = 1.0f; // 修复单例时候，在隐藏过后，想再显示，没法继续显示的问题
        [popupView mas_updateConstraints:^(MASConstraintMaker *make) {
            //make.height.mas_equalTo(popupViewViewHeight);
            make.bottom.mas_equalTo(self).mas_offset(0);
        }];
        [popupView.superview layoutIfNeeded];
    } else {
        CGFloat popupViewViewHeight = CGRectGetHeight(popupView.frame);
        [popupView mas_updateConstraints:^(MASConstraintMaker *make) {
            //make.height.mas_equalTo(0);
            make.bottom.mas_equalTo(self).mas_offset(popupViewViewHeight);
        }];
        [popupView.superview layoutIfNeeded];
    }
}


/*
 *  更新弹出视图的内容视图的高度（场景：弹出视图popupView中含有可以随着输入的文本变化高度的文本框）
 *
 *  @param popupViewHeight      弹出视图的高度
 */
- (void)updatePopupViewHeight:(CGFloat)newPopupViewHeight {
    _popupViewHeight = newPopupViewHeight;
    
    [self.popupView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(newPopupViewHeight);
    }];
    [self.popupView.superview layoutIfNeeded];
}


#pragma mark - Get Method
/// 获取本视图最小必须的高度（太小的话，显示不全popupView）
- (CGFloat)viewMinHeight {
    CGFloat height = self.popupViewHeight;
    return height;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
