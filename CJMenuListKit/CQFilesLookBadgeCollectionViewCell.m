//
//  CQFilesLookBadgeCollectionViewCell.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/5/21.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CQFilesLookBadgeCollectionViewCell.h"
#import <Masonry/Masonry.h>

@interface CQFilesLookBadgeCollectionViewCell () {
    
}
@property (nonatomic, strong) UILabel *messageTipLabel;

@end

@implementation CQFilesLookBadgeCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectedBackgroundView = ({
            UIView *view = [UIView new];
            view.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0]; //#f4f4f4
            view;
        });
        
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [self addSubview:self.titleNameLabel];
    [self addSubview:self.iconImageView];
    [self addSubview:self.messageTipLabel];

    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.left.mas_equalTo(self).mas_offset(15);
        make.top.mas_equalTo(self).mas_offset(8);
        //make.centerY.mas_equalTo(self).mas_offset(-4);
        make.height.mas_equalTo(self.iconImageView.mas_width).multipliedBy(1.0);
    }];
    [self.titleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.left.mas_equalTo(self);
        make.bottom.mas_equalTo(self).mas_offset(0);
    }];
    [self.messageTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.iconImageView.mas_right);
        make.centerY.mas_equalTo(self.iconImageView.mas_top);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
    }];
}

- (void)setupBadgeCount:(NSInteger)badgeCount withMaxNumber:(NSInteger)maxCount {
    _badgeCount = badgeCount;
    
    if (badgeCount <= 0) {
        self.messageTipLabel.text = @"";
        return;
    }
    
    self.messageTipLabel.hidden = NO;
    
    NSString *badgeString = [NSString stringWithFormat:@"%@", @(badgeCount)];
    if (badgeCount > maxCount) {
        badgeString = [NSString stringWithFormat:@"%ld+", maxCount];
    }
    self.messageTipLabel.text = badgeString;
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
        _titleNameLabel.adjustsFontSizeToFitWidth = YES;
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

@synthesize messageTipLabel = _messageTipLabel;
- (UILabel *)messageTipLabel {
    if (!_messageTipLabel) {
        _messageTipLabel = [[UILabel alloc] init];
        _messageTipLabel.backgroundColor = [UIColor redColor]; //#ff0000
        _messageTipLabel.textColor = [UIColor whiteColor];  // (@"#FFFFFF");
        _messageTipLabel.font = [UIFont systemFontOfSize:11];
        _messageTipLabel.textAlignment = NSTextAlignmentCenter;
        _messageTipLabel.layer.cornerRadius = 7;
        _messageTipLabel.clipsToBounds = YES;
        _messageTipLabel.hidden = YES;
    }
    return _messageTipLabel;
}

@end
