//
//  DemoLabelFactory.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "CJLabel.h"

@interface DemoLabelFactory : NSObject

+ (UILabel *)whiteLabelWithCornerRadius:(CGFloat)cornerRadius;
//+ (CJLabel *)trackLabel;

+ (UILabel *)cyanLabelWithText:(NSString *)text;
+ (UILabel *)testExplainLabel;

@end
