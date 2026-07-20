//
//  TSTextFieldClickViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//
//  测试文本框自身点击的弹出、属于文本框的左右按钮的点击等

#import "CJUIKitBaseScrollViewController.h"
#import <CQBaseUIKit/DemoTextFieldFactory.h>

@interface TSTextFieldClickViewController : CJUIKitBaseScrollViewController

@property (nonatomic, strong) CJTextField *cjTextField;
@property (nonatomic, strong) UIButton *changeTFSecureButton;

@property (nonatomic, strong) CJTextField *canInputTextField;
@property (nonatomic, strong) UISwitch *canInputSwitch;


@end
