//
//  CJDataMemoryDictionaryManager.h
//  CommonFMDBUtilDemo
//
//  Created by ciyouzen on 7/31/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface CJDataMemoryDictionaryManager : NSObject

@property (nonatomic, copy, readonly) NSString *managerForUserId;

+ (CJDataMemoryDictionaryManager *)sharedInstance;

/**
 *  通过指定key缓存数据
 *
 *  @param cacheData    要缓存的数据
 *  @param cacheKey     缓存数据对应的key
 */
- (void)cacheData:(NSData *)cacheData forCacheKey:(NSString *)cacheKey;

/**
 *  获取指定key对应的缓存数据
 *
 *  @param cacheKey 缓存数据对应的key
 *
 *  return  该key对应的缓存数据
 */
- (NSData *)getMemoryCacheDataByCacheKey:(NSString *)cacheKey;

/**
 *  删除指定key的缓存数据
 *
 *  @param cacheKey 缓存数据对应的key
 */
- (void)removeMemoryCacheForCacheKey:(NSString *)cacheKey;

/**
 *  清空内存上的所有缓存数据（切换账号的时候要记得清空内存缓存）
 *
 */
- (void)clearMemoryCache;

@end
