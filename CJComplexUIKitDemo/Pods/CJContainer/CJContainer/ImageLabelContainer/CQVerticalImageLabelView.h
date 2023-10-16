//
//  CQVerticalImageLabelView.h
//  BiaoliApp
//
//  Created by qian on 2020/12/25.
//
//  【竖直布局】的【图片在上，文字在图片下边(居顶对齐、竖直居中对齐)】的视图

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQVerticalImageLabelView : UIView {
    
}
//@property (nonatomic, strong) UIImage *image;
//@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UIImageView *imageView;

#pragma mark - Init
- (instancetype)initWithIconHeight:(CGFloat)iconHeight
                  iconTitleSpacing:(CGFloat)iconTitleSpacing
                        showTitlte:(BOOL)showTitle NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

- (void)addTarget:(nullable id)target action:(SEL)action;

#pragma mark - Update
/// 更新图片，同时会根据图片和文字是否为空，来重新调整约束
- (void)updateAndReconstraintWithTitle:(nonnull NSString *)title image:(nullable UIImage *)image;

@end

NS_ASSUME_NONNULL_END
