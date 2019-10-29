//
//  CJMoneyUtil.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/12/14.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJMoneyUtil.h"

@implementation CJMoneyUtil

#pragma mark - "分" 转 "元"
///将分以保留0位小数的方式转为元
+ (NSString *)zeroUpDecimalPriceYuanStringFromPriceFen:(CGFloat)priceFen {
    return [self getPriceYuanStringFromPriceFen:priceFen withDecimalCount:0 decimalDealType:CJDecimalDealTypeCeil];
}

///将分以保留1位小数的方式转为元(向上取整)
+ (NSString *)oneUpDecimalPriceYuanStringFromPriceFen:(CGFloat)priceFen {
    return [self getPriceYuanStringFromPriceFen:priceFen withDecimalCount:1 decimalDealType:CJDecimalDealTypeCeil];
}

///将分以保留1位小数的方式转为元(向下取整)
+ (NSString *)oneDownDecimalPriceYuanStringFromPriceFen:(CGFloat)priceFen {
    return [self getPriceYuanStringFromPriceFen:priceFen withDecimalCount:1 decimalDealType:CJDecimalDealTypeFloor];
}

/**
 *  将价钱"分"以保留几位小数的方式转为价钱"元"(向上取整、向下取整、四舍五入)
 *
 *  @param priceFen         要转化的分
 *  @param decimalCount     分转化为元后要保留几位小数位数
 *  @param decimalDealType  取整的方式(向上取整、向下取整、四舍五入)
 *
 *  @return 保留了指定位数的价钱"元"字符串
 */
+ (NSString *)getPriceYuanStringFromPriceFen:(CGFloat)priceFen
                            withDecimalCount:(NSInteger)decimalCount
                             decimalDealType:(CJDecimalDealType)decimalDealType
{
    if (priceFen == 0) {
        return @"0";
    }
    
    NSInteger newPriceFen = [CJDecimalUtil processingZeroWithIntValue:priceFen lastDigitCount:decimalCount decimalDealType:decimalDealType];
    CGFloat priceYuan = newPriceFen/100.0;
    
    NSString *priceYuanString = [self yuanStringWithYuanValue:priceYuan decimalCount:decimalCount];
    return priceYuanString;
}

+ (NSString *)yuanStringWithYuanValue:(CGFloat)yuanValue decimalCount:(NSInteger)decimalCount {
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
