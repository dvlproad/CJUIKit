//
//  CQTSMinusAddView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 12/7/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "CQTSMinusAddView.h"
#import <Masonry/Masonry.h>

@interface CQTSMinusAddView () {
    
}
@property (nonatomic, copy) void(^minusHandle)(UIButton *button);
@property (nonatomic, copy) void(^addHandle)(UIButton *button);

@end

@implementation CQTSMinusAddView

#pragma mark - Init
/*
 *  初始化
 *
 *  @param minusHandle      左侧"-"按钮的点击事件
 *  @param addHandle        右侧"+"按钮的点击事件
 *
 *  @return 中间是文本框，左侧"-"按钮，右侧"+"按钮 的视图
 */
- (instancetype)initWithMinusHandle:(void(^)(UIButton *button))minusHandle
                          addHandle:(void(^)(UIButton *button))addHandle {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.minusHandle = minusHandle;
        self.addHandle = addHandle;
        [self setupViews];
    }
    return self;
}

#pragma mark - Setter
- (void)setText:(NSString *)text {
    _text = text;
    self.textField.text = text;
}

#pragma mark - SetupViews
- (void)setupViews {
    NSString *bundleName = @"CQDemoKit_TestMethod";
    NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
    NSURL *bundleURL = [frameworkBundle URLForResource:bundleName withExtension:@"bundle"];
    NSBundle *resourceBundle = bundleURL ? [NSBundle bundleWithURL:bundleURL] : nil;
    
    // 中间的文本框
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
    textField.textAlignment = NSTextAlignmentCenter;
    textField.backgroundColor = UIColor.whiteColor;
    
    // 左侧"-"按钮
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.backgroundColor = [UIColor orangeColor];
    UIImage *leftNormalImage = [UIImage imageNamed:@"minus_common_icon" inBundle:resourceBundle compatibleWithTraitCollection:nil];
    [leftButton setImage:leftNormalImage forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(minusAction:) forControlEvents:UIControlEventTouchUpInside];
    // 右侧"+"按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.backgroundColor = [UIColor orangeColor];
    UIImage *rightNormalImage = [UIImage imageNamed:@"add_common_icon" inBundle:resourceBundle compatibleWithTraitCollection:nil];
    [rightButton setImage:rightNormalImage forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:leftButton];
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(self);
    }];
    
    [self addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(self);
    }];
    
    [self addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftButton.mas_right).mas_equalTo(0);
        make.right.mas_equalTo(rightButton.mas_left).mas_equalTo(-0);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];

    self.textField = textField;
}

#pragma mark - Action
- (void)minusAction:(UIButton *)button {
    !self.minusHandle ?: self.minusHandle(button);
}

- (void)addAction:(UIButton *)button {
    !self.addHandle ?: self.addHandle(button);
}



@end
