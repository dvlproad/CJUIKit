//
//  CQTSRipeImageCollectionViewCell.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 8/10/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CQTSRipeImageCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import "UIImageView+CQTSBaseUtil.h"

static const CGFloat badgeLabelWidth = 16;  // badge的宽高大小
const CGFloat badgeLabelMargin = 4;         // badge与cell的距离

@interface CQTSRipeImageCollectionViewCell () {
    
}
@property (nonatomic, strong) UILabel *badgeLabel;

@end

@implementation CQTSRipeImageCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
//        self.selectedBackgroundView = ({
//            UIView *view = [UIView new];
//            view.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0]; //#f4f4f4
//            view;
//        });
        
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.contentView.layer.masksToBounds = YES; // 防止image图片外溢
    
    [self.contentView addSubview:self.titleNameLabel];
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.badgeLabel];

    [self.titleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView).mas_offset(0);
        make.height.mas_equalTo(12);
    }];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).mas_offset(badgeLabelMargin);
        make.bottom.mas_equalTo(self.titleNameLabel.mas_top).mas_offset(-6);
        make.width.mas_equalTo(self.iconImageView.mas_height).multipliedBy(1.0);
        make.centerX.mas_equalTo(self.contentView);
    }];
    
    [self.badgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImageView.mas_top).mas_offset(-badgeLabelMargin);
        make.right.mas_equalTo(self.iconImageView.mas_right).mas_offset(badgeLabelMargin);
        make.width.mas_equalTo(badgeLabelWidth);
        make.height.mas_equalTo(badgeLabelWidth);
    }];
}

#pragma mark - Set
/// 设置text
- (void)setupText:(NSString *)text {
    self.titleNameLabel.text = text;
}

/// 使用本地图片设置image
- (void)setupImageWithImage:(UIImage *)image {
    [self.iconImageView setImage:image];
}
/// 使用网络图片设置image
- (void)setupImageWithImageUrl:(NSString *)imageUrl {
    // 修复使得在滑动过程中，不会因为cell的重用，而导致图片显示错位的问题
    [self.iconImageView cqdm_setImageWithUrl:imageUrl completed:nil];
    
    /*
    // 以下代码会发生因为cell重用，导致图片显示错位
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];

        dispatch_async(dispatch_get_main_queue(), ^{
            self.iconImageView.image = image;// 图片错乱根源:用户在滑动的过程中，因为cell的重用，第11行的cell可能使用的是第0行的cell
        });
    });
    */
}

/// 设置badge
- (void)setupBadgeCount:(NSInteger)badgeCount withMaxNumber:(NSInteger)maxCount {
    _badgeCount = badgeCount;
    
    if (badgeCount <= 0) {
        self.badgeLabel.hidden = YES;
        self.badgeLabel.text = @"";
        return;
    }
    
    self.badgeLabel.hidden = NO;
    
    NSString *badgeString = [NSString stringWithFormat:@"%@", @(badgeCount)];
    if (badgeCount > maxCount) {
        badgeString = [NSString stringWithFormat:@"%ld+", maxCount];
    }
    self.badgeLabel.text = badgeString;
}

#pragma mark - lazy init
@synthesize titleNameLabel = _titleNameLabel;
- (UILabel *)titleNameLabel {
    if (!_titleNameLabel) {
        _titleNameLabel = [[UILabel alloc] init];
        _titleNameLabel.backgroundColor = [UIColor clearColor];
        _titleNameLabel.textColor =  [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];  // (@"#333333");
        _titleNameLabel.font = [UIFont systemFontOfSize:12];
        _titleNameLabel.textAlignment = NSTextAlignmentCenter;
        //_titleNameLabel.adjustsFontSizeToFitWidth = YES; // 字号不允许进行改变
    }
    return _titleNameLabel;
}

@synthesize iconImageView = _iconImageView;
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.layer.cornerRadius = 6;
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.backgroundColor = [UIColor clearColor];
    }
    return _iconImageView;
}

@synthesize badgeLabel = _badgeLabel;
- (UILabel *)badgeLabel {
    if (!_badgeLabel) {
        _badgeLabel = [[UILabel alloc] init];
        _badgeLabel.backgroundColor = [UIColor redColor]; //#ff0000
        _badgeLabel.textColor = [UIColor whiteColor];  // (@"#FFFFFF");
        _badgeLabel.font = [UIFont systemFontOfSize:11];
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
        _badgeLabel.layer.cornerRadius = badgeLabelWidth/2;
        _badgeLabel.adjustsFontSizeToFitWidth = YES;
        _badgeLabel.minimumScaleFactor = 0.3;
        _badgeLabel.clipsToBounds = YES;
        _badgeLabel.hidden = YES;
    }
    return _badgeLabel;
}

@end
