//
//  LECollectionHeader.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/5/22.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "LECollectionHeader.h"
#import <CJBaseUIKit/UIColor+CJHex.h>

@implementation LECollectionHeader

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createSubViews];
        [self createAutoLayout];
    }
    return self;
}

- (void)createSubViews {
    [self addSubview:self.titleNameLabel];
}

- (void)createAutoLayout {
    [self.titleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self).mas_offset(15);
    }];
}

#pragma mark - lazy init

@synthesize titleNameLabel = _titleNameLabel;
- (UILabel *)titleNameLabel {
    if (!_titleNameLabel) {
        _titleNameLabel = [[UILabel alloc] init];
        _titleNameLabel.backgroundColor = [UIColor clearColor];
        _titleNameLabel.textColor = CJColorFromHexString(@"#333333");
        _titleNameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleNameLabel;
}

@end
