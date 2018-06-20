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

#pragma mark - "分" 转 "元"(向上取整)
///将分以保留0位小数的方式转为元
+ (NSString *)zeroDecimalPriceYuanStringFromPriceFen:(NSInteger)priceFen;

///将分以保留1位小数的方式转为元(向上取整)
+ (NSString *)oneUpDecimalPriceYuanStringFromPriceFen:(NSInteger)priceFen;
///将分以保留1位小数的方式转为元(向下取整)
+ (NSString *)oneDownDecimalPriceYuanStringFromPriceFen:(NSInteger)priceFen;

#pragma mark - "米" 转 "公里"(向上取整)
///将米以保留1位小数的方式转为公里
+ (NSString *)oneDecimalKMStringFromMiles:(NSInteger)miles;

@end
