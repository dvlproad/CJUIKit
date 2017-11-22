//
//  KeyboardAvoidingViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+CJKeyboardAvoiding.h"

@interface KeyboardAvoidingViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@property (nonatomic, weak) IBOutlet UITextField *textField;

@end
