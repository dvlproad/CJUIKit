//
//  CJMoneyUtil.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/12/14.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJMoneyUtil.h"

@implementation CJMoneyUtil

#pragma mark - '分' 转 '元'
/// 将价钱'分'按(向上取整)处理到价钱'元'的该位，并最终以保留0位小数的方式输出价钱"元"
+ (NSString *)zeroUpDecimalPriceYuanStringFromPriceFen:(CGFloat)priceFen {
    return [self priceYuanStringFromPriceFen:priceFen
                         accurateToFenPlaces:3
                             decimalDealType:CJDecimalDealTypeCeil
                            keepDecimalCount:0];
}

/// 将价钱'分'按(向上取整)处理到价钱'元'的该位，并最终以保留1位小数的方式输出价钱"元"
+ (NSString *)oneUpDecimalPriceYuanStringFromPriceFen:(CGFloat)priceFen {
    return [self priceYuanStringFromPriceFen:priceFen
                         accurateToFenPlaces:3
                             decimalDealType:CJDecimalDealTypeCeil
                            keepDecimalCount:1];
}

/// 将价钱'分'按(向下取整)处理到价钱'元'的该位，并最终以保留1位小数的方式输出价钱"元"
+ (NSString *)oneDownDecimalPriceYuanStringFromPriceFen:(CGFloat)priceFen {
    return [self priceYuanStringFromPriceFen:priceFen
                         accurateToFenPlaces:3
                             decimalDealType:CJDecimalDealTypeFloor
                            keepDecimalCount:1];
}

/**
 *  将价钱'分'按指定精度处理到价钱'元'的哪一位，并最终以保留几位小数的方式输出价钱"元"(不处理、向上取整、向下取整、四舍五入)
 *
 *  @param priceFen         要转化的分
 *  @param fenPlaces        精确到当前价钱'分'的什么位(
 *                          ①保留整'元',则为精确到价钱分值的百位,即fenPlaces为3;
 *                          ②保留'元'值的后两位小数,则为精确到价钱分值的个位,即fenPlaces为1)
 *  @param decimalDealType  处理的方式(不处理、向上取整、向下取整、四舍五入)
 *  @param decimalCount     最后的值要始终保留几位小数
 *
 *  @return 保留了几位小数的价钱'元'字符串
 */
+ (NSString *)priceYuanStringFromPriceFen:(CGFloat)priceFen
                      accurateToFenPlaces:(NSInteger)fenPlaces
                          decimalDealType:(CJDecimalDealType)decimalDealType
                         keepDecimalCount:(NSInteger)decimalCount
{
    if (priceFen == 0) {
        return @"0";
    }
    
    NSInteger newPriceFen = [CJDecimalUtil floatValueFromFValue:priceFen
                                        accurateToDecimalPlaces:fenPlaces
                                                decimalDealType:decimalDealType];
    CGFloat priceYuan = newPriceFen/100.0;
    
    // 将'元'数值转化为'元'字符串,并保留两位小数位数
    NSString *priceYuanString = [self __yuanStringWithYuanValue:priceYuan
                                                   decimalCount:decimalCount];
    return priceYuanString;
}


#pragma mark - Private Method
/**
 *  将'元'数值转化为'元'字符串,并保留指定小数位数
 *
 *  @param yuanValue    要进行操作的'元'数值
 *  @param decimalCount 保留几位小数
 *
 *  @return 保留了指定小数位数的'元'字符串
 */
+ (NSString *)__yuanStringWithYuanValue:(CGFloat)yuanValue decimalCount:(NSInteger)decimalCount {
    NSNumberFormatter *yuanNumberFormatter = [[NSNumberFormatter alloc] init];
    yuanNumberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    yuanNumberFormatter.groupingSize = 3;
    yuanNumberFormatter.maximumFractionDigits = decimalCount;    //设置最多保留几位小数
    yuanNumberFormatter.minimumFractionDigits = decimalCount;    //设置最少保留几位小数
    //由于最多与最少是不矛盾的所以要精确到几位小数只要同时设置就好了，如果只是最多，或只是最少的话可以把上面两行中的一行注释即可
    yuanNumberFormatter.groupingSeparator = @",";
    
    NSString *yuanString = [yuanNumberFormatter stringFromNumber:@(yuanValue)];
    return yuanString;
}

@end
