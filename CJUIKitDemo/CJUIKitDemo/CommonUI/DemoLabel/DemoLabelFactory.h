//
//  DemoLabelFactory.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#ifdef TEST_CJBASEUIKIT_POD
#import "CJLabel.h"
#else
#import <CJBaseUIKit/CJLabel.h>
#endif


@interface DemoLabelFactory : NSObject

+ (UILabel *)whiteLabelWithCornerRadius:(CGFloat)cornerRadius;
//+ (CJLabel *)trackLabel;

+ (UILabel *)cyanLabelWithText:(NSString *)text;
+ (UILabel *)testExplainLabel;

@end
