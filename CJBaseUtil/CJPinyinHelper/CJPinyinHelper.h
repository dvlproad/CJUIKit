//
//  CJPinyinHelper.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/06/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJPinyinHelper : NSObject

/**
 *  将指定中文转化为地名拼音(已多音节处理完)
 *
 *  @param chineseString 要转化为地名拼音的中文
 *
 *  @return 地名拼音
 */
+ (NSString *)placePinyinFromChineseString:(NSString *)chineseString;


/**
 *  将指定中文转化为拼音
 *
 *  @param chineseString 要转化为拼音的中文
 *
 *  @return 拼音
 */
+ (NSString *)pinyinFromChineseString:(NSString *)chineseString;

@end

NS_ASSUME_NONNULL_END
