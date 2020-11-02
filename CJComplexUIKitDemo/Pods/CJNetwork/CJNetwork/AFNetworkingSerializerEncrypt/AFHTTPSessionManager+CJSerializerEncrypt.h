//
//  AFHTTPSessionManager+CJSerializerEncrypt.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2017/6/13.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "AFHTTPSessionManager+CJRequestCommon.h"

NS_ASSUME_NONNULL_BEGIN

@interface AFHTTPSessionManager (CJSerializerEncrypt)

/*
 *  发起GET请求
 *
 *  @param Url                  Url
 *  @param allParams            allParams
 *  @param headers              headers
 *  @param cacheSettingModel    cacheSettingModel
 *  @param logType              logType
 *  @param progress             progress
 *  @param success              请求成功的回调success
 *  @param failure              请求失败的回调failure
 *
 *  @return NSURLSessionDataTask
 */
- (nullable NSURLSessionDataTask *)cj_getUrl:(NSString *)Url
                                      params:(nullable NSDictionary *)allParams
                                     headers:(nullable NSDictionary <NSString *, NSString *> *)headers
                           cacheSettingModel:(nullable CJRequestCacheSettingModel *)cacheSettingModel
                                     logType:(CJRequestLogType)logType
                                    progress:(nullable void (^)(NSProgress * _Nullable))progress
                                     success:(nullable void (^)(id _Nullable responseObject))success
                                     failure:(nullable void (^)(NSString *errorMessage))failure;

/*
 *  发起POST请求(是否加密等都通过Serializer处理)
 *
 *  @param Url                  Url
 *  @param allParams            allParams
 *  @param headers              headers
 *  @param cacheSettingModel    cacheSettingModel
 *  @param logType              logType
 *  @param progress             progress
 *  @param success              请求成功的回调success
 *  @param failure              请求失败的回调failure
 *
 *  @return NSURLSessionDataTask
 */
- (nullable NSURLSessionDataTask *)cj_postUrl:(NSString *)Url
                                       params:(nullable id)allParams
                                      headers:(nullable NSDictionary <NSString *, NSString *> *)headers
                            cacheSettingModel:(nullable CJRequestCacheSettingModel *)cacheSettingModel
                                      logType:(CJRequestLogType)logType
                                     progress:(nullable void (^)(NSProgress * _Nullable))progress
                                      success:(nullable void (^)(id _Nullable responseObject))success
                                      failure:(nullable void (^)(NSString *errorMessage))failure;

/*
 *  发起请求(当为GET请求时，不需要加密；而当为POST请求时，是否加密等都通过Serializer处理)
 *
 *  @param Url                  Url
 *  @param allParams            allParams
 *  @param headers              headers
 *  @param method               request method
 *  @param cacheSettingModel    cacheSettingModel
 *  @param logType              logType
 *  @param progress             progress
 *  @param success              请求成功的回调success
 *  @param failure              请求失败的回调failure
 *
 *  @return NSURLSessionDataTask
 */
- (nullable NSURLSessionDataTask *)cj_requestUrl:(NSString *)Url
                                          params:(nullable id)allParams
                                         headers:(nullable NSDictionary <NSString *, NSString *> *)headers
                                          method:(CJRequestMethod)method
                               cacheSettingModel:(nullable CJRequestCacheSettingModel *)cacheSettingModel
                                         logType:(CJRequestLogType)logType
                                        progress:(nullable void (^)(NSProgress * _Nullable))progress
                                         success:(nullable void (^)(CJSuccessRequestInfo * _Nullable successRequestInfo))success
                                         failure:(nullable void (^)(CJFailureRequestInfo * _Nullable failureRequestInfo))failure;


NS_ASSUME_NONNULL_END

@end
