//
//  CJNetworkCacheUtil.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2017/3/29.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJNetworkCacheUtil.h"

//#ifdef CJNetworkPodTEST
//#import "CJCacheManager.h"
//#else
//#import <CJCacheManager/CJCacheManager.h>
//#endif
#import "CJNetworkCacheManager.h"


//static NSString * const kRelativeDirectoryPath = @"CJNetworkCache";

@implementation CJNetworkCacheUtil

/** 完整的描述请参见文件头部 */
+ (void)cacheResponseObject:(nullable id)responseObject
                     forUrl:(NSString *)Url
                     params:(nullable NSDictionary *)params
          cacheTimeInterval:(NSTimeInterval)cacheTimeInterval
{
    NSString *requestCacheKey = [self getRequestCacheKeyByRequestUrl:Url parameters:params];
    if (nil == requestCacheKey) {
        NSLog(@"error: requestCacheKey == nil, 无法进行缓存");
        return;
    }
    
    [[CJNetworkCacheManager sharedInstance] cacheObject:responseObject forKey:requestCacheKey timeInterval:cacheTimeInterval];
    
    /*
    if (!responseObject){
        [[CJCacheManager sharedInstance] removeCacheForCacheKey:requestCacheKey diskRelativeDirectoryPath:kRelativeDirectoryPath];
        
        
    } else {
        //TODO:responseObject(json) 转data
        NSDictionary *dictionary = [NSDictionary dictionaryWithDictionary:responseObject];
        NSData *cacheData = nil;
        if ([NSJSONSerialization isValidJSONObject:dictionary]) {
            NSError *error;
            cacheData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
        }
        
        [[CJCacheManager sharedInstance] cacheData:cacheData forCacheKey:requestCacheKey andSaveInDisk:YES withDiskRelativeDirectoryPath:kRelativeDirectoryPath];
    }
    */
}

/** 完整的描述请参见文件头部 */
+ (id<NSCoding>)requestCacheDataByUrl:(NSString *)Url params:(nullable id)params
{
    NSString *requestCacheKey = [self getRequestCacheKeyByRequestUrl:Url parameters:params];
    if (nil == requestCacheKey) {
        NSLog(@"error: requestCacheKey == nil, 无法读取缓存，提示网络不给力");
        return nil;
    }
    
    //id responseObject = [[CJCacheManager sharedInstance] getCacheDataByCacheKey:requestCacheKey diskRelativeDirectoryPath:kRelativeDirectoryPath];
    id responseObject = [[CJNetworkCacheManager sharedInstance] getCacheDataByCacheKey:requestCacheKey];
    return responseObject;
}

/**
 *  获取请求的缓存key
 *
 *  @param Url          Url
 *  @param parameters   parameters
 *
 *  return 请求的缓存key
 */
+ (NSString *)getRequestCacheKeyByRequestUrl:(NSString *)Url parameters:(NSDictionary *)parameters {
    //①添加Url
    NSMutableString *requestCacheKey = [[NSMutableString alloc] initWithString:Url];
    
    //②添加paramsString
    if (parameters && parameters.count > 0) {
        if ([NSJSONSerialization isValidJSONObject:parameters]) {
            NSError *error;
            NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:&error];
            NSString *paramsString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            [requestCacheKey appendString:paramsString];
        }
    }
    
    // ③添加appVersion
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    //NSString *appBuild = [infoDictionary objectForKey:@"CFBundleVersion"];
    [requestCacheKey appendString:appVersion];
    
    return requestCacheKey;
}

/**
 *  删除指定key的缓存数据
 *
 *  @param Url          Url
 *  @param params       params
 *
 *  return  是否删除成功
 */
+ (BOOL)removeCacheForUrl:(NSString *)Url params:(nullable id)params {
    NSString *requestCacheKey = [self getRequestCacheKeyByRequestUrl:Url parameters:params];
    if (nil == requestCacheKey) {
        NSLog(@"error: requestCacheKey == nil, 无法读取缓存，提示网络不给力");
        return NO;
    }
    
    [[CJNetworkCacheManager sharedInstance] removeCacheForCacheKey:requestCacheKey];
    return YES;
}

/**
 *  清空所有缓存数据
 */
+ (void)clearAllCache {
    [[CJNetworkCacheManager sharedInstance] clearMemoryCacheAndDiskCache];
}


@end
