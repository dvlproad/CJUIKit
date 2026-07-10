//
//  CJUIKitCollectionViewHeader.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/5/22.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CJUIKitCollectionViewHeader.h"
#import <Masonry/Masonry.h>

@implementation CJUIKitCollectionViewHeader

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
        _titleNameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]; //#333333
        _titleNameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleNameLabel;
}

@end
