//
//  TextViewVerticalCenterViewController1.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "TextViewVerticalCenterViewController1.h"
#import "TSButtonFactory.h"
#import "UIButton+CJMoreProperty.h"

#import "UIVerticalCenterTextView.h"

@interface TextViewVerticalCenterViewController1 () {
    
}

@end

@implementation TextViewVerticalCenterViewController1

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
//    [self.textView1 cj_adjustedContentInsetToTextCenter:2];
//    [self.textView2 cj_adjustedContentInsetToTextCenter:0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = NSLocalizedString(@"UIVerticalCenterTextView文字竖直居中", nil);
    
    [self setupViews];
}

- (void)setupViews {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = @"测试UIVerticalCenterTextView文字竖直居中";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(60);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.mas_topLayoutGuide).mas_offset(40);
        make.height.mas_greaterThanOrEqualTo(40);
    }];
    
    UIVerticalCenterTextView *textView1 = [[UIVerticalCenterTextView alloc] init];
    textView1.text = @"生活";
    [self.view addSubview:textView1];
    [textView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label);
        make.centerX.mas_equalTo(label);
        make.top.mas_equalTo(label.mas_bottom).mas_offset(20);
        make.height.mas_greaterThanOrEqualTo(100);
    }];
    // 1、测试 mas_makeConstraints 时候的文本竖直居中
    [textView1 uiTextView_adjustedContentInsetToTextCenter:0];
    
    
    
    // 2、测试 mas_updateConstraints 时候的文本竖直居中
    UIButton *button1 = [TSButtonFactory themeBGButton];
    [button1 setTitle:@"测试 mas_updateConstraints 时候的文本竖直居中" forState:UIControlStateNormal];
    [button1.titleLabel setFont:[UIFont systemFontOfSize:14]];
    button1.titleLabel.minimumScaleFactor = 0.3;
    [self.view addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(textView1.mas_bottom).mas_offset(24);
        make.height.mas_greaterThanOrEqualTo(44);
    }];
    button1.cjTouchUpInsideBlock = ^(UIButton *button) {
        // 测试 mas_updateConstraints 时候的文本竖直居中
        CGFloat randomHeight = 60+random()%200;
        [textView1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_greaterThanOrEqualTo(randomHeight);
        }];
        [textView1 uiTextView_adjustedContentInsetToTextCenter:0.2];
    };
}


-  (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
