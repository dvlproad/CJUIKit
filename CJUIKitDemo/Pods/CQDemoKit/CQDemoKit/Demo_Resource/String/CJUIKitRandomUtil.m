//
//  CJUIKitRandomUtil.m
//  CQDemoKit
//
//  Created by 李超前 on 2020/11/13.
//

#import "CJUIKitRandomUtil.h"

@implementation CJUIKitRandomUtil

#pragma mark - C函数
/// 获取随机的颜色
UIColor *cqtsRandomColor() {
    return [CJUIKitRandomUtil randomColorWithAlpha:1.0f];
}

/// 获取随机的字符串
NSString *cqtsRandomString(NSInteger minLength, NSInteger maxLength, CQRipeStringType stringType) {
    return [CJUIKitRandomUtil randomStringWithMinLength:minLength maxLength:maxLength stringType:stringType];
}


#pragma mark - OC方法
/// 获取随机的颜色
+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed:arc4random()%255/256.0f green:arc4random()%255/256.0f blue:arc4random()%255/256.0f alpha:1.0f];
}

/*
 *  获取随机的字符串
 *
 *  @param minLength    随机字符串的最小长度
 *  @param maxLength    随机字符串的最大长度
 *  @param stringType   想要输出的随机字符的类型
 *
 *  @return 随机的字符串
 */
+ (NSString *)randomStringWithMinLength:(NSInteger)minLength
                              maxLength:(NSInteger)maxLength
                             stringType:(CQRipeStringType)stringType
{
    NSAssert(maxLength > minLength, @"maxLength > minLength");
    
    NSInteger randomStringLength = 0;   // 随机字符串的长度
    
    if (maxLength == minLength) {
        randomStringLength = minLength;
    } else {
        randomStringLength = minLength + rand() % (maxLength-minLength);
    }
    
    
    NSString *number = @"0123456789";
    NSString *english = @"ABCDEFGHIJKLMNOPQRST";
    NSString *chinese = @"君不见黄河之水天上来奔流到海不复回君不见高堂明镜悲白发朝如青丝暮成雪人生得意须尽欢莫使金樽空对月天生我材必有用千金散尽还复来烹羊宰牛且为乐会须一饮三百杯岑夫子丹丘生将进酒杯莫停与君歌一曲请君为我倾耳听钟鼓馔玉不足贵但愿长醉不愿醒古来圣贤皆寂寞惟有饮者留其名陈王昔时宴平乐斗酒十千恣欢谑主人何为言少钱径须沽取对君酌五花马千金裘呼儿将出换美酒与尔同销万古愁";
    
    NSMutableString *sourceStr = [[NSMutableString alloc] init];
    if (stringType == CQRipeStringTypeNumber) {
        [sourceStr appendString:number];
    } else if (stringType == CQRipeStringTypeEnglish) {
        [sourceStr appendString:english];
    } else if (stringType == CQRipeStringTypeChinese) {
        [sourceStr appendString:chinese];
    } else {
        [sourceStr appendString:number];
        [sourceStr appendString:english];
        [sourceStr appendString:chinese];
    }
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    for (int i = 0; i < randomStringLength; i++) {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}






@end
