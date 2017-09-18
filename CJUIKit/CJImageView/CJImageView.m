//
//  CJImageView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/06/18.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJImageView.h"

static CGFloat kDefaultCJBadgeSize = 20.0f;    /**< 默认badge的大小 */

@interface CJImageView () {

}
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *badgeLabel;
@property (nonatomic) NSLayoutConstraint *badgeLabelWidthConstraint;

@property (nonatomic, weak) void(^tapCompleteBlock)(CJImageView *imageView);

@end


@implementation CJImageView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self cjImageView_CommonInit];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self cjImageView_CommonInit];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self cjImageView_CommonInit];
    }
    return self;
}

- (void)cjImageView_CommonInit {
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor purpleColor];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.backgroundColor = [UIColor clearColor];
    [self cj_makeView:self addSubView:_titleLabel withEdgeInsets:UIEdgeInsetsZero];
    
    _badgeLabel = [[UILabel alloc] init];
    _badgeLabel.textAlignment = NSTextAlignmentCenter;
    _badgeLabel.textColor = [UIColor whiteColor];
    _badgeLabel.backgroundColor = _badgeBackgroudColor;
    _badgeLabel.font = _badgeFont;
    _badgeLabel.hidden = YES;
    _badgeLabel.layer.cornerRadius = kDefaultCJBadgeSize / 2;
    _badgeLabel.clipsToBounds = YES;
    [self addSubview:_badgeLabel];
    [self setupBadgeLabelConstraints];
    
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelf)];
    [self addGestureRecognizer:tapGR];
}


/* 完整的描述请参见文件头部 */
- (void)setTapCompleteBlock:(void(^)(CJImageView *imageView))tapCompleteBlock {
    _tapCompleteBlock = tapCompleteBlock;
}

- (void)tapSelf {
    if (self.tapCompleteBlock) {
        self.tapCompleteBlock(self);
    }
}

#pragma mark - SetupConstraint
- (void)setupBadgeLabelConstraints {
    self.badgeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.badgeLabelWidthConstraint =
    [NSLayoutConstraint constraintWithItem:self.badgeLabel
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:0
                                  constant:kDefaultCJBadgeSize];
    [self addConstraint:self.badgeLabelWidthConstraint];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.badgeLabel
                                  attribute:NSLayoutAttributeHeight
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.badgeLabel
                                  attribute:NSLayoutAttributeWidth
                                 multiplier:1.0
                                   constant:0]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.badgeLabel
                                  attribute:NSLayoutAttributeRight
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1.0
                                   constant:-self.imageCornerRadius + 3]];
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.badgeLabel
                                  attribute:NSLayoutAttributeTop
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeTop
                                 multiplier:1.0
                                   constant:-3]];
}

- (void)updateBadgeLabelWidthConstraint {
    [self removeConstraint:self.badgeLabelWidthConstraint];
    
    self.badgeLabelWidthConstraint =
    [NSLayoutConstraint constraintWithItem:self.badgeLabel
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:0
                                  constant:self.badgeSize];
    [self addConstraint:self.badgeLabelWidthConstraint];
}


- (void)setImageCornerRadius:(CGFloat)imageCornerRadius {
    if (_imageCornerRadius != imageCornerRadius) {
        _imageCornerRadius = imageCornerRadius;
        self.layer.cornerRadius = _imageCornerRadius;
    }
}

/* titleLabel的设置 */
- (void)setTitle:(NSString *)title {
    if (![_title isEqualToString:title]) {
        _title = title;
        
        NSString *imageTitleShow = @"";
        if (title.length > 2) {
            imageTitleShow = [title substringFromIndex:title.length-2];
        } else {
            imageTitleShow = title;
        }

        self.titleLabel.text = imageTitleShow;
    }
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    self.titleLabel.font = titleFont;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    self.titleLabel.textColor = titleColor;
}



/* badge的设置 */
- (void)setShowBadge:(BOOL)showBadge {
    if (_showBadge != showBadge) {
        _showBadge = showBadge;
        self.badgeLabel.hidden = !_showBadge;
    }
}

- (void)setBadgeBackgroudColor:(UIColor *)badgeBackgroudColor {
    _badgeBackgroudColor = badgeBackgroudColor;
    self.badgeLabel.backgroundColor = badgeBackgroudColor;
}

- (void)setBadge:(NSInteger)badge {
    _badge = badge;
    if (badge > 0) {
        self.badgeLabel.hidden = NO;
    } else {
        self.badgeLabel.hidden = YES;
    }
    
    if (badge > 99) {
        self.badgeLabel.text = @"99+";
        self.badgeFont = [UIFont boldSystemFontOfSize:9];
                          
    } else {
        self.badgeLabel.text = [NSString stringWithFormat:@"%ld", (long)_badge];
    }
}

- (void)setBadgeSize:(CGFloat)badgeSize {
    if (_badgeSize != badgeSize) {
        _badgeSize = badgeSize;
        _badgeLabel.layer.cornerRadius = _badgeSize / 2;
        
        [self updateBadgeLabelWidthConstraint];
    }
}

- (void)setBadgeFont:(UIFont *)badgeFont {
    _badgeFont = badgeFont;
    self.badgeLabel.font = badgeFont;
}

- (void)setBadgeTextColor:(UIColor *)badgeTextColor {
    _badgeTextColor = badgeTextColor;
    self.badgeLabel.textColor = badgeTextColor;
}


#pragma mark - addSubView
- (void)cj_makeView:(UIView *)superView addSubView:(UIView *)subView withEdgeInsets:(UIEdgeInsets)edgeInsets {
    [superView addSubview:subView];
    subView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeLeft   //left
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:1
                                   constant:edgeInsets.left]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeRight  //right
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:edgeInsets.right]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeTop    //top
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeTop
                                 multiplier:1
                                   constant:edgeInsets.top]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeBottom //bottom
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1
                                   constant:edgeInsets.bottom]];
}


@end
