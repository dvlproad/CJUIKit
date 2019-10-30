//
//  CJDistanceUtil.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/12/14.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJDistanceUtil.h"

@implementation CJDistanceUtil

#pragma mark - "米" 转 "公里"
///将米以保留1位小数的方式转为公里
+ (NSString *)oneUpDecimalKMStringFromMiles:(NSInteger)miles {
    NSString *kmString = [self getKMStringFromMiles:miles withDecimalCount:1 decimalDealType:CJDecimalDealTypeCeil];
    return kmString;
}

/**
 *  将米以保留几位小数的方式转为公里
 *
 *  @param miles            米
 *  @param decimalCount     保留的小数位数
 *  @param decimalDealType  取整的方式
 *
 *  @return 字符串
 */
+ (NSString *)getKMStringFromMiles:(NSInteger)miles withDecimalCount:(NSInteger)decimalCount decimalDealType:(CJDecimalDealType)decimalDealType
{
    if (miles == 0) {
        return @"0";
    }
    
    NSInteger newMiles = [CJDecimalUtil floatValueFromFValue:miles accurateToDecimalPlaces:decimalCount decimalDealType:decimalDealType];
    CGFloat kilometerValue = newMiles/1000.0;
    NSString *kilometerString = [self kilometerStringWithKilometerValue:kilometerValue decimalCount:decimalCount];
    return kilometerString;
}

+ (NSString *)kilometerStringWithKilometerValue:(CGFloat)kilometerValue decimalCount:(NSInteger)decimalCount {
    NSNumberFormatter *kilometerNumberFormatter = [[NSNumberFormatter alloc] init];
    kilometerNumberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    kilometerNumberFormatter.groupingSize = 3;
    kilometerNumberFormatter.maximumFractionDigits = decimalCount;    //设置最多保留几位小数
    kilometerNumberFormatter.minimumFractionDigits = decimalCount;    //设置最少保留几位小数
    //由于最多与最少是不矛盾的所以要精确到几位小数只要同时设置就好了，如果只是最多，或只是最少的话可以把上面两行中的一行注释即可
    kilometerNumberFormatter.groupingSeparator = @",";
    
    NSString *kilometerString = [kilometerNumberFormatter stringFromNumber:@(kilometerValue)];
    return kilometerString;
}


@end
