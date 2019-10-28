//
//  CJDecimalUtil.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/12/14.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

///取整的方式
typedef NS_ENUM(NSUInteger, CJDecimalDealType) {
    CJDecimalDealTypeNone = 0,  /**< 不处理 */
    CJDecimalDealTypeCeil,      /**< 向上取整 */
    CJDecimalDealTypeFloor,     /**< 向下取整 */
    CJDecimalDealTypeRound,     /**< 四舍五入 */
};

@interface CJDecimalUtil : NSObject


///删除尾部多余的零
+ (NSString *)removeEndZeroForNumberString:(NSString *)originNumberString;

/**
 *  将价钱以四舍五入的方式保留两位小数，并对结尾是0的小数数字不显示
 *
 *  @param priceString      价钱
 *
 *  @return 最多两位小数的价钱
 */
+ (NSString *)processingMaxTwoDecimalPriceString:(NSString *)priceString;

/**
 *  将数值(支持Float)在指定位上进行指定处理
 *  @brief                  注:传入值可为浮点型，但返回值的类型只能是整型
 *
 *  @param value            要处理的数(注:含浮点型，如1000.006，要在个数上向上取整的时候,值会为1001)
 *  @param lastDigitCount   要在什么位上四舍五入①百位,则这里填2;②个位,则这里填0;③小数点后两位,则这里填-2;
 *  @param decimalDealType  处理的方式(不处理、向上取整、向下取整、四舍五入)
 *
 *  @return 数值在指定位上进行指定处理后得到的整型值(注:返回值是整型)
 */
+ (NSString *)processingAccuracyWithFValue:(CGFloat)value
                            lastDigitCount:(NSInteger)lastDigitCount
                           decimalDealType:(CJDecimalDealType)decimalDealType;

/**
*  将数值(支持Float)在指定位上进行指定处理
*  @brief                  注:传入值可为浮点型，但返回值的类型只能是整型
*
*  @param value            要处理的数(注:含浮点型，如1000.006，要在个数上向上取整的时候,值会为1001)
*  @param lastDigitCount   要在什么位上四舍五入①百位,则这里填2;②个位,则这里填0;③小数点后两位,则这里填-2;
*  @param decimalDealType  处理的方式(不处理、向上取整、向下取整、四舍五入)
*
*  @return 数值在指定位上进行指定处理后得到的整型值(注:返回值是整型)
*/
+ (CGFloat)processingZeroWithIntValue:(CGFloat)value
                       lastDigitCount:(NSInteger)lastDigitCount
                      decimalDealType:(CJDecimalDealType)decimalDealType;

@end
