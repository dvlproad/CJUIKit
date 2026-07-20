//
//  TSPinyinUtilViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/12/1.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "TSPinyinUtilViewController.h"
#import <CJBaseUtil/CJPinyinHelper.h>

#import "CJSortUtil.h"

@interface TSPinyinUtilViewController ()

@property (nonatomic, strong) UITextView *originTextView;
@property (nonatomic, strong) UITextView *lastTextView;

@end

@implementation TSPinyinUtilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.667 alpha:1.0];
    
    // originTextView
    self.originTextView = [[UITextView alloc] init];
    self.originTextView.backgroundColor = [UIColor whiteColor];
    self.originTextView.font = [UIFont systemFontOfSize:14];
    self.originTextView.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    self.originTextView.text = @"厦门这个地方是个多音字";
    [self.view addSubview:self.originTextView];
    [self.originTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(48);
        make.top.mas_equalTo(67);
        make.width.mas_equalTo(278);
        make.height.mas_equalTo(105);
    }];
    
    // button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [UIColor colorWithRed:0.2 green:0.533 blue:1.0 alpha:1.0];
    [button setTitle:@"转化上面的文字为拼音" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(changeToPlacePinyin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(65);
        make.top.mas_equalTo(180);
        make.width.mas_equalTo(245);
        make.height.mas_equalTo(30);
    }];
    
    // lastTextView
    self.lastTextView = [[UITextView alloc] init];
    self.lastTextView.backgroundColor = [UIColor whiteColor];
    self.lastTextView.font = [UIFont systemFontOfSize:14];
    self.lastTextView.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    [self.view addSubview:self.lastTextView];
    [self.lastTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(48);
        make.top.mas_equalTo(218);
        make.width.mas_equalTo(278);
        make.height.mas_equalTo(105);
    }];
    
    NSMutableArray *mutableArray = @[@(4), @(7), @(6), @(5), @(3), @(2), @(8), @(1)].mutableCopy;
    [CJSortUtil quickSortArray:mutableArray withLeftIndex:0 andRightIndex:mutableArray.count-1];
    NSLog(@"mutableArray = %@", mutableArray);
}

- (void)changeToPlacePinyin:(id)sender {
    NSString *originText = self.originTextView.text;
    NSString *lastText = [CJPinyinHelper placePinyinFromChineseString:originText];
    self.lastTextView.text = lastText;
}

@end
