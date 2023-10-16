//
//  CQHorizontalImageLabelView.h
//  BiaoliApp
//
//  Created by qian on 2020/12/25.
//
//  【水平布局】的【图片在左，文字在图片右边(居左对齐、水平居中对齐)】的视图

#import "CQHorizontalTwoViewContainerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CQHorizontalImageLabelView : CQHorizontalTwoViewContainerView {
    
}
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLable;
//#pragma mark - Get Method
//- (UIImageView *)imageView;
//- (UILabel *)titleLable;

#pragma mark - Init
- (instancetype)initWithIconHeight:(CGFloat)iconHeight
                  iconTitleSpacing:(CGFloat)iconTitleSpacing
        contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithLeftViewCreateBlock:(UIView *(^)(void))leftViewCreateBlock
                       rightViewCreateBlock:(UIView *(^)(void))rightViewCreateBlock
                               leftViewSize:(CGSize)leftViewSize
                             twoViewSpacing:(CGFloat)twoViewSpacing
                 contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment NS_UNAVAILABLE;

#pragma mark - Update
/// 更新图片，同时会根据图片是否为空，来重新调整约束
- (void)updateAndReconstraintImageViewWithImage:(nullable UIImage *)image;

@end

NS_ASSUME_NONNULL_END
