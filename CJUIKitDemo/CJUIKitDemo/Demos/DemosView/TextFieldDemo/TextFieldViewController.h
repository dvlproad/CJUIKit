//
//  TextFieldViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJChooseTextTextField.h"
#import "CJExtraTextTextField.h"

@interface TextFieldViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *textField;

@property (nonatomic, weak) IBOutlet UISwitch *canInputSwitch;  //控制是否允许文本框输入的开关
@property (nonatomic, weak) IBOutlet CJChooseTextTextField *canInputTextField;
@property (nonatomic, weak) IBOutlet CJExtraTextTextField *extraTextTextField;


@end
