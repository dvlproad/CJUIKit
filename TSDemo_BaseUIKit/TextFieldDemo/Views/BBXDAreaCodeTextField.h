//
//  BBXDAreaCodeTextField.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/5/7.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJTextField.h"

@interface BBXDAreaCodeTextField : CJTextField

@property (nonatomic, copy) void (^chooseAreaCodeBlock)(BBXDAreaCodeTextField *textField);

@end
