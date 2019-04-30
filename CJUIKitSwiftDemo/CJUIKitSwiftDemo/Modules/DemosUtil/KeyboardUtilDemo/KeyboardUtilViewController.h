//
//  KeyboardUtilViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/1/23.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJKeyboardUtil.h"

@interface KeyboardUtilViewController : UIViewController {
    
}
@property (nonatomic, strong) CJKeyboardUtil *keyboardUtil;

@property (nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@end
