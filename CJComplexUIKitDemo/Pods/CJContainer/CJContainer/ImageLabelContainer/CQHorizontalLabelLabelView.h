//
//  CQHorizontalLabelLabelView.h
//  BiaoliApp
//
//  Created by qian on 2020/12/25.
//
//  【水平布局】的【flagTitle文字在左，formatTitle文字在右(居左对齐、水平居中对齐)】的视图

#import "CQHorizontalTwoViewContainerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CQHorizontalLabelLabelView : CQHorizontalTwoViewContainerView {
    
}
#pragma mark - Get Method
- (UILabel * _Nonnull)flagTitleLabel;
- (UILabel * _Nonnull)formatTitleLabel;

#pragma mark - Init
- (instancetype)initWithLeftViewSize:(CGSize)leftViewSize
                    iconTitleSpacing:(CGFloat)iconTitleSpacing
          contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithLeftViewCreateBlock:(UIView *(^)(void))leftViewCreateBlock
                       rightViewCreateBlock:(UIView *(^)(void))rightViewCreateBlock
                               leftViewSize:(CGSize)leftViewSize
                             twoViewSpacing:(CGFloat)twoViewSpacing
                 contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment NS_UNAVAILABLE;

#pragma mark - Update
- (void)updateLeftText:(nullable NSString *)leftText rightText:(nullable NSString *)rightText;

@end

NS_ASSUME_NONNULL_END
