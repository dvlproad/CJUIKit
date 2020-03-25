//
//  LEMenuCollectionViewCell.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/5/21.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "LEMenuCollectionViewCell.h"
#import <CJBaseUIKit/UIColor+CJHex.h>

CGFloat const LEWorkFunctionItemCellWidth = 93.75;
CGFloat const LEWorkFunctionItemCellHeight = 87;

static const CGFloat Interval_Size_5 = 5.0f;
static const CGFloat Icon_Size_Width = 42.0f;
static const CGFloat Icon_Size_Height = 42.0f;
//static const CGFloat TitleLabel_Size_Height = 20.0f;

@interface LEMenuCollectionViewCell () {
    
}
@property (nonatomic, strong) UILabel *messageTipLabel;

@end

@implementation LEMenuCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectedBackgroundView = ({
            UIView *view = [UIView new];
            view.backgroundColor = CJColorFromHexString(@"#f4f4f4");
            view;
        });
        
        [self createSubViews];
        [self createAutoLayout];
    }
    return self;
}

- (void)createSubViews {
    [self addSubview:self.titleNameLabel];
    [self addSubview:self.iconImageView];
    [self addSubview:self.messageTipLabel];
}

- (void)createAutoLayout {
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).mas_offset(5);
        make.width.equalTo(@(Icon_Size_Width));
        make.height.equalTo(@(Icon_Size_Height));
    }];
    [self.titleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImageView.mas_bottom).offset(Interval_Size_5);
        make.centerX.mas_equalTo(self);
        make.width.mas_lessThanOrEqualTo(self.mas_width).mas_offset(-10);
    }];
    [self.messageTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.iconImageView.mas_right);
        make.centerY.mas_equalTo(self.iconImageView.mas_top);
        make.width.mas_greaterThanOrEqualTo(14);
    }];
}

- (void)displayMessageWithCount:(NSInteger)messageCount {
    if (messageCount <= 0) {
        return;
    }
    else {
        self.messageTipLabel.hidden = NO;
        if (messageCount < 10) {
            self.messageTipLabel.text = [NSString stringWithFormat:@"%@",@(messageCount)];
        }
        else if (messageCount < 100) {
            self.messageTipLabel.text = [NSString stringWithFormat:@"%@ ", @(messageCount)];
        }
        else {
            self.messageTipLabel.text = @"99+  ";
        }
    }
}

#pragma mark - lazy init
@synthesize titleNameLabel = _titleNameLabel;
- (UILabel *)titleNameLabel {
    if (!_titleNameLabel) {
        _titleNameLabel = [[UILabel alloc] init];
        _titleNameLabel.backgroundColor = [UIColor clearColor];
        _titleNameLabel.textColor = CJColorFromHexString(@"#666666");
        _titleNameLabel.font = [UIFont systemFontOfSize:13];
        _titleNameLabel.textAlignment = NSTextAlignmentCenter;
        _titleNameLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _titleNameLabel;
}

@synthesize iconImageView = _iconImageView;
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.backgroundColor = [UIColor clearColor];
    }
    return _iconImageView;
}

@synthesize messageTipLabel = _messageTipLabel;
- (UILabel *)messageTipLabel {
    if (!_messageTipLabel) {
        _messageTipLabel = [[UILabel alloc] init];
        _messageTipLabel.backgroundColor = CJColorFromHexString(@"#ff0000");
        _messageTipLabel.textColor = CJColorFromHexString(@"#ffffff");
        _messageTipLabel.font = [UIFont systemFontOfSize:11];
        _messageTipLabel.textAlignment = NSTextAlignmentCenter;
        _messageTipLabel.layer.cornerRadius = 7;
        _messageTipLabel.clipsToBounds = YES;
        _messageTipLabel.hidden = YES;
    }
    return _messageTipLabel;
}

@end
