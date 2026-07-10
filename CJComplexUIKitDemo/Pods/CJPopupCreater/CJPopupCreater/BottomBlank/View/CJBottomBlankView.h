//
//  CJBottomBlankView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import "CJBasePopupBlankView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJBottomBlankView : CJBasePopupBlankView {
    
}
@property (nonatomic, strong, readonly) UIView *popupView;      /**< 需要弹出的视图 */
@property (nonatomic, assign, readonly) CGFloat popupViewHeight;/**< 需要弹出的视图的高度 */

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
                   tapBlankHandle:(void(^ _Nullable)(CJBottomBlankView *bSelf))tapBlankHandle NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithTapBlankHandle:(void(^ _Nullable)(CJBasePopupBlankView *bSelf))tapBlankHandle NS_UNAVAILABLE;


#pragma mark - Add PanGR For PopupView(为弹出视图添加手势)
/*
 *  添加pan手势：设置视图拖动结束且应该消失时候，应该执行的操作
 */
- (void)addPanWithPanCompleteDismissBlock:(void(^)(CJBottomBlankView *bSelf))panCompleteDismissBlock;



#pragma mark - updateConstraints
/*
 *  更新约束，根据是否显示popupView
 *
 *  @param show     是否显示popupView
 */
- (void)updateConstraintsForPopupViewWithShow:(BOOL)show;

/*
 *  更新弹出视图的内容视图的高度（场景：弹出视图popupView中含有可以随着输入的文本变化高度的文本框）
 *
 *  @param popupViewHeight      弹出视图的高度
 */
- (void)updatePopupViewHeight:(CGFloat)newPopupViewHeight;



#pragma mark - Get Method
/// 获取本视图最小必须的高度（太小的话，显示不全popupView）
- (CGFloat)viewMinHeight;

@end

NS_ASSUME_NONNULL_END
