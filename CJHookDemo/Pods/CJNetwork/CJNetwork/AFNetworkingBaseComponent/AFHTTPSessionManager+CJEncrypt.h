//
//  AFHTTPSessionManager+CJEncrypt.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2017/6/13.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "CJNetworkInfoModel.h"

@interface AFHTTPSessionManager (CJEncrypt)

/**
 *  发起GET请求
 *
 *  @param Url              Url
 *  @param params           params
 *  @param uploadProgress   uploadProgress
 *  @param logType          logType
 *  @param success          请求成功的回调success
 *  @param failure          请求失败的回调failure
 *
 *  @return NSURLSessionDataTask
 */
- (nullable NSURLSessionDataTask *)cj_getUrl:(nullable NSString *)Url
                                      params:(nullable NSDictionary *)params
                                    progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                     logType:(CJNetworkLogType)logType
                                     success:(nullable void (^)(CJSuccessNetworkInfo * _Nullable successNetworkInfo))success
                                     failure:(nullable void (^)(CJFailureNetworkInfo * _Nullable failureNetworkInfo))failure;


/**
 *  发起POST请求(是否加密等都通过Serializer处理)
 *
 *  @param Url              Url
 *  @param params           params
 *  @param uploadProgress   uploadProgress
 *  @param logType          logType
 *  @param success          请求成功的回调success
 *  @param failure          请求失败的回调failure
 *
 *  @return NSURLSessionDataTask
 */
- (nullable NSURLSessionDataTask *)cj_postUrl:(nullable NSString *)Url
                                       params:(nullable id)params
                                     progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                      logType:(CJNetworkLogType)logType
                                      success:(nullable void (^)(CJSuccessNetworkInfo * _Nullable successNetworkInfo))success
                                      failure:(nullable void (^)(CJFailureNetworkInfo * _Nullable failureNetworkInfo))failure;;

/**
 *  发起POST请求
 *
 *  @param Url              Url
 *  @param params           params
 *  @param encrypt          是否加密
 *  @param encryptBlock     对请求的参数requestParmas加密的方法
 *  @param decryptBlock     对请求得到的responseString解密的方法
 *  @param uploadProgress   uploadProgress
 *  @param logType          logType
 *  @param success          请求成功的回调success
 *  @param failure          请求失败的回调failure
 *
 *  @return NSURLSessionDataTask
 */
- (nullable NSURLSessionDataTask *)cj_postUrl:(nullable NSString *)Url
                                       params:(nullable id)params
                                      encrypt:(BOOL)encrypt
                                 encryptBlock:(nullable NSData * _Nullable (^)(NSDictionary * _Nullable requestParmas))encryptBlock
                                 decryptBlock:(nullable NSDictionary * _Nullable (^)(NSString * _Nullable responseString))decryptBlock
                                     progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                      logType:(CJNetworkLogType)logType
                                      success:(nullable void (^)(CJSuccessNetworkInfo * _Nullable successNetworkInfo))success
                                      failure:(nullable void (^)(CJFailureNetworkInfo * _Nullable failureNetworkInfo))failure;;

@end
