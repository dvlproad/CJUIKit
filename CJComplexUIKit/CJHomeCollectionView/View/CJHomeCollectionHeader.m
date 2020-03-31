//
//  CJHomeCollectionHeader.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/5/22.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CJHomeCollectionHeader.h"
#import <Masonry/Masonry.h>

@implementation CJHomeCollectionHeader

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [self addSubview:self.titleNameLabel];
    [self.titleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self).mas_offset(15);
    }];
    
    //TEST:测试添加背景
    UIImageView *moveImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    moveImageView.image = [UIImage imageNamed:@"bg.jpg"];
    [self addSubview:moveImageView];
    [moveImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(10);
        make.right.mas_equalTo(self).mas_offset(-10);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(80);
    }];
    UILongPressGestureRecognizer *moveGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(moveAction)];
    moveGR.minimumPressDuration = 0.3;
    [moveImageView addGestureRecognizer:moveGR];
}

- (void)moveAction:(UILongPressGestureRecognizer *)moveLongPressGR {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kHeaderCJMoveDecorationAction" object:moveLongPressGR];
}

#pragma mark - lazy init

@synthesize titleNameLabel = _titleNameLabel;
- (UILabel *)titleNameLabel {
    if (!_titleNameLabel) {
        _titleNameLabel = [[UILabel alloc] init];
        _titleNameLabel.backgroundColor = [UIColor clearColor];
        _titleNameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]; //#333333
        _titleNameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleNameLabel;
}

@end
