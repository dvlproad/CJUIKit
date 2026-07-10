//
//  CJDataMemoryCacheManager.h
//  CommonFMDBUtilDemo
//
//  Created by ciyouzen on 7/31/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  可拓展的内存缓存策略
 */
@interface CJDataMemoryCacheManager : NSObject

/**
 *  将数据写入内存
 *
 *  @param data 数据
 *  @param key  键值
 */
+ (void)writeData:(id)data forKey:(NSString *)key;

/**
 *  从内存中读取数据
 *
 *  @param key 键值
 *
 *  @return 数据
 */
+ (id)readDataWithKey:(NSString *)key;

@end
