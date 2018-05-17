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
#define CJColorFromHexString(color) [UIColor cjColorWithHexString:color] //方法①

#define CJColorFromHexValue(s)      [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]          //方法②


/**
 *  一个随机颜色
 */
#define CJColorRandom       CJRGBA(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#define CJColorRed          CJColorFromHexString(@"#ff4343")

#define CJColorGreenDark1   CJColorFromHexString(@"#149B8A")
#define CJColorGreenDark2   CJColorFromHexString(@"#149B17")

#define CJColorBlue         CJColorFromHexString(@"#00aaff")
#define CJColorBlueLight    CJColorFromHexString(@"#aaebff")
#define CJColorBlueDark1    CJColorFromHexString(@"#149BD5")    //深蓝色由1开始越来越深
#define CJColorBlueDark2    CJColorFromHexString(@"#2481ff")
#define CJColorBlueDark3    CJColorFromHexString(@"#0a6fa2")



//Gray从1开始越来越浅
#define CJColorGray1        CJColorFromHexString(@"#606060")
#define CJColorGray2        CJColorFromHexString(@"#888888")
#define CJColorGray3        CJColorFromHexString(@"#999999")
#define CJColorGray4        CJColorFromHexString(@"#aaaaaa")
#define CJColorGray5        CJColorFromHexString(@"#dddddd")
#define CJColorGray6        CJColorFromHexString(@"#f4f4f4")    //可做灰色背景

#define CJColorBlack        CJColorFromHexString(@"#1a1a1a")
#define CJColorBlackLight   CJColorFromHexString(@"#ff4343")

#define CJColorPurpleLight  CJColorFromHexString(@"#ff00ff")



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
