//
//  CJAlumbImageUtil.h
//  CJPickerDemo
//
//  Created by 李超前 on 2017/11/10.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

///本类中的image用法均来自CJBaseUIKit中的UIImage+CJCategory部分
@interface CJAlumbImageUtil : NSObject

+ (UIImage *)cj_fixOrientation:(UIImage *)image; //来自#import "UIImage+CJFixOrientation.h"

+ (UIImage *)cj_changeImage:(UIImage *)image withTintColor:(UIColor *)tintColor;//来自#import "UIImage+CJChangeColor.h"

@end
