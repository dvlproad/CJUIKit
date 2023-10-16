//
//  CQHorizontalImageLabelView.m
//  BiaoliApp
//
//  Created by qian on 2020/12/25.
//

#import "CQHorizontalImageLabelView.h"

@implementation CQHorizontalImageLabelView

- (instancetype)initWithIconHeight:(CGFloat)iconHeight
                  iconTitleSpacing:(CGFloat)iconTitleSpacing
        contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment
{
    return [super initWithLeftViewCreateBlock:^UIView * _Nonnull{
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor clearColor];
        return imageView;
    
    } rightViewCreateBlock:^UIView * _Nonnull{
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        return titleLabel;
        
    } leftViewSize:CGSizeMake(iconHeight, iconHeight) twoViewSpacing:iconTitleSpacing contentHorizontalAlignment:contentHorizontalAlignment];
}

#pragma mark - Get Method
- (UIImageView *)imageView {
    UIImageView *imageView = (UIImageView *)self.leftView;
    return imageView;
}

- (UILabel *)titleLable {
    UILabel *titleLable = (UILabel *)self.rightView;
    return titleLable;
}


#pragma mark - Update
/// 更新图片，同时会根据图片是否为空，来重新调整约束
- (void)updateAndReconstraintImageViewWithImage:(nullable UIImage *)image {
    self.imageView.image = image;
    
    [super reconstraintWithShowLeftView:image!=nil showRightView:YES];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
