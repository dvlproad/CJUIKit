//
//  CJDecimalUtil.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/12/14.
//  Copyright © 2016年 dvlproad. All rights reserved.
//
//  小数的处理

#import <Foundation/Foundation.h>

/// 取整的方式
typedef NS_ENUM(NSUInteger, CJDecimalDealType) {
    CJDecimalDealTypeNone = 0,  /**< 不处理 */
    CJDecimalDealTypeCeil,      /**< 向上取整 */
    CJDecimalDealTypeFloor,     /**< 向下取整 */
    CJDecimalDealTypeRound,     /**< 四舍五入 */
};

/*
个位(数) = units (digit)
十位(数) = tens (digit)
百位(数) = hundreds (digit)
千位(数) = thousands (digit)
万位(数) = ten thousands (digit)
十万位(数) = hundred thousands (digit)
*/

@interface CJDecimalUtil : NSObject


/**
 *  去除小数部分的尾部多余零的显示
 *
 *  @param originNumberString 要处理的原始竖直
 *
 *  @return 去除小数部分的尾部多余零后的新数值字符串
 */
+ (NSString *)removeDecimalFractionZeroForNumberString:(NSString *)originNumberString;

/**
 *  将数值(支持Float)在指定位上进行指定处理
 *  @brief                  注:传入值可为浮点型，但返回值的类型只能是整型
 *
 *  @param sValue           要处理的数(注:含浮点型，如1000.006，要在个数上向上取整的时候,值会为1001)
 *  @param decimalPlaces   精确到什么位(负数代表小数点后几位，正数代表小数点前几位.如①不处理填0;②个位,则这里填1;③百位,则这里填3;③小数点后两位即百分位,则这里填-2,因为没有个分位;)
 *  @param decimalDealType  处理的方式(不处理、向上取整、向下取整、四舍五入)
 *
 *  @return 数值在指定位上进行指定处理后得到的整型值(注:返回值是整型)
 */
+ (NSString *)stringValueFromSValue:(NSString *)sValue
            accurateToDecimalPlaces:(NSInteger)decimalPlaces
                    decimalDealType:(CJDecimalDealType)decimalDealType;

/**
 *  将数值(支持Float)在指定位上进行指定处理
 *  @brief                  注:传入值可为浮点型，但返回值的类型只能是整型
 *
 *  @param value            要处理的数(注:含浮点型，如1000.006，要在个数上向上取整的时候,值会为1001)
 *  @param decimalPlaces   精确到什么位(负数代表小数点后几位，正数代表小数点前几位.如①不处理填0;②个位,则这里填1;③百位,则这里填3;③小数点后两位即百分位,则这里填-2,因为没有个分位;)
 *  @param decimalDealType  处理的方式(不处理、向上取整、向下取整、四舍五入)
 *
 *  @return 数值在指定位上进行指定处理后得到的整型值(注:返回值是整型)
 */
+ (CGFloat)floatValueFromFValue:(CGFloat)value
        accurateToDecimalPlaces:(NSInteger)decimalPlaces
                decimalDealType:(CJDecimalDealType)decimalDealType;

@end
