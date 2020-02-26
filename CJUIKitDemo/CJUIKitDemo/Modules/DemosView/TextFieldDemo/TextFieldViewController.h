//
//  TextFieldViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "CJUIKitBaseScrollViewController.h"
#import "CJExtraTextTextField.h"
#import "DemoTextFieldFactory.h"

@interface TextFieldViewController : CJUIKitBaseScrollViewController

@property (nonatomic, strong) UITextField *uiTextField;

@property (nonatomic, strong) CJTextField *cjTextField;
@property (nonatomic, strong) UIButton *changeTFSecureButton;

@property (nonatomic, strong) CJTextField *canInputTextField;
@property (nonatomic, strong) UISwitch *canInputSwitch;

@property (nonatomic, strong) CJExtraTextTextField *extraTextTextField;


@end
