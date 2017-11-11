//
//  CJRequestCacheDataUtil.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2017/3/29.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

/**< 注意在缓存机制中，success与failuer指的都是是获取数据成功的与否，而不是请求成功的与否 */
typedef void(^CJRequestCacheSuccess)(NSURLSessionDataTask *_Nullable task, id _Nullable responseObject, BOOL isCacheData);
typedef void(^CJRequestCacheFailure)(NSURLSessionDataTask *_Nullable task, NSError * _Nonnull error, BOOL isCacheData);


@interface CJRequestCacheDataUtil : NSObject

/**
 *  缓存网络请求的数据
 *
 *  @param responseObject   要缓存的数据
 *  @param Url              Url
 *  @param parameters       parameters
 */
+ (void)cacheNetworkData:(nullable id)responseObject
            byRequestUrl:(nullable NSString *)Url
              parameters:(nullable NSDictionary *)parameters;

/**
 *  获取请求的缓存数据（此方法，只有网络不给力的时候才会调用到）
 *
 *  @param fromRequestCacheData 是否获取请求的缓存数据
 *  @param Url                  Url
 *  @param parameters           parameters
 *  @param success              success
 *  @param failure              failure
 */
+ (BOOL)requestNetworkDataFromCache:(BOOL)fromRequestCacheData
                       byRequestUrl:(nullable NSString *)Url
                         parameters:(nullable NSDictionary *)parameters
                            success:(nullable CJRequestCacheSuccess)success
                            failure:(nullable CJRequestCacheFailure)failure;

@end
