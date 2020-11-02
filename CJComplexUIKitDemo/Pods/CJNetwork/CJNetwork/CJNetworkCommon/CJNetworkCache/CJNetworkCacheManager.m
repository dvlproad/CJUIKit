//
//  CJNetworkCacheManager.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 7/31/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJNetworkCacheManager.h"
#import <YYCache/YYCache.h>
#import "CJCacheDataModel.h"

@interface CJNetworkCacheManager () {
    
}
@property (nonatomic,strong) YYCache *cache;    /**< 缓存 */

@end



@implementation CJNetworkCacheManager

+ (CJNetworkCacheManager *)sharedInstance {
    static CJNetworkCacheManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString *relativeDirectoryPath = @"CJNetwork";
        NSString *fileName = @"CJNetworkCache";
        
        NSString *absoluteDirectoryPath = [NSHomeDirectory() stringByAppendingPathComponent:relativeDirectoryPath];
        if (![[NSFileManager defaultManager] fileExistsAtPath:absoluteDirectoryPath]){
            [[NSFileManager defaultManager] createDirectoryAtPath:absoluteDirectoryPath
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:NULL];
        }
        
        NSString *absoluteFilePath = [absoluteDirectoryPath stringByAppendingPathComponent:fileName];
        self.cache = [[YYCache alloc] initWithPath:absoluteFilePath];
    }
    
    return self;
}

/**
 *  保存数据
 *
 *  @param object                   要缓存的数据
 *  @param cacheKey                 缓存数据的标记
 *  @param timeInterval             要缓存多久(不需要缓存的时候，请设为负值)
 */
- (void)cacheObject:(id<NSCoding>)object forKey:(NSString *)cacheKey timeInterval:(NSTimeInterval)timeInterval {
    CJCacheDataModel *dataModel = [[CJCacheDataModel alloc] initWithDataObject:object timeInterval:timeInterval];
    [self.cache setObject:dataModel forKey:cacheKey];
}

/**
 *  获取指定key对应的缓存数据
 *
 *  @param cacheKey                 缓存数据对应的key
 *
 *  return  该key对应的缓存数据
 */
- (id<NSCoding>)getCacheDataByCacheKey:(NSString *)cacheKey {
    CJCacheDataModel *dataModel = (CJCacheDataModel *)[self.cache objectForKey:cacheKey];
    if (dataModel == nil) {
        return nil;
    }
    
    if (dataModel.needCache) {
        NSTimeInterval timeInterval = [dataModel.expiredDate timeIntervalSinceDate:[NSDate date]];
        if (timeInterval > 0) {
            return dataModel.dataObject;
        } else { //过期了，删除缓存
            [self.cache removeObjectForKey:cacheKey];
            return nil;
        }
    } else {
        return dataModel.dataObject;
    }
}

/**
 *  删除指定key的缓存数据
 *
 *  @param cacheKey                 缓存数据对应的key
 */
- (void)removeCacheForCacheKey:(NSString *)cacheKey {
    [self.cache removeObjectForKey:cacheKey];
}

/**
 *  清空内存上的所有缓存数据（切换账号的时候要记得清空内存缓存）
 */
- (void)clearMemoryCacheAndDiskCache {
    [self.cache removeAllObjects];
}


@end
