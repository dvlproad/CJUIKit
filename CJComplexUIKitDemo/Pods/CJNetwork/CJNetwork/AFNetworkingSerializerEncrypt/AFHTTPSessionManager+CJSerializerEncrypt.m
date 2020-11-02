//
//  AFHTTPSessionManager+CJSerializerEncrypt.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2017/6/13.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "AFHTTPSessionManager+CJSerializerEncrypt.h"

@implementation AFHTTPSessionManager (CJSerializerEncrypt)

/* 完整的描述请参见文件头部 */
- (nullable NSURLSessionDataTask *)cj_getUrl:(NSString *)Url
                                      params:(nullable NSDictionary *)allParams
                                     headers:(nullable NSDictionary <NSString *, NSString *> *)headers
                           cacheSettingModel:(nullable CJRequestCacheSettingModel *)cacheSettingModel
                                     logType:(CJRequestLogType)logType
                                    progress:(nullable void (^)(NSProgress * _Nullable))progress
                                     success:(nullable void (^)(id _Nullable responseObject))success
                                     failure:(nullable void (^)(NSString *errorMessage))failure
{
    return [self cj_requestUrl:Url params:allParams headers:headers method:CJRequestMethodGET cacheSettingModel:cacheSettingModel logType:logType progress:progress success:^(CJSuccessRequestInfo * _Nullable successRequestInfo) {
        NSDictionary *responseDictionary = successRequestInfo.responseObject;
        //NSDictionary *networkLogString = successRequestInfo.networkLogString;
        if (success) {
            success(responseDictionary);
        }
        
    } failure:^(CJFailureRequestInfo * _Nullable failureRequestInfo) {
        NSString *errorMessage = failureRequestInfo.errorMessage;
        if (failure) {
            failure(errorMessage);
        }
    }];
}

/** 完整的描述请参见文件头部 */
- (nullable NSURLSessionDataTask *)cj_postUrl:(NSString *)Url
                                       params:(nullable id)allParams
                                      headers:(nullable NSDictionary <NSString *, NSString *> *)headers
                            cacheSettingModel:(nullable CJRequestCacheSettingModel *)cacheSettingModel
                                      logType:(CJRequestLogType)logType
                                     progress:(void (^)(NSProgress * _Nonnull))progress
                                      success:(nullable void (^)(id _Nullable responseObject))success
                                      failure:(nullable void (^)(NSString *errorMessage))failure
{
    return [self cj_requestUrl:Url params:allParams headers:headers method:CJRequestMethodPOST cacheSettingModel:cacheSettingModel logType:logType progress:progress success:^(CJSuccessRequestInfo * _Nullable successRequestInfo) {
        NSDictionary *responseDictionary = successRequestInfo.responseObject;
        //NSDictionary *networkLogString = successRequestInfo.networkLogString;
        if (success) {
            success(responseDictionary);
        }
        
    } failure:^(CJFailureRequestInfo * _Nullable failureRequestInfo) {
        NSString *errorMessage = failureRequestInfo.errorMessage;
        if (failure) {
            failure(errorMessage);
        }
    }];
}


- (nullable NSURLSessionDataTask *)cj_requestUrl:(NSString *)Url
                                          params:(nullable id)allParams
                                         headers:(nullable NSDictionary <NSString *, NSString *> *)headers
                                          method:(CJRequestMethod)method
                              cacheSettingModel:(nullable CJRequestCacheSettingModel *)cacheSettingModel
                                         logType:(CJRequestLogType)logType
                                        progress:(nullable void (^)(NSProgress * _Nonnull))progress
                                         success:(nullable void (^)(CJSuccessRequestInfo * _Nullable successRequestInfo))success
                                         failure:(nullable void (^)(CJFailureRequestInfo * _Nullable failureRequestInfo))failure
{
    BOOL shouldStartRequestNetworkData = [self __didEventBeforeStartRequestWithUrl:Url params:allParams cacheSettingModel:cacheSettingModel logType:logType success:success];
    if (shouldStartRequestNetworkData == NO) {
        return nil;
    }

    if (method == CJRequestMethodGET) {
        void (^downloadProgress)(NSProgress * _Nonnull) = progress;
        
        NSURLSessionDataTask *URLSessionDataTask =
        [self GET:Url parameters:allParams headers:headers progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self __didRequestSuccessForTask:task withResponseObject:responseObject isCacheData:NO forUrl:Url params:allParams cacheSettingModel:cacheSettingModel logType:logType success:success];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self __didRequestFailureForTask:task withResponseError:error forUrl:Url params:allParams logType:logType failure:failure];
        }];
        
        return URLSessionDataTask;
        
    } else {
        void (^uploadProgress)(NSProgress * _Nonnull) = progress;
        
        NSURLSessionDataTask *URLSessionDataTask =
        [self POST:Url parameters:allParams headers:headers progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self __didRequestSuccessForTask:task withResponseObject:responseObject isCacheData:NO forUrl:Url params:allParams cacheSettingModel:cacheSettingModel logType:logType success:success];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self __didRequestFailureForTask:task withResponseError:error forUrl:Url params:allParams logType:logType failure:failure];
        }];
        
        return URLSessionDataTask;
    }
}

@end
