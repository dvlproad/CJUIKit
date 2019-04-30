//
//  CJDecimalUtil.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/12/14.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJDecimalUtil.h"

@implementation CJDecimalUtil

/* 完整的描述请参见文件头部 */
+ (NSString *)removeEndZeroForNumberString:(NSString *)originNumberString {
    NSNumber *number = @(originNumberString.doubleValue); //用floatValude的时候精度不够
    NSString *lastNumberString = [NSString stringWithFormat:@"%@", number];
    
    return lastNumberString;
}

/* 完整的描述请参见文件头部 */
+ (NSInteger)processingZeroWithIntValue:(CGFloat)value lastDigitCount:(NSInteger)lastDigitCount decimalDealType:(CJDecimalDealType)decimalDealType
{
    //111 -> 120
    CGFloat unitTimes = 1;  //该单位的倍数
    if (lastDigitCount > 1) {
        unitTimes = (lastDigitCount -1) * 10.0;
    }
    
    CGFloat newUnitValue = value/unitTimes;
    newUnitValue = [self dealValue:newUnitValue withDecimalDealType:decimalDealType];
    CGFloat newValue = newUnitValue * unitTimes;
    
    return newValue;
}

///将数值按指定方式处理
+ (CGFloat)dealValue:(CGFloat)value withDecimalDealType:(CJDecimalDealType)decimalDealType
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
            value = (NSInteger)(value+0.5);
            break;
        }
        default:{
            break;
        }
    }
    return value;
}

@end
