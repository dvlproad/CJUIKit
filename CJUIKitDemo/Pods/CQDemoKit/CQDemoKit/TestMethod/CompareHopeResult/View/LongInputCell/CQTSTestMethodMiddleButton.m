//
//  CQTSTestMethodMiddleButton.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/12/29.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CQTSTestMethodMiddleButton.h"

@interface CQTSTestMethodMiddleButton () {
    
}
@property (nonatomic, strong) UIButton *validateButton;
@property (nonatomic, copy) void(^tapAction)(void);

@end

@implementation CQTSTestMethodMiddleButton

- (instancetype)initWithTapAction:(void(^)(void))tapAction {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.tapAction = tapAction;
        
        self.backgroundColor = [[UIColor colorWithRed:0.20 green:0.60 blue:0.86 alpha:1.0] colorWithAlphaComponent:0.9];
        self.layer.cornerRadius = 6;
        self.layer.masksToBounds = YES;

        // 从 resource bundle 加载图片
        NSString *bundleName = @"CQDemoKit_TextView";
        NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
        NSURL *bundleURL = [frameworkBundle URLForResource:bundleName withExtension:@"bundle"];
        NSBundle *resourceBundle = bundleURL ? [NSBundle bundleWithURL:bundleURL] : nil;

        // 箭头图片的AI生成参考本文件尾部
        UIImage *arrowImage = [UIImage imageNamed:@"arrow_dash_01.png" inBundle:resourceBundle compatibleWithTraitCollection:nil];
        CGFloat leftCap = 20;
        CGFloat rightCap = 20;
        CGFloat topInset = arrowImage.size.height * 0.3;
        CGFloat bottomInset = arrowImage.size.height * 0.3;
        UIImage *stretchImage = [arrowImage resizableImageWithCapInsets:UIEdgeInsetsMake(topInset, leftCap, bottomInset, rightCap)
                                                          resizingMode:UIImageResizingModeStretch];

        UIImageView *imageView = [[UIImageView alloc] initWithImage:stretchImage];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:imageView];
        [NSLayoutConstraint activateConstraints:@[
            [imageView.topAnchor constraintEqualToAnchor:self.topAnchor],
            [imageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
            [imageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
            [imageView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor]
        ]];

        // 按钮（盖在箭头上面）
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.8] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateHighlighted];
        [button.titleLabel setFont:[UIFont systemFontOfSize:15 weight:UIFontWeightSemibold]];
        [button.titleLabel setMinimumScaleFactor:0.4];
        [button.titleLabel setAdjustsFontSizeToFitWidth:YES];
        [button addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:button];
        [NSLayoutConstraint activateConstraints:@[
            [button.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
            [button.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
            [button.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:20],
            [button.topAnchor constraintEqualToAnchor:self.topAnchor constant:5]
        ]];
        self.validateButton = button;
        
        
        self.backgroundColor = [[UIColor colorWithRed:0.20 green:0.60 blue:0.86 alpha:1.0] colorWithAlphaComponent:0.3];
        
        button.backgroundColor = [[UIColor colorWithRed:0.20 green:0.60 blue:0.86 alpha:1.0] colorWithAlphaComponent:0.9];;
        button.layer.cornerRadius = 6;
        button.layer.masksToBounds = YES;
    }
    return self;
}

#pragma mark - Config
- (void)configTitle:(NSString *)title {
    [self.validateButton setTitle:[NSString stringWithFormat:@"▶ %@", title] forState:UIControlStateNormal];
}

- (void)buttonTapped {
    !self.tapAction ?: self.tapAction();
}

@end

/*
尺寸: 280 x 44 像素
背景: 透明PNG
布局结构:
- 左右两侧各留20像素宽度，画完整箭头（从顶部到底部连续）
- 中间240像素宽度，分三部分：
- 上方30%区域：小箭头（虚线+箭头头部）
- 中间40%区域：完全透明（留给按钮）
- 下方30%区域：小箭头（虚线+箭头头部）
箭头样式:
- 颜色：纯黑色
- 线宽：1像素
- 虚线：5像素线段，3像素间隔
- 箭头头部：两条斜线组成的V形（类似↘↙），不填充
- 箭头头部大小：4像素
箭头网格:
- 间距：18像素
- 总共约15列箭头
- 两侧各1列完整箭头
- 中间13列被透明区域分成上下两段
用途: 作为中间区域的背景图，透明部分放置按钮，按钮点击后执行操作
视觉效果:
↓ ↓ ↓ ↓ ↕ ↕ ↕ ↕ ↕ ↕ ↕ ↕ ↕ ↕ ↕ ↕ ↓ ↓ ↓ ↓
↓ ↓ ↓ ↓                         ↓ ↓ ↓ ↓
↓ ↓ ↓ ↓ ↕ ↕ ↕ ↕ ↕ ↕ ↕ ↕ ↕ ↕ ↕ ↕ ↓ ↓ ↓ ↓
技术规格:
- 格式：PNG with alpha channel
- 色彩模式：RGBA
- 分辨率：1x, 2x, 3x 三套
*/
