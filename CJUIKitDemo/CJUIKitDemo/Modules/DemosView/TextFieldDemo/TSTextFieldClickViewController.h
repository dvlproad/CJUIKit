//
//  TSTextFieldClickViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "CJUIKitBaseScrollViewController.h"
#import "DemoTextFieldFactory.h"

@interface TSTextFieldClickViewController : CJUIKitBaseScrollViewController

@property (nonatomic, strong) CJTextField *cjTextField;
@property (nonatomic, strong) UIButton *changeTFSecureButton;

@property (nonatomic, strong) CJTextField *canInputTextField;
@property (nonatomic, strong) UISwitch *canInputSwitch;


@end
