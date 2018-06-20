//
//  CJDecimalUtil.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/12/14.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJDecimalUtil.h"

@implementation CJDecimalUtil

#pragma mark - "分" 转 "元"
///将分以保留0位小数的方式转为元
+ (NSString *)zeroDecimalPriceYuanStringFromPriceFen:(NSInteger)priceFen {
    return [self getPriceYuanStringFromPriceFen:priceFen withDecimalCount:0 decimalDealType:CJDecimalDealTypeCeil];
}

///将分以保留1位小数的方式转为元(向上取整)
+ (NSString *)oneUpDecimalPriceYuanStringFromPriceFen:(NSInteger)priceFen {
    return [self getPriceYuanStringFromPriceFen:priceFen withDecimalCount:1 decimalDealType:CJDecimalDealTypeCeil];
}

///将分以保留1位小数的方式转为元(向下取整)
+ (NSString *)oneDownDecimalPriceYuanStringFromPriceFen:(NSInteger)priceFen {
    return [self getPriceYuanStringFromPriceFen:priceFen withDecimalCount:1 decimalDealType:CJDecimalDealTypeFloor];
}

/**
 *  将分以保留几位小数的方式转为元（向上取整）
 *
 *  @param priceFen         分
 *  @param decimalCount     保留的小数位数
 *  @param decimalDealType  取整的方式
 *
 *  @return 字符串
 */
+ (NSString *)getPriceYuanStringFromPriceFen:(NSInteger)priceFen withDecimalCount:(NSInteger)decimalCount decimalDealType:(CJDecimalDealType)decimalDealType
{
    if (priceFen == 0) {
        return @"0";
    }
    
    if (decimalCount == 0) {
        CGFloat priceYuan = priceFen/100.0;
        priceYuan = [self dealValue:priceYuan withDecimalDealType:decimalDealType];
        NSString *priceYuanString = [NSString stringWithFormat:@"%.0f", priceYuan];
        return priceYuanString;
        
    } else if (decimalCount == 1) {
        CGFloat priceJiao = priceFen/10.0;
        priceJiao = [self dealValue:priceJiao withDecimalDealType:decimalDealType];
        CGFloat priceYuan = priceJiao/10.0;
        
        NSString *priceYuanString = [NSString stringWithFormat:@"%.1f", priceYuan];
        return priceYuanString;
        
    } else if (decimalCount == 2) {
        CGFloat priceYuan = priceFen/100.0;
        NSString *priceYuanString = [NSString stringWithFormat:@"%.2f", priceYuan];
        return priceYuanString;
        
    } else {
        CGFloat priceYuan = priceFen/100.0;
        NSString *priceYuanString = [NSString stringWithFormat:@"%.1f", priceYuan];
        return priceYuanString;
    }
}

#pragma mark - "米" 转 "公里"
///将米以保留1位小数的方式转为公里
+ (NSString *)oneDecimalKMStringFromMiles:(NSInteger)miles {
    NSString *kmString = [self getKMStringFromMiles:miles withDecimalCount:1 decimalDealType:CJDecimalDealTypeCeil];
    return kmString;
}

/**
 *  将米以保留几位小数的方式转为公里（向上取整）
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
    
    if (decimalCount == 0) {
        CGFloat km = miles/1000.0;
        km = [self dealValue:km withDecimalDealType:decimalDealType];
        
        NSString *kmString = [NSString stringWithFormat:@"%.0f", km];
        return kmString;
        
    } else if (decimalCount == 1) {
        CGFloat hundredMile = miles/100.0;
        hundredMile = [self dealValue:hundredMile withDecimalDealType:decimalDealType];
        
        CGFloat km = hundredMile/10.0;
        
        NSString *kmString = [NSString stringWithFormat:@"%.1f", km];
        return kmString;
        
    } else if (decimalCount == 2) {
        CGFloat tenMiles = miles/10.0;
        tenMiles = [self dealValue:tenMiles withDecimalDealType:decimalDealType];
        CGFloat km = tenMiles/100.0;
        NSString *kmString = [NSString stringWithFormat:@"%.2f", km];
        return kmString;
        
    } else {
        CGFloat hundredMile = miles/100.0;
        hundredMile = [self dealValue:hundredMile withDecimalDealType:decimalDealType];
        CGFloat km = hundredMile/10.0;
        
        NSString *kmString = [NSString stringWithFormat:@"%.1f", km];
        return kmString;
    }
}

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
