//
//  CJUIKitRandomUtil.h
//  CQDemoKit
//
//  Created by 李超前 on 2020/11/13.
//

#import <Foundation/Foundation.h>

/// 想要输出的随机字符的类型
typedef NS_ENUM(NSUInteger, CQRipeStringType) {
    CQRipeStringTypeNone,   // 中英文+数字任意
    CQRipeStringTypeNumber, // 数字
    CQRipeStringTypeEnglish,// 英文字母
    CQRipeStringTypeChinese,// 中文
};

NS_ASSUME_NONNULL_BEGIN

@interface CJUIKitRandomUtil : NSObject

#pragma mark - C函数
/// 获取随机的颜色
UIColor *cqtsRandomColor();

/// 获取随机的字符串
NSString *cqtsRandomString(NSInteger minLength, NSInteger maxLength, CQRipeStringType stringType);





#pragma mark - OC方法
/// 获取随机的颜色
+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha;

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
                             stringType:(CQRipeStringType)stringType;

@end

NS_ASSUME_NONNULL_END
