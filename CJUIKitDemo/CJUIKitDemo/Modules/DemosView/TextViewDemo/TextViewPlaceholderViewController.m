//
//  TextViewPlaceholderViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "TextViewPlaceholderViewController.h"
#import "CJTextView.h"
#import <CJFoundation/NSString+CJTextSizeInView.h>

@implementation TextViewPlaceholderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = NSLocalizedString(@"TextView占位符", nil);
    
    CJTextView *textView1 = [[CJTextView alloc] init];
    textView1.text = nil;
    textView1.placeholder = @"请输入生活";
    [self.view addSubview:textView1];
    [textView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(60);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.mas_topLayoutGuide).mas_offset(24);
        make.height.mas_greaterThanOrEqualTo(100);
    }];
    
    
    CJTextView *textView2 = [[CJTextView alloc] init];
    textView2.text = @"总感觉看得见的生活在";
    textView2.placeholder = @"请输入总感觉看得见的生活在";
    [self.view addSubview:textView2];
    [textView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(60);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(textView1.mas_bottom).mas_offset(24);
        make.height.mas_greaterThanOrEqualTo(100);
    }];
    
    
    CJTextView *textView3 = [[CJTextView alloc] init];
    textView3.text = nil;
    textView3.placeholder = @"凡事都有一定的定数，我们只不过在自己的人行道上重复了虚幻中看到的方向，然后一步步向前，直到路的尽头。";
    textView3.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:textView3];
    [textView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(60);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(textView2.mas_bottom).mas_offset(24);
        make.height.mas_equalTo(140);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //CGFloat maxWidth = textView3.bounds.size.width;
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width - 2*60;
        
        CGFloat placeholderHeight = [textView3.placeholder cjTextHeightInTextViewWithMaxWidth:maxWidth font:textView3.font];
        [textView3 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(placeholderHeight);
        }];
    });
    
    
    CJTextView *textView4 = [[CJTextView alloc] init];
    textView4.text = nil;
    textView4.placeholder = @"TODO:待修复《虽然我是placeholder，但是textView的大小被我撑大了》总感觉看得见的生活在我的记忆中没有痕迹，稍纵即逝。也许这样的方式对其他人人来说有点虚无，但是对于我来说是最合适的不过的。喜欢没有方向的风，这样就不会顺着它的脾气，丢失了自己的本真，我想我可以在凌乱的风中找到适合自己的方向，笑逐颜开，尽管会很难，但是花开的季节，我能看见的除了它的美丽，还有它的消亡，记忆是一种过程，还是一种很混乱的过程，我试着理清思绪，但到头来我理清的除了比混乱还混乱的思绪，看见的还是混乱的思绪，也许我该明白有些东西真的不是说你想要如何就能如何的，凡事都有一定的定数，我们只不过在自己的人行道上重复了虚幻中看到的方向，然后一步步向前，直到路的尽头。";
    [self.view addSubview:textView4];
    [textView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(60);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(textView3.mas_bottom).mas_offset(24);
        make.height.mas_greaterThanOrEqualTo(100);
    }];
  
}


-  (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
