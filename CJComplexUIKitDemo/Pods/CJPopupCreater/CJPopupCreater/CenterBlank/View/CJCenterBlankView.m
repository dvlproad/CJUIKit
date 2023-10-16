//
//  CJCenterBlankView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import "CJCenterBlankView.h"
#import <Masonry/Masonry.h>

@interface CJCenterBlankView () {
    
}
@property (nullable, nonatomic, strong, readonly) UIVisualEffectView *effectView;   /**< 本视图中被添加模糊效果后，生成的新效果视图(未执行模糊或模糊未生成新视图则为nil)*/

@end


@implementation CJCenterBlankView


#pragma mark - Init
/*
 *  初始化包含popupView的【底部完整弹出框视图】
 *
 *  @param popupView            弹出视图的内容视图
 *  @param popupViewSize        弹出视图的大小
 *  @param popupCenterOffset    弹窗弹出位置的中心与window中心的偏移量
 *  @param tapBlankHandle       点击视图的回调（每一个弹窗的背景点击回调都不一样）
 *
 *  @return 包含popupView的【底部完整弹出框视图】
 */
- (instancetype)initWithPopupView:(UIView *)popupView
                    popupViewSize:(CGSize)popupViewSize
                popupCenterOffset:(CGPoint)popupCenterOffset
                   tapBlankHandle:(void(^ _Nullable)(CJCenterBlankView *bSelf))tapBlankHandle
{
    self = [super initWithTapBlankHandle:^(CJBasePopupBlankView * _Nonnull bSelf) {
        !tapBlankHandle ?: tapBlankHandle(bSelf);
    }];
    if (self) {
        _popupView = popupView;
        _popupViewSize = popupViewSize;
        
        self.layer.masksToBounds = YES; // 修复底部弹窗隐藏时候，使用维持高度不变，改变bottom的约束导致的超出视图区域可见的问题
        
        [self addSubview:popupView];   // popupView改成添加到blankView中
        [popupView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self).mas_offset(popupCenterOffset.x);
            make.centerY.mas_equalTo(self).mas_offset(popupCenterOffset.y);
            make.size.mas_equalTo(popupViewSize);
        }];
    }
    
    return self;
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
            make.size.mas_equalTo(self.popupViewSize);
        }];
        [popupView.superview layoutIfNeeded];
    } else {
        CGFloat popupViewViewHeight = CGRectGetHeight(popupView.frame);
        [popupView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeZero);
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
    _popupViewSize = CGSizeMake(self.popupViewSize.width, newPopupViewHeight);
    
    [self.popupView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(newPopupViewHeight);
    }];
    [self.popupView.superview layoutIfNeeded];
}


/*
 *  获取包含popupView的【中部完整弹出框视图】
 *
 *  @param popupView            弹出视图的内容视图
 *  @param popupViewSize        弹出视图的大小
 *  @param popupCenterOffset    弹窗弹出位置的中心与window中心的偏移量
 *  @param blankBelongToView    用于防止重复生成容器的视图(为了避免弹出多个有背景的弹窗，导致模糊度叠加)
 *  @param tapBlock             点击视图的回调
 *
 *  @return 包含popupView的【中部完整弹出框视图】
 */
+ (CJCenterBlankView *)centerRealPopupViewWithPopupView:(UIView *)popupView
                                              popupViewSize:(CGSize)popupViewSize
                                          popupCenterOffset:(CGPoint)popupCenterOffset
                                          blankBelongToView:(UIView *)blankBelongToView
                                                   tapBlock:(void(^ _Nullable)(void))tapBlock
{
    /* 1、popupSuperview添加空白的点击区域blankView */
    UIView *blankView = [[CJBasePopupBlankView alloc] initWithTapBlankHandle:^(CJBasePopupBlankView * _Nonnull bSelf) {
        !tapBlock ?: tapBlock();
    }];
    
    /* 2、blankView添加popupView */
    [blankView addSubview:popupView];   // popupView改成添加到blankView中
    [self cjPopup_makeView:blankView addCenterSubView:popupView withSize:popupViewSize centerOffset:popupCenterOffset];
    
    
    return blankView;
}

#pragma mark - Private Method
+ (void)cjPopup_makeView:(UIView *)superView
        addCenterSubView:(UIView *)subView
                withSize:(CGSize)subViewSize
            centerOffset:(CGPoint)subViewCenterOffset
{
    [superView addSubview:subView];
    subView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeCenterX    //centerX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1
                                   constant:subViewCenterOffset.x]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeCenterY    //centerY
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeCenterY
                                 multiplier:1
                                   constant:subViewCenterOffset.y]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeWidth      //width
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:0
                                   constant:subViewSize.width]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeHeight     //height
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:0
                                   constant:subViewSize.height]];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
