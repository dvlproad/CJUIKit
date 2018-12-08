//
//  TextFieldViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "CJUIKitBaseScrollViewController.h"
#import "CJChooseTextTextField.h"
#import "CJExtraTextTextField.h"

@interface TextFieldViewController : CJUIKitBaseScrollViewController

@property (nonatomic, strong) UITextField *uiTextField;

@property (nonatomic, strong) CJTextField *cjTextField;
@property (nonatomic, strong) UIButton *changeTFSecureButton;

@property (nonatomic, strong) CJChooseTextTextField *canInputTextField;
@property (nonatomic, strong) UISwitch *canInputSwitch;

@property (nonatomic, strong) CJExtraTextTextField *extraTextTextField;


@end
