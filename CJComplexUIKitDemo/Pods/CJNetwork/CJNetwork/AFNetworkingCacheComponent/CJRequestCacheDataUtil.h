//
//  CJRequestCacheDataUtil.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2017/3/29.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CJRequestCacheFailureType) {
    CJRequestCacheFailureTypeCacheKeyNil,            /**< cacheKey == nil */
    CJRequestCacheFailureTypeCacheDataNil,           /**< 未读到缓存数据,如第一次就是无网请求,提示网络不给力 */
};


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
 *  @param Url          Url
 *  @param params       params
 *  @param success      请求成功的回调success
 *  @param failure      请求失败的回调failure
 */
+ (void)requestCacheDataByUrl:(nullable NSString *)Url
                       params:(nullable id)params
                      success:(nullable void (^)(NSDictionary *_Nullable responseObject))success
                      failure:(nullable void (^)(CJRequestCacheFailureType failureType))failure;

@end
