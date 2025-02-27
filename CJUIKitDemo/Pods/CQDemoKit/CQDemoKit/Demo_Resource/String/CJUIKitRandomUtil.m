//
//  CJUIKitRandomUtil.m
//  CQDemoKit
//
//  Created by ciyouzen on 2020/11/13.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CJUIKitRandomUtil.h"

@implementation CJUIKitRandomUtil

#pragma mark - C函数
/// 获取随机的颜色
UIColor *cqtsRandomColor(void) {
    return [CJUIKitRandomUtil randomColorWithAlpha:1.0f];
}

/// 获取随机的字符串
NSString *cqtsRandomString(NSInteger minLength, NSInteger maxLength, CQRipeStringType stringType) {
    return [CJUIKitRandomUtil randomStringWithMinLength:minLength maxLength:maxLength stringType:stringType];
}


/// 获取随机的中文名字
NSString *cqtsRandomName(NSInteger minLength, NSInteger maxLength) {
    return [CJUIKitRandomUtil randomStringWithMinLength:minLength maxLength:maxLength stringType:CQRipeStringTypeChinese];
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
    
    if (randomStringLength == 0) {  // 如果随机字符串的长度为0，则返回空字符串
        return @"";
    }
    
    
    NSString *number = @"0123456789";
    NSString *english = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
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


#pragma mark 名字
/// 获取所有姓名
+ (NSArray<NSString *> *)names {
    NSString *allName = @"梦琪、忆柳、之桃、慕青、问兰、尔岚、元香、初夏、沛菡、傲珊、曼文、乐菱、痴珊、恨玉、惜文、香寒、新柔、语蓉、海安、夜蓉、涵柏、水桃、醉蓝、春儿、语琴、从彤、傲晴、语兰、又菱、碧彤、元霜、怜梦、紫寒、妙彤、曼易、南莲、紫翠、雨寒、易烟、如萱、若南、寻真、晓亦、向珊、慕灵、以蕊、寻雁、映易、雪柳、孤岚、笑霜、海云、凝天、沛珊、寒云、冰旋、宛儿、绿真、盼儿、晓霜、碧凡、夏菡、曼香、若烟、半梦、雅绿、冰蓝、灵槐、平安、书翠、翠风、香巧、代云、梦曼、幼翠、友巧、听寒、梦柏、醉易、访旋、亦玉、凌萱、访卉、怀亦、笑蓝、春翠、靖柏、夜蕾、冰夏、梦松、书雪、乐枫、念薇、靖雁、寻春、恨山、从寒、忆香、觅波、静曼、凡旋、以亦、念露、芷蕾、千兰、新波、代真、新蕾、雁玉、冷卉、紫山、千琴、恨天、傲芙、盼山、怀蝶、冰兰、山柏、翠萱、恨松、问旋、从南、白易、问筠、如霜、半芹、丹珍、冰彤、亦寒、寒雁、怜云、寻文、乐丹、翠柔、谷山、之瑶、冰露、尔珍、谷雪、乐萱、涵菡、海莲、傲蕾、青槐、冬儿、易梦、惜雪、宛海、之柔、夏青、亦瑶、妙菡、春竹、痴梦、紫蓝、晓巧、幻柏、元风、冰枫、访蕊、南春、芷蕊、凡蕾、凡柔、安蕾、天荷、含玉、书兰、雅琴、书瑶、春雁、从安、夏槐、念芹、怀萍、代曼、幻珊、谷丝、秋翠、白晴、海露、代荷、含玉、书蕾、听白、访琴、灵雁、秋春、雪青、乐瑶、含烟、涵双、平蝶、雅蕊、傲之、灵薇、绿春、含蕾、从梦、从蓉、初丹。听兰、听蓉、语芙、夏彤、凌瑶、忆翠、幻灵、怜菡、紫南、依珊、妙竹、访烟、怜蕾、映寒、友绿、冰萍、惜霜、凌香、芷蕾、雁卉、迎梦、元柏、代萱、紫真、千青、凌寒、紫安、寒安、怀蕊、秋荷、涵雁、以山、凡梅、盼曼、翠彤、谷冬、新巧、冷安、千萍、冰烟、雅阳、友绿、南松、诗云、飞风、寄灵、书芹、幼蓉、以蓝、笑寒、忆寒、秋烟、芷巧、水香、映之、醉波、幻莲、夜山、芷卉、向彤、小玉、幼南、凡梦、尔曼、念波、迎松、青寒、笑天、涵蕾、碧菡、映秋、盼烟、忆山、以寒、寒香、小凡、代亦、梦露、映波、友蕊、寄凡、怜蕾、雁枫、水绿、曼荷、笑珊、寒珊、谷南、慕儿、夏岚、友儿、小萱、紫青、妙菱、冬寒、曼柔、语蝶、青筠、夜安、觅海、问安、晓槐、雅山、访云、翠容、寒凡、晓绿、以菱、冬云、含玉、访枫";
    NSArray<NSString *> *names = [allName componentsSeparatedByString:@"、"];
    return names;
}


/// 获取指定位置的名字
+ (NSString *)nameAtIndex:(NSInteger)selIndex {
    NSArray<NSString *> *names = [self names];
    if (selIndex >= names.count) {  //位置太大的时候，固定使用第一个名字
        selIndex = 0;
    }
    NSString *name = [names objectAtIndex:selIndex];
    
    return name;
}



@end
