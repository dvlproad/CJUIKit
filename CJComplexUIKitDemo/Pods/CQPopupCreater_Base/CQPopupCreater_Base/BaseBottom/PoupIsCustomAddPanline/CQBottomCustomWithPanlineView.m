//
//  CQBottomCustomWithPanlineView.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2019/8/13.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CQBottomCustomWithPanlineView.h"
#import <Masonry/Masonry.h>

@interface CQBottomCustomWithPanlineView () {
    
}
@property (nonatomic, assign, readonly) BOOL showPanLine;


@property (nonatomic, assign, readonly) CQPanlinePopupViewPart effectViewPart;      /**< 要添加效果的是视图的哪个部分 */
@property (nullable, nonatomic, strong, readonly) UIVisualEffectView *effectView;   /**< 本视图中被添加模糊效果后，生成的新效果视图(未执行模糊或模糊未生成新视图则为nil)*/

@property (nonatomic, assign, readonly) CQPanlinePopupViewPart cornerViewPart;  /**< 要添加圆角的是视图的哪个部分 */
@property (nonatomic, assign, readonly) CGFloat cornerRadius;   /**< 圆角的角度 */

@end


@implementation CQBottomCustomWithPanlineView

#pragma mark - Init
/*
 *  初始化弹窗视图
 *
 *  @param showPanLine      是否显示下拉线
 *  @param customView       下拉线视图除外的其他视图
 *
 *  @return 弹窗视图
 */
- (instancetype)initWithShowPanLine:(BOOL)showPanLine customView:(UIView *)customView {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _showPanLine = showPanLine;
        
        if (showPanLine) {
            CQPanLineView *panLineView = [[CQPanLineView alloc] initWithFrame:CGRectZero];
            [self addSubview:panLineView];
            [panLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self);
                make.height.mas_equalTo(6).priorityLow;
                make.left.mas_equalTo(self);
                make.centerX.mas_equalTo(self);
            }];
            _panLineView = panLineView;
            
            [self addSubview:customView];
            [customView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self);
                make.top.equalTo(panLineView.mas_bottom).offset(10).priorityLow;// 固定拖动线的底部和其他顶部视图顶部之间的间距
                make.bottom.equalTo(self);
            }];
            _customView = customView;
            
        } else {
            [self addSubview:customView];
            [customView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self);
                make.top.equalTo(self).offset(0);
                make.bottom.equalTo(self);
            }];
            _customView = customView;
        }
        
    }
    return self;
}


#pragma mark - layoutSubviews(在此处理圆角化)
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 使用此方法时，请确保popupView的size都不为0
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    if (width == 0 || height == 0) {
        return;
    }
    
    /* 圆角化（注:如果圆角的区域刚好等于被进行模糊的区域，则模糊的区域也要圆角） */
    if (self.cornerViewPart == CQPanlinePopupViewPartAll) {
        [CQEffectAndCornerHelper cornerByMaskToView:self withCornerRadius:30];
        
    } else if (self.cornerViewPart == CQPanlinePopupViewPartWithoutPanLine) {
        [CQEffectAndCornerHelper cornerByMaskToView:self.customView withCornerRadius:30];
        // 如果模糊化操作有新视图生成，则再当要圆角化的子视图还等于模糊化的子视图时候，也要为此新模糊视图添加corner
        if (self.effectView != nil && self.effectViewPart == self.cornerViewPart) {
            [CQEffectAndCornerHelper cornerByMaskToView:self.effectView withCornerRadius:30];
        }
    }
    
    
}


#pragma mark - 设置模糊化和圆角化
/*
 *  对本视图的进行【模糊指定区域】
 *
 *  @param effectViewPart       要添加模糊化的是视图的哪个部分
 *  @param effectStyle          要添加的模糊效果是【什么类型】
 */
- (void)effectWithViewPart:(CQPanlinePopupViewPart)effectViewPart
               effectStyle:(CQEffectStyle)effectStyle
{
    _effectViewPart = effectViewPart;
    
    if (effectViewPart == CQPanlinePopupViewPartAll) {
        _effectView = [CQEffectAndCornerHelper createEffectViewWithEffectStyle:effectStyle
                                                        newEffectViewAddToView:self
                                               newEffectViewCloseToViewSubView:self];
    } else if (effectViewPart == CQPanlinePopupViewPartWithoutPanLine) {
        _effectView = [CQEffectAndCornerHelper createEffectViewWithEffectStyle:effectStyle
                                                        newEffectViewAddToView:self
                                               newEffectViewCloseToViewSubView:self.customView];
        
    }
}


/*
 *  设置对本视图的进行圆角化的参数
 *
 *  @param cornerViewPart   要添加圆角的是视图的哪个部分
 *  @param cornerRadius     圆角圆角
 */
- (void)cornerWithViewPart:(CQPanlinePopupViewPart)cornerViewPart cornerRadius:(CGFloat)cornerRadius {
    _cornerViewPart = cornerViewPart;
    _cornerRadius = cornerRadius;
}

#pragma mark - Get Method
/// 获取本视图的高度
- (CGFloat)viewHeightWithCustomViewHeight:(CGFloat)customViewHeight {
    if (self.showPanLine) {
        return 6+10+customViewHeight;
    } else {
        return customViewHeight;
    }
}

/// 获取customVie视图的高度
- (CGFloat)customViewHeightWithViewHeight:(CGFloat)viewHeight {
    CGFloat viewWithoutPanline_Height = 0;
    if (self.showPanLine) {
        viewWithoutPanline_Height = viewHeight-6-10;
    } else {
        viewWithoutPanline_Height = viewHeight;
    }
    return viewWithoutPanline_Height;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
