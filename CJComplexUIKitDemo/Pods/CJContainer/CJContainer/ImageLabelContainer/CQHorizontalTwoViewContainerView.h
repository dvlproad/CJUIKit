//
//  CQHorizontalTwoViewContainerView.h
//  BiaoliApp
//
//  Created by qian on 2020/12/25.
//
//  【水平布局】的【图片在左，文字在图片右边(居左对齐、水平居中对齐)】的视图

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQHorizontalTwoViewContainerView : UIView {
    
}
//@property (nonatomic, strong) UIImage *image;
//@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong, readonly) UIView *leftView;
@property (nonatomic, strong, readonly) UIView *rightView;

#pragma mark - Init
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
                 contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

- (void)addTarget:(nullable id)target action:(SEL)action;


#pragma mark - Update
/// 更新对齐方式
- (void)updateTwoViewContentHorizontalAlignment:(UIControlContentHorizontalAlignment)twoViewContentHorizontalAlignment;
/// 根据是否显示对应视图，来重新调整约束
- (void)reconstraintWithShowLeftView:(BOOL)showLeftView showRightView:(BOOL)showRightView;

@end

NS_ASSUME_NONNULL_END
