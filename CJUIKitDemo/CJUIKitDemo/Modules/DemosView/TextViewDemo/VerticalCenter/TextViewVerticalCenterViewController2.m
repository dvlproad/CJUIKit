//
//  TextViewVerticalCenterViewController2.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "TextViewVerticalCenterViewController2.h"
#import "TSButtonFactory.h"
#import "UIButton+CJMoreProperty.h"

#import "UIVerticalCenterTextView.h"
#import "CJVerticalCenterTextView.h"

@interface TextViewVerticalCenterViewController2 () {
    
}
@property (nonatomic, strong) CJVerticalCenterTextView *textView2;

@end

@implementation TextViewVerticalCenterViewController2

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
//    [self.textView1 cj_adjustedContentInsetToTextCenter:2];
//    [self.textView2 cj_adjustedContentInsetToTextCenter:0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = NSLocalizedString(@"CJVerticalCenterTextView文字竖直居中", nil);
    
    
    [self setupViews];
    
}


- (void)setupViews {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = @"测试placeholder没把其父视图textView撑大的时候";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(60);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.mas_topLayoutGuide).mas_offset(40);
        make.height.mas_greaterThanOrEqualTo(40);
    }];
    
    CJVerticalCenterTextView *textView2 = [[CJVerticalCenterTextView alloc] init];
    textView2.text = @"也许我该明白有些东西真的不是说你想要如何就能如何的，凡事都有一定的定数，";
//    textView2.placeholder = @"憬，总感觉看得见的生活在我的记忆中没有痕迹，稍纵即逝。也许这样的方式对其他人人来说有点虚无，但是对于我来说是最合适的不过的。喜欢没有方向的风，这样就不会顺着它的脾气，丢失了自己的本真，我想我可以在凌乱的风中找到适合自己的方向，笑逐颜开，尽管会很难，但是花开的季节，我能看见的除了它的美丽，还有它的消亡，记忆是一种过程，还是一种很混乱的过程，我试着理清思绪，但到头来我理清的除了比混乱还混乱的思绪，看见的还是混乱的思绪，也许我该明白有些东西真的不是说你想要如何就能如何的，凡事都有一定的定数，我们只不过在自己的人行道上重复了虚幻中看到的方向，然后一步步向前，直到路的尽头。";
    textView2.placeholder = @"测试placeholder没把其父视图textView撑大的时候";
    [self.view addSubview:textView2];
    [textView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label);
        make.centerX.mas_equalTo(label);
        make.top.mas_equalTo(label.mas_bottom).mas_offset(20);
        make.height.mas_greaterThanOrEqualTo(150);
    }];
    self.textView2 = textView2;
    

    // 2、测试 mas_updateConstraints 时候的文本竖直居中
    UIButton *button2 = [TSButtonFactory themeBGButton];
    [button2 setTitle:@"测试 mas_updateConstraints 时候的文本竖直居中" forState:UIControlStateNormal];
    [button2.titleLabel setFont:[UIFont systemFontOfSize:14]];
    button2.titleLabel.minimumScaleFactor = 0.3;
    [self.view addSubview:button2];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(textView2.mas_bottom).mas_offset(20);
        make.height.mas_greaterThanOrEqualTo(44);
    }];
    button2.cjTouchUpInsideBlock = ^(UIButton *button) {
        // 测试 mas_updateConstraints 时候的文本竖直居中
        CGFloat randomHeight = 60+random()%200;
        [textView2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_greaterThanOrEqualTo(randomHeight);
        }];
        
        [textView2 cjTextView_adjustedContentInsetToTextCenter:0];
    };
}


-  (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
