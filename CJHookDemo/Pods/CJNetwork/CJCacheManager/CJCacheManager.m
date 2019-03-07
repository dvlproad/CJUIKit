//
//  CJCacheManager.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 7/31/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJCacheManager.h"
#import "CJCacheDataModel.h"

@interface CJCacheManager () {
    NSOperationQueue *cacheInQueue; /**< 缓存数据进内存的队列 */
    NSOperationQueue *cacheOutQueue;/**< 从内存中获取缓存数据的的队列 */
}

@end




@implementation CJCacheManager

+ (CJCacheManager *)sharedInstance {
    static CJCacheManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //缓存的队列
        cacheInQueue = [[NSOperationQueue alloc] init];
        cacheInQueue.maxConcurrentOperationCount = 1;
        
        cacheOutQueue = [[NSOperationQueue alloc] init];
        cacheOutQueue.maxConcurrentOperationCount = 1;
    }
    
    return self;
}


/** 完整的描述请参见文件头部 */
- (void)cacheData:(NSData *)cacheData forCacheKey:(NSString *)cacheKey andSaveInDisk:(BOOL)saveInDisk withDiskRelativeDirectoryPath:(NSString *)relativeDirectoryPath
{
    NSAssert(cacheData && cacheKey && relativeDirectoryPath, @"要缓存到磁盘的数据、地址等都不能为空");
    
    //保存到内存
    [[CJDataMemoryDictionaryManager sharedInstance] cacheData:cacheData forCacheKey:cacheKey];
    
    if (saveInDisk){
        CJCacheDataModel *cacheDataModel = [[CJCacheDataModel alloc] init];
        cacheDataModel.data = cacheData;
        cacheDataModel.name = cacheKey;   //确保key中不含不规则字符，如斜杠冒号等
        cacheDataModel.cacheToRelativeDirectoryPath = relativeDirectoryPath;
        
        //用NSInvocationOperation建了一个后台线程，并且放到NSOperationQueue中。后台线程执行cacheDataToDisk:方法。
        [cacheInQueue addOperation:
         [[NSInvocationOperation alloc]initWithTarget:self
                                             selector:@selector(cacheDataToDisk:)
                                               object:cacheDataModel]];
    }
}

/** 数据的保存 */
- (void)cacheDataToDisk:(CJCacheDataModel *)cacheDataModel {
    [CJDataDiskManager saveFileData:cacheDataModel.data
                       withFileName:cacheDataModel.name
            toRelativeDirectoryPath:cacheDataModel.cacheToRelativeDirectoryPath];
}



/** 完整的描述请参见文件头部 */
- (NSData *)getCacheDataByCacheKey:(NSString *)cacheKey diskRelativeDirectoryPath:(NSString *)relativeDirectoryPath
{
    NSData *cacheData = [[CJDataMemoryDictionaryManager sharedInstance] getMemoryCacheDataByCacheKey:cacheKey];
    if (cacheData != nil) {
        return cacheData;
        
    } else {          //如果内存中的值为空，再尝试中磁盘中取值
        if (relativeDirectoryPath == nil) {
            return nil;
        }
        
        NSString *relativeFilePath = [relativeDirectoryPath stringByAppendingPathComponent:cacheKey];
        NSString *absoluteFilePath = [NSHomeDirectory() stringByAppendingPathComponent:relativeFilePath];
        cacheData = [[NSData alloc] initWithContentsOfFile:absoluteFilePath];
        if (cacheData){ //之前内存中可能由于清理内存等缘故，该数据所对的key已被清理，所以当能从磁盘中读到该key所对的数据时，记得顺便存到内存中，因为下次可以从内存中直接读取数据，那样更快
            [[CJDataMemoryDictionaryManager sharedInstance] cacheData:cacheData forCacheKey:cacheKey];
        }
        return cacheData;
    }
}

/** 完整的描述请参见文件头部 */
- (void)removeCacheForCacheKey:(NSString *)cacheKey diskRelativeDirectoryPath:(NSString *)relativeDirectoryPath {
    [[CJDataMemoryDictionaryManager sharedInstance] removeMemoryCacheForCacheKey:cacheKey];
    
    NSString *relativeFilePath = [relativeDirectoryPath stringByAppendingPathComponent:cacheKey];
    NSString *absoluteFilePath = [NSHomeDirectory() stringByAppendingPathComponent:relativeFilePath];
    [[NSFileManager defaultManager] removeItemAtPath:absoluteFilePath error:nil];
}

/** 完整的描述请参见文件头部 */
- (void)clearMemoryCacheAndDiskCache:(NSString *)relativeDirectoryPath {
    [[CJDataMemoryDictionaryManager sharedInstance] clearMemoryCache];
    
    NSString *absoluteDirectoryPath = [NSHomeDirectory() stringByAppendingPathComponent:relativeDirectoryPath];
    [[NSFileManager defaultManager] removeItemAtPath:absoluteDirectoryPath error:nil];
}


@end
