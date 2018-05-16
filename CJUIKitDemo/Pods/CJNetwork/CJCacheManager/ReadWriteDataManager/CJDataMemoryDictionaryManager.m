//
//  CJDataMemoryDictionaryManager.m
//  CommonFMDBUtilDemo
//
//  Created by ciyouzen on 7/31/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJDataMemoryDictionaryManager.h"

@interface CJDataMemoryDictionaryManager () {
    
}
@property (nonatomic, strong) NSMutableDictionary *cacheDictionary; /**< 所有缓存的数据() */
@property (nonatomic, strong) NSMutableArray *cacheKeys; /**< 所有缓存数据对应的地址组成的数组 */
@property (nonatomic, assign) unsigned long long cacheMaxSize; /**< 缓存数据最多保存大小，超过部分删除最早缓存的后，再保存新的(单位为B,默认为2M(2*1024*1024)) */
@property (nonatomic, assign) unsigned long long curCacheSize;  /**< 当前已用缓存的大小 */

@end




@implementation CJDataMemoryDictionaryManager

+ (CJDataMemoryDictionaryManager *)sharedInstance {
    static CJDataMemoryDictionaryManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    //当收到内存警报时，清空内存缓存
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidReceiveMemoryWarningNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
//        [_sharedInstance removeAllObjects];
    }];
    
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //①内存警告时候：清理内存；
        NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
        [defaultCenter addObserver:self
                          selector:@selector(clearMemoryCache)
                              name:UIApplicationDidReceiveMemoryWarningNotification
                            object:nil];
        
        //②进入后台时候：清理内存；(这样虽然下次内存取不到，但我们可以从磁盘中取)
        [defaultCenter addObserver:self
                          selector:@selector(clearMemoryCache)
                              name:UIApplicationDidEnterBackgroundNotification
                            object:nil];
        

        self.cacheDictionary = [[NSMutableDictionary alloc] init];
        self.cacheKeys = [[NSMutableArray alloc] init];
        self.cacheMaxSize = 2*1024*1024;   //default:2 M
    }
    return self;
}

/** 完整的描述请参见文件头部 */
- (void)cacheData:(NSData *)cacheData forCacheKey:(NSString *)cacheKey
{
    NSAssert(cacheData && cacheKey, @"要缓存到内存的数据和缓存地址都不能为空");
    
    if (cacheData.length > self.cacheMaxSize){
        NSLog(@"当前该条数据过大，超过缓存最大值，无法保存:%zd > %llu", cacheData.length, self.cacheMaxSize);
        return;
    }
    
    //当之前数据加上现要缓存的数据超过最大缓存空间时，对缓存空间进行如下清理：即删除旧缓存的数据以腾出空间来存储新数据，旧缓存数据的删除方法为从最老的缓存数据开始清理，直至所腾出的空间足够当前值存储。
    while ([self.cacheKeys count]>0 && self.curCacheSize+cacheData.length>self.cacheMaxSize)
    {
        id firstKey = [self.cacheKeys objectAtIndex:0];
        [self.cacheDictionary removeObjectForKey:firstKey];
        [self.cacheKeys removeObject:firstKey];
        
        NSData *data = [self.cacheDictionary objectForKey:firstKey];
        self.curCacheSize -= data.length;
    }
    
    //开始进行缓存（其中：先删除当前缓存数据所对应的地址key,再增加的目的是为了能够在缓存key数组中判别出当前数据的新旧程度，越新越后面）
    [self.cacheDictionary setObject:cacheData forKey:cacheKey];
    [self.cacheKeys removeObject:cacheKey];
    [self.cacheKeys addObject:cacheKey];    //先remove再add,确保该key在最后
}



/** 完整的描述请参见文件头部 */
- (NSData *)getMemoryCacheDataByCacheKey:(NSString *)cacheKey
{
    NSAssert(cacheKey, @"key不能为空，否则找不到对应的缓存数据");
    
    NSData *cacheData = [self.cacheDictionary objectForKey:cacheKey];//先从内存中取值
    return cacheData;
}


/** 完整的描述请参见文件头部 */
- (void)removeMemoryCacheForCacheKey:(NSString *)cacheKey
{
    NSAssert(cacheKey, @"key不能为空，否则找不到对应的缓存数据");
    
    [self.cacheDictionary removeObjectForKey:cacheKey];
    [self.cacheKeys removeObject:cacheKey];
}

/** 完整的描述请参见文件头部 */
- (void)clearMemoryCache
{
    [self.cacheDictionary removeAllObjects];
    [self.cacheKeys removeAllObjects];
}

@end
