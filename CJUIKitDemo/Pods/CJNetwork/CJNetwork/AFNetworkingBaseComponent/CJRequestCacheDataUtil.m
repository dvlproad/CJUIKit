//
//  CJRequestCacheDataUtil.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2017/3/29.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJRequestCacheDataUtil.h"

#import "CJCacheManager.h"

#import "CJObjectConvertUtil.h"

static NSString *relativeDirectoryPath = @"CJNetworkCache";

@implementation CJRequestCacheDataUtil

/** 完整的描述请参见文件头部 */
+ (void)cacheNetworkData:(nullable id)responseObject
            byRequestUrl:(nullable NSString *)Url
              parameters:(nullable NSDictionary *)parameters
{
    NSString *requestCacheKey = [self getRequestCacheKeyByRequestUrl:Url parameters:parameters];
    if (nil == requestCacheKey) {
        NSLog(@"error: cacheKey == nil, 无法进行缓存");
        
    }else{
        if (!responseObject){
            [[CJCacheManager sharedInstance] removeCacheForCacheKey:requestCacheKey diskRelativeDirectoryPath:relativeDirectoryPath];
            
            
        } else {
            //TODO:responseObject(json) 转data
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
            NSData *cacheData = [CJObjectConvertUtil dataFromDictionary:dic];
            
            [[CJCacheManager sharedInstance] cacheData:cacheData forCacheKey:requestCacheKey andSaveInDisk:YES withDiskRelativeDirectoryPath:relativeDirectoryPath];
        }
    }
}

/** 完整的描述请参见文件头部 */
+ (void)requestCacheDataByUrl:(nullable NSString *)Url
                       params:(nullable id)params
                      success:(nullable void (^)(NSDictionary *_Nullable responseObject))success
                      failure:(nullable void (^)(CJRequestCacheFailureType failureType))failure
{
    NSString *requestCacheKey = [self getRequestCacheKeyByRequestUrl:Url parameters:params];
    if (nil == requestCacheKey) {
        NSLog(@"error: cacheKey == nil, 无法读取缓存，提示网络不给力");
        if (failure) {
            failure(CJRequestCacheFailureTypeCacheKeyNil);
        }
        return;
    }
    
    
    
    NSData *requestCacheData = [[CJCacheManager sharedInstance] getCacheDataByCacheKey:requestCacheKey diskRelativeDirectoryPath:relativeDirectoryPath];
    if (requestCacheData) {
        //NSLog(@"读到有缓存数据，但不保证该数据是最新的，因为网络还是不给力");
        if (success) {
            NSDictionary *responseObject = [CJObjectConvertUtil dictionaryFromData:requestCacheData];
            success(responseObject);
        }
        
    } else {
        //NSLog(@"未读到有缓存数据,如第一次就是无网请求,提示网络不给力");
        if (failure) {
            failure(CJRequestCacheFailureTypeCacheDataNil);
        }
    }
}

/**
 *  获取请求的缓存key
 *
 *  @param Url          Url
 *  @param parameters   parameters
 *
 *  return 请求的缓存key
 */
+ (NSString *)getRequestCacheKeyByRequestUrl:(NSString *)Url
                                  parameters:(NSDictionary *)parameters {
    NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] init];
    [mutableDictionary addEntriesFromDictionary:parameters];
    [mutableDictionary setObject:Url forKey:@"cjRequestUrl"];
    
    NSString *string = [CJObjectConvertUtil stringFromDictionary:mutableDictionary];
    NSString *requestCacheKey = [CJObjectConvertUtil MD5StringFromString:string];
    
    return requestCacheKey;
}


@end
