//
//  CQVerticalImageLabelView.m
//  BiaoliApp
//
//  Created by qian on 2020/12/25.
//

#import "CQVerticalImageLabelView.h"
#import "CQLeftIconRightCustomConstraintHelper.h"
#import <Masonry/Masonry.h>

@interface CQVerticalImageLabelView () {
    
}
@property (nonatomic, assign, readonly) CGFloat iconHeight;
@property (nonatomic, assign, readonly) CGFloat iconTitleSpacing;
//@property (nonatomic, assign, readonly) UIControlContentHorizontalAlignment imageLabelContentHorizontalAlignment;

@end

@implementation CQVerticalImageLabelView

- (instancetype)initWithIconHeight:(CGFloat)iconHeight
                  iconTitleSpacing:(CGFloat)iconTitleSpacing
                        showTitlte:(BOOL)showTitle
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor clearColor];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:titleLabel];
        [self addSubview:imageView];
        
        // 在本视图中居中排列：图片在上，文字在图片的下边
        if (showTitle == NO) {
            [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.height.mas_equalTo(iconHeight);
                make.centerX.mas_equalTo(self);
                make.centerY.mas_equalTo(self);
            }];
            [titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self);
                make.width.height.mas_equalTo(0);
                make.bottom.mas_equalTo(imageView.mas_top).mas_offset(-0);
            }];
        } else {
            // 在本视图中居中排列：图片在左，文字在图片的右边
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self).offset(0);
                make.centerX.mas_equalTo(self);
                make.centerY.mas_equalTo(self).offset((iconHeight+iconTitleSpacing)/2);
            }];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self);
                make.width.height.mas_equalTo(iconHeight);
                make.bottom.mas_equalTo(titleLabel.mas_top).mas_offset(-iconTitleSpacing);
            }];
            
        }
        
        
        _iconHeight = iconHeight;
        _iconTitleSpacing = iconTitleSpacing;
        
        self.imageView = imageView;
        self.titleLable = titleLabel;
    }
    return self;
}

#pragma mark - Update
/// 更新图片，同时会根据图片和文字是否为空，来重新调整约束
- (void)updateAndReconstraintWithTitle:(nonnull NSString *)title image:(nullable UIImage *)image {
    self.imageView.image = image;
    self.titleLable.text = title;
    
    if (title.length <= 0) {
        // 在本视图中居中排列：图片在左，文字在图片的右边
        [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(0);
            make.centerX.mas_equalTo(self);
            make.centerY.mas_equalTo(self);
        }];
        [self.titleLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.width.height.mas_equalTo(0);
            make.bottom.mas_equalTo(self.imageView.mas_top).mas_offset(-0);
        }];
    } else {
        if (image == nil) {
            [CQLeftIconRightCustomConstraintHelper reVerticalIConstraintContainer:self
                                                                 withTopImageView:self.imageView
                                                                 bottomCustomView:self.titleLable
                                                                       iconHeight:0
                                                                 iconTitleSpacing:0];
            
        } else {
            [CQLeftIconRightCustomConstraintHelper reVerticalIConstraintContainer:self
                                                                 withTopImageView:self.imageView
                                                                 bottomCustomView:self.titleLable
                                                                       iconHeight:self.iconHeight
                                                                 iconTitleSpacing:self.iconTitleSpacing];
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
