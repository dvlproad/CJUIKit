//
//  UITextField+CJAddInputAccessoryView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/10/16.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJDefaultToolbar.h"

@interface UITextField (CJAddInputAccessoryView)

- (void)addDefaultInputAccessoryViewWithDoneButtonClickBlock:(void (^)(UITextField *textField))doneButtonClickBlock;

@end
