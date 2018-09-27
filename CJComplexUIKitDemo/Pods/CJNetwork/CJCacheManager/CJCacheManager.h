//
//  CJCacheManager.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 7/31/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJDataMemoryDictionaryManager.h"
#import "CJDataDiskManager.h"

@interface CJCacheManager : NSObject

+ (CJCacheManager *)sharedInstance;

/**
 *  保存数据到内存
 *
 *  @param cacheData                要缓存的数据
 *  @param cacheKey                 缓存数据的标记
 *  @param saveInDisk               是否保存到磁盘
 *  @param relativeDirectoryPath    保存到磁盘的相对目录
 */
- (void)cacheData:(NSData *)cacheData forCacheKey:(NSString *)cacheKey andSaveInDisk:(BOOL)saveInDisk withDiskRelativeDirectoryPath:(NSString *)relativeDirectoryPath;

/**
 *  获取指定key对应的缓存数据
 *
 *  @param cacheKey                 缓存数据对应的key
 *  @param relativeDirectoryPath    如果内存中取不到数据，则从磁盘中的什么位置取（该值为nil则不从磁盘取）
 *
 *  return  该key对应的缓存数据
 */
- (NSData *)getCacheDataByCacheKey:(NSString *)cacheKey diskRelativeDirectoryPath:(NSString *)relativeDirectoryPath;

/**
 *  删除指定key的缓存数据
 *
 *  @param cacheKey                 缓存数据对应的key
 *  @param relativeDirectoryPath    要删除文件在磁盘上的路径
 */
- (void)removeCacheForCacheKey:(NSString *)cacheKey diskRelativeDirectoryPath:(NSString *)relativeDirectoryPath;

/**
 *  清空内存上的所有缓存数据（切换账号的时候要记得清空内存缓存）
 *
 *  @param relativeDirectoryPath    要删除文件在磁盘上的路径
 */
- (void)clearMemoryCacheAndDiskCache:(NSString *)relativeDirectoryPath;

@end
