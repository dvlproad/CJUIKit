//
//  CQTSTestMethodTableHeaderView.m
//  CJUIKitDemo
//
//  Copyright © 2016 dvlproad. All rights reserved.
//

#import "CQTSTestMethodTableHeaderView.h"
#import <Masonry/Masonry.h>

static NSString * const kLegendDescText = @"1、每张卡片已提供默认输入值和对应的正确结果。\n2、你需要自行实现方法，使得该方法所得的结果与正确结果一致。\n3、你的方法结果与正确结果是否一致，即代表着你实现的方法是否有问题。\n附：结果是否一致，请看结果区颜色：";

@implementation CQTSTestMethodTableHeaderView

+ (CGFloat)headerHeightForWidth:(CGFloat)width {
    CGFloat titleHeight = 28;
    CGFloat dotsHeight = 26;
    CGRect descRect = [kLegendDescText boundingRectWithSize:CGSizeMake(width - 32, CGFLOAT_MAX)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:11]}
                                                   context:nil];
    CGFloat descHeight = ceil(descRect.size.height);
    return titleHeight + 4 + descHeight + 8 + dotsHeight + 10;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.backgroundColor = [UIColor clearColor];

    UILabel *legendTitle = [[UILabel alloc] init];
    legendTitle.text = @"验证【你的方法实现是否有误】的方法：";
    legendTitle.font = [UIFont systemFontOfSize:13 weight:UIFontWeightSemibold];
    legendTitle.textColor = [UIColor darkGrayColor];
    [self addSubview:legendTitle];

    UILabel *legendDesc = [[UILabel alloc] init];
    legendDesc.text = kLegendDescText;
    legendDesc.font = [UIFont systemFontOfSize:11];
    legendDesc.textColor = [UIColor grayColor];
    legendDesc.numberOfLines = 0;
    legendDesc.lineBreakMode = NSLineBreakByWordWrapping;
    [self addSubview:legendDesc];

    CGFloat dotSize = 8;

    UIView *greenDot = [UIView new];
    greenDot.backgroundColor = [UIColor colorWithRed:0.30 green:0.75 blue:0.40 alpha:1.0];
    greenDot.layer.cornerRadius = dotSize / 2.0;
    [self addSubview:greenDot];
    UILabel *greenText = [[UILabel alloc] init];
    greenText.text = @"正确";
    greenText.font = [UIFont systemFontOfSize:11];
    greenText.textColor = [UIColor darkGrayColor];
    [self addSubview:greenText];

    UIView *redDot = [UIView new];
    redDot.backgroundColor = [UIColor colorWithRed:0.90 green:0.25 blue:0.25 alpha:1.0];
    redDot.layer.cornerRadius = dotSize / 2.0;
    [self addSubview:redDot];
    UILabel *redText = [[UILabel alloc] init];
    redText.text = @"错误";
    redText.font = [UIFont systemFontOfSize:11];
    redText.textColor = [UIColor darkGrayColor];
    [self addSubview:redText];

    UIView *blueDot = [UIView new];
    blueDot.backgroundColor = [UIColor colorWithRed:0.55 green:0.65 blue:0.90 alpha:1.0];
    blueDot.layer.cornerRadius = dotSize / 2.0;
    [self addSubview:blueDot];
    UILabel *blueText = [[UILabel alloc] init];
    blueText.text = @"原始值已变更，请自行验证下面结果是否正确";
    blueText.font = [UIFont systemFontOfSize:11];
    blueText.textColor = [UIColor darkGrayColor];
    [self addSubview:blueText];

    UIView *yellowDot = [UIView new];
    yellowDot.backgroundColor = [UIColor colorWithRed:0.90 green:0.75 blue:0.30 alpha:1.0];
    yellowDot.layer.cornerRadius = dotSize / 2.0;
    [self addSubview:yellowDot];
    UILabel *yellowText = [[UILabel alloc] init];
    yellowText.text = @"未设置期望结果，请自行验证下面结果是否正确";
    yellowText.font = [UIFont systemFontOfSize:11];
    yellowText.textColor = [UIColor darkGrayColor];
    [self addSubview:yellowText];

    // Masonry 布局
    [legendTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(10);
        make.left.mas_equalTo(self).mas_offset(16);
        make.right.mas_lessThanOrEqualTo(self).mas_offset(-16);
    }];

    [legendDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(legendTitle.mas_bottom).mas_offset(4);
        make.left.mas_equalTo(self).mas_offset(16);
        make.right.mas_lessThanOrEqualTo(self).mas_offset(-16);
    }];

    // 色块行
    [greenDot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(legendDesc.mas_bottom).mas_offset(8);
        make.left.mas_equalTo(self).mas_offset(16);
        make.width.height.mas_equalTo(dotSize);
    }];
    [greenText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(greenDot);
        make.left.mas_equalTo(greenDot.mas_right).mas_offset(5);
    }];

    [redDot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(greenDot);
        make.left.mas_equalTo(greenText.mas_right).mas_offset(16);
        make.width.height.mas_equalTo(dotSize);
    }];
    [redText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(greenDot);
        make.left.mas_equalTo(redDot.mas_right).mas_offset(5);
    }];

    [blueDot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(greenDot);
        make.left.mas_equalTo(redText.mas_right).mas_offset(16);
        make.width.height.mas_equalTo(dotSize);
    }];
    [blueText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(greenDot);
        make.left.mas_equalTo(blueDot.mas_right).mas_offset(5);
    }];

    [yellowDot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(greenDot.mas_bottom).mas_offset(6);
        make.left.mas_equalTo(self).mas_offset(16);
        make.width.height.mas_equalTo(dotSize);
    }];
    [yellowText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(yellowDot);
        make.left.mas_equalTo(yellowDot.mas_right).mas_offset(5);
        make.right.mas_lessThanOrEqualTo(self).mas_offset(-16);
        make.bottom.mas_equalTo(self).mas_offset(-10);
    }];
}

@end
