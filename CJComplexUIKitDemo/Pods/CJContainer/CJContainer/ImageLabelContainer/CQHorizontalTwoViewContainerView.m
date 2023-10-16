//
//  CQHorizontalTwoViewContainerView.m
//  BiaoliApp
//
//  Created by qian on 2020/12/25.
//

#import "CQHorizontalTwoViewContainerView.h"
#import "CQLeftIconRightCustomConstraintHelper.h"

@interface CQHorizontalTwoViewContainerView () {
    
}
@property (nonatomic, assign, readonly) CGSize leftViewSize;
@property (nonatomic, assign, readonly) CGFloat iconTitleSpacing;
@property (nonatomic, assign, readonly) UIControlContentHorizontalAlignment imageLabelContentHorizontalAlignment;

@end

@implementation CQHorizontalTwoViewContainerView

/*
 *  初始化
 *
 *  @param leftViewCreateBlock          左视图（常为图片UIImageView或者emoji表情UILabel）
 *  @param rightViewCreateBlock         右视图（常为UILabel）
 *  @param leftViewWidth                左视图的大小(左视图常为①宽高1:1的icon图片；或②大小固定的文本label)
 *  @param twoViewSpacing               两个视图之间的间距
 *  @param contentHorizontalAlignment   两个视图的对齐类型(居中)
 *
 *  @return 【水平布局】的【图片在左，文字在图片右边(居左对齐、水平居中对齐)】的视图
 */
- (instancetype)initWithLeftViewCreateBlock:(UIView *(^)(void))leftViewCreateBlock
                       rightViewCreateBlock:(UIView *(^)(void))rightViewCreateBlock
                               leftViewSize:(CGSize)leftViewSize
                             twoViewSpacing:(CGFloat)twoViewSpacing
                 contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        UIView *imageView = leftViewCreateBlock();
        
        UIView *titleLabel = rightViewCreateBlock();
        //titleLabel.textAlignment = NSTextAlignmentLeft;
        
        [CQLeftIconRightCustomConstraintHelper addAndConstraintContainer:self
                                                       withLeftImageView:imageView
                                                         rightCustomView:titleLabel
                                                            leftViewSize:leftViewSize
                                                        iconTitleSpacing:twoViewSpacing
                                              contentHorizontalAlignment:contentHorizontalAlignment];
        _leftViewSize = leftViewSize;
        _iconTitleSpacing = twoViewSpacing;
        _imageLabelContentHorizontalAlignment = contentHorizontalAlignment;
        
        _leftView = imageView;
        _rightView = titleLabel;
    }
    return self;
}

#pragma mark - Update
/// 更新对齐方式
- (void)updateTwoViewContentHorizontalAlignment:(UIControlContentHorizontalAlignment)twoViewContentHorizontalAlignment {
    _imageLabelContentHorizontalAlignment = twoViewContentHorizontalAlignment;
}

/// 根据是否显示对应视图，来重新调整约束
- (void)reconstraintWithShowLeftView:(BOOL)showLeftView showRightView:(BOOL)showRightView {
    BOOL existView = showLeftView == YES || showRightView == YES;
    NSAssert(existView == YES, @"不能一个视图都没有");
    
    if (showLeftView == NO) {   // 只存在右视图
        [CQLeftIconRightCustomConstraintHelper reConstraintContainer:self
                                                   withLeftImageView:self.leftView
                                                     rightCustomView:self.rightView
                                                        leftViewSize:CGSizeZero
                                                    iconTitleSpacing:0
                                          contentHorizontalAlignment:self.imageLabelContentHorizontalAlignment];
        
    } else {
        if (showRightView) {    // 同时存在左视图和右视图
            [CQLeftIconRightCustomConstraintHelper reConstraintContainer:self
                                                       withLeftImageView:self.leftView
                                                         rightCustomView:self.rightView
                                                            leftViewSize:self.leftViewSize
                                                        iconTitleSpacing:self.iconTitleSpacing
                                              contentHorizontalAlignment:self.imageLabelContentHorizontalAlignment];
        } else {                // 只存在左视图
            [CQLeftIconRightCustomConstraintHelper reConstraintContainer_onlyShowLeft:self
                                                                    withLeftImageView:self.leftView
                                                                      rightCustomView:self.rightView
                                                                         leftViewSize:self.leftViewSize
                                                           contentHorizontalAlignment:self.imageLabelContentHorizontalAlignment];
        }
    }
}



- (void)addTarget:(nullable id)target action:(SEL)action {
//    [target performSelector:action target:target argument:nil order:0 modes:@[NSDefaultRunLoopMode]];
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:tapGR];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
