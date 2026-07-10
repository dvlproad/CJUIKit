//
//  AFHTTPSessionManager+CJCacheRequest.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "CJNetworkInfoModel.h"
#import "CJRequestCacheDataUtil.h"


/**
 *  AFN的请求方法(包含缓存和加密方法)
 */
@interface AFHTTPSessionManager (CJCacheRequest) {
    
}

#pragma mark - CJCache
/**
 *  发起POST请求
 *
 *  @param Url              Url
 *  @param params           params
 *  @param shouldCache      需要缓存网络数据的情况(如果有缓存，则即代表可以从缓存中获取数据)
 *  @param uploadProgress   uploadProgress
 *  @param success          请求成功的回调success
 *  @param failure          请求失败的回调failure
 *
 *  return NSURLSessionDataTask
 */
- (nullable NSURLSessionDataTask *)cjCache_postUrl:(nullable NSString *)Url
                                            params:(nullable id)params
                                       shouldCache:(BOOL)shouldCache
                                          progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                           logType:(CJNetworkLogType)logType
                                           success:(nullable void (^)(CJSuccessNetworkInfo * _Nullable successNetworkInfo, BOOL isCacheData))success
                                           failure:(nullable void (^)(CJFailureNetworkInfo * _Nullable failureNetworkInfo))failure;

#pragma mark - CJCacheEncrypt
/**
 *  发起POST请求
 *
 *  @param Url              Url
 *  @param params           params
 *  @param shouldCache      需要缓存网络数据的情况(如果有缓存，则即代表可以从缓存中获取数据)
 *  @param encrypt          是否加密
 *  @param encryptBlock     对请求的参数requestParmas加密的方法
 *  @param decryptBlock     对请求得到的responseString解密的方法
 *  @param uploadProgress   uploadProgress
 *  @param success          请求成功的回调success
 *  @param failure          请求失败的回调failure
 *
 *  return NSURLSessionDataTask
 */
- (nullable NSURLSessionDataTask *)cjCache_postUrl:(nullable NSString *)Url
                                            params:(nullable id)params
                                       shouldCache:(BOOL)shouldCache
                                           encrypt:(BOOL)encrypt
                                      encryptBlock:(nullable NSData * _Nullable (^)(NSDictionary * _Nullable requestParmas))encryptBlock
                                      decryptBlock:(nullable NSDictionary * _Nullable (^)(NSString * _Nullable responseString))decryptBlock
                                          progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                           logType:(CJNetworkLogType)logType
                                           success:(nullable void (^)(CJSuccessNetworkInfo * _Nullable successNetworkInfo, BOOL isCacheData))success
                                           failure:(nullable void (^)(CJFailureNetworkInfo * _Nullable failureNetworkInfo))failure;

@end
