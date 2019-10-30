//
//  CJDecimalUtil.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/12/14.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJDecimalUtil.h"

@implementation CJDecimalUtil

/**
 *  去除小数部分的尾部多余零的显示
 *
 *  @param originNumberString 要处理的原始竖直
 *
 *  @return 去除小数部分的尾部多余零后的新数值字符串
 */
+ (NSString *)removeDecimalFractionZeroForNumberString:(NSString *)originNumberString {
    NSNumber *number = @(originNumberString.doubleValue); //用floatValude的时候精度不够
    NSString *lastNumberString = [number stringValue];
    
    return lastNumberString;
}

/**
 *  将价钱以四舍五入的方式保留两位小数，并对结尾是0的小数数字不显示
 *
 *  @param priceString      价钱
 *
 *  @return 最多两位小数的价钱
 */
+ (NSString *)processingMaxTwoDecimalPriceString:(NSString *)priceString
{
    CGFloat fValue = [priceString floatValue];
    NSString *sNewValue = [self stringValueFromFValue:fValue
                              accurateToDecimalPlaces:-2
                                      decimalDealType:CJDecimalDealTypeRound];
    return sNewValue;
}


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
+ (NSString *)stringValueFromFValue:(CGFloat)value
            accurateToDecimalPlaces:(NSInteger)decimalPlaces
                    decimalDealType:(CJDecimalDealType)decimalDealType
{
    CGFloat fNewValue = [self floatValueFromFValue:value
                      accurateToDecimalPlaces:decimalPlaces
                              decimalDealType:decimalDealType];
    NSString *sNewValue = [[NSNumber numberWithFloat:fNewValue] stringValue];
    return sNewValue;
}

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
                decimalDealType:(CJDecimalDealType)decimalDealType
{
    //111 -> 120
//    CGFloat unitTimes = 1;  //该单位的倍数
    
//    int abs(lastDigitCount)
    
    CGFloat fNewValue = 0;
    
    if (decimalPlaces > 0) {
        CGFloat unitTimes = pow(10.0, decimalPlaces-1);
        CGFloat newUnitValue = value/unitTimes; // 转成一个去个位数处理的值
        newUnitValue = [self __dealUnitsForValue:newUnitValue withDecimalDealType:decimalDealType];
        fNewValue = newUnitValue * unitTimes;
        
    } else { // 因为没有个分位
        CGFloat unitTimes = pow(10.0, -decimalPlaces);
        
        CGFloat newUnitValue = value*unitTimes; // 转成一个去个位数处理的值
        newUnitValue = [self __dealUnitsForValue:newUnitValue withDecimalDealType:decimalDealType];
        fNewValue = newUnitValue/unitTimes;
    }
    
    return fNewValue;
}

#pragma mark - Private Method
/**
*  按照指定处理方式处理数值的个位
*
*  @param value            要处理的数(注:含浮点型，如1000.006，要在个数上向上取整的时候,值会为1001)
*  @param decimalDealType  处理的方式(不处理、向上取整、向下取整、四舍五入)
*
*  @return 数值在个位上进行指定处理后得到的值
*/
+ (CGFloat)__dealUnitsForValue:(CGFloat)value
           withDecimalDealType:(CJDecimalDealType)decimalDealType
{
    switch (decimalDealType) {
        case CJDecimalDealTypeCeil:{
            value = ceil(value);
            break;
        }
        case CJDecimalDealTypeFloor:{
            value = floor(value);
            break;
        }
        case CJDecimalDealTypeRound:{
            value = roundf(value);
            break;
        }
        default:{
            break;
        }
    }
    return value;
}

@end
