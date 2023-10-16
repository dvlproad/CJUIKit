//
//  CJNetworkCacheManager.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 7/31/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJNetworkCacheManager : NSObject {
    
}
@property (nonatomic, copy) NSString *relativeDirectoryPath;

+ (CJNetworkCacheManager *)sharedInstance;

/**
 *  保存数据
 *
 *  @param object                   要缓存的数据
 *  @param cacheKey                 缓存数据的标记
 *  @param timeInterval             要缓存多久(不需要缓存的时候，请设为负值)
 */
- (void)cacheObject:(id<NSCoding>)object forKey:(NSString *)cacheKey timeInterval:(NSTimeInterval)timeInterval;

/**
 *  获取指定key对应的缓存数据
 *
 *  @param cacheKey                 缓存数据对应的key
 *
 *  return  该key对应的缓存数据
 */
- (id<NSCoding>)getCacheDataByCacheKey:(NSString *)cacheKey;

/**
 *  删除指定key的缓存数据
 *
 *  @param cacheKey                 缓存数据对应的key
 */
- (void)removeCacheForCacheKey:(NSString *)cacheKey;

/**
 *  清空内存上的所有缓存数据（切换账号的时候要记得清空内存缓存）
 */
- (void)clearMemoryCacheAndDiskCache;

@end

NS_ASSUME_NONNULL_END
