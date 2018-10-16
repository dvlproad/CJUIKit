//
//  UIColor+CJHex.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  1.返回一个RGB格式的UIColor对象
 */
#define CJRGB(r, g, b) CJRGBA(r, g, b, 1.0f)

/**
 *  2.返回一个RGBA格式的UIColor对象
 */
#define CJRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]


/**
 *  3.支持使用16进制数值/字符串来选取颜色
 */
#define CJColorFromHexString(color)     [UIColor cjColorWithHexString:color]
#define CJColorFromHexValue(s)          [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]

#define CJColorFromHexStringAndAlpha(color, a)  [UIColor cjColorWithHexString:color alpha:a]

/**
 *  一个随机颜色
 */
#define CJColorRandom       CJRGBA(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


@interface UIColor (CJHex)

/**
 *  初始化颜色(从十六进制字符串获取颜色)
 *
 *  @param color    颜色的值（支持@“#123456”、 @“0X123456”、 @“123456”三种格式），默认alpha值为1
 *
 *  return  颜色
 */
+ (UIColor *)cjColorWithHexString:(NSString *)color;

/**
 *  初始化颜色(从十六进制字符串获取颜色)
 *
 *  @param color    颜色的值（支持@“#123456”、 @“0X123456”、 @“123456”三种格式）
 *  @param alpha    alpha
 *
 *  return  颜色
 */
+ (UIColor *)cjColorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
