//
//  CJMoneyUtil.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/12/14.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJDecimalUtil.h"

@interface CJMoneyUtil : NSObject

#pragma mark - '分' 转 '元'
/// 将价钱'分'按(向上取整)处理到价钱'元'的该位，并最终以保留0位小数的方式输出价钱"元"
+ (NSString *)zeroUpDecimalPriceYuanStringFromPriceFen:(CGFloat)priceFen;

/// 将价钱'分'按(向上取整)处理到价钱'元'的该位，并最终以保留1位小数的方式输出价钱"元"
+ (NSString *)oneUpDecimalPriceYuanStringFromPriceFen:(CGFloat)priceFen;

/// 将价钱'分'按(向下取整)处理到价钱'元'的该位，并最终以保留1位小数的方式输出价钱"元"
+ (NSString *)oneDownDecimalPriceYuanStringFromPriceFen:(CGFloat)priceFen;


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
                         keepDecimalCount:(NSInteger)decimalCount;


@end
