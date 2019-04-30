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
    CJDecimalDealTypeNone,  /**< 不处理 */
    CJDecimalDealTypeCeil,  /**< 向上取整 */
    CJDecimalDealTypeFloor, /**< 向下取整 */
    CJDecimalDealTypeRound,  /**< 四舍五入 */
};

@interface CJDecimalUtil : NSObject


///删除尾部多余的零
+ (NSString *)removeEndZeroForNumberString:(NSString *)originNumberString;

/**
 *  将整数的后几位按什么样的方式归零处理(注:传入值可为浮点型，但返回值的类型只能是整型)
 *
 *  @param value            要处理的数(注:含浮点型，如1000.006，尾部归零处理的位数为0位时候，向上取整后是1001)
 *  @param lastDigitCount   要归零处理的是该整数的后几位
 *  @param decimalDealType  处理的方式
 *
 *  @return 归零处理后的整型(注:返回值是整型)
 */
+ (NSInteger)processingZeroWithIntValue:(CGFloat)value lastDigitCount:(NSInteger)lastDigitCount decimalDealType:(CJDecimalDealType)decimalDealType;

@end
