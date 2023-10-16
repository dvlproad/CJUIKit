//
//  AFHTTPSessionManager+CJSerializerEncrypt.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2017/6/13.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "AFHTTPSessionManager+CJSerializerEncrypt.h"

@implementation AFHTTPSessionManager (CJSerializerEncrypt)

/** 完整的描述请参见文件头部 */
/*
- (nullable NSURLSessionDataTask *)cj_requestUrl:(NSString *)Url
                                          params:(nullable id)allParams
                                         headers:(nullable NSDictionary <NSString *, NSString *> *)headers
                                          method:(CJRequestMethod)method
                              cacheSettingModel:(nullable CJRequestCacheSettingModel *)cacheSettingModel
                                         logType:(CJRequestLogType)logType
                                        progress:(void (^)(NSProgress * _Nonnull))progress
                                         success:(nullable void (^)(id _Nullable responseObject))success
                                         failure:(nullable void (^)(NSString *errorMessage))failure
{
    return [self __cj_requestUrl:Url params:allParams headers:headers method:method cacheSettingModel:cacheSettingModel logType:logType progress:progress success:^(CJSuccessRequestInfo * _Nullable successRequestInfo) {
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
*/

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
                                        progress:(nullable void (^)(NSProgress * _Nonnull))progress
                                         success:(nullable void (^)(CJSuccessRequestInfo * _Nullable successRequestInfo))success
                                         failure:(nullable void (^)(CJFailureRequestInfo * _Nullable failureRequestInfo))failure
{
    BOOL shouldStartRequestNetworkData = [CJRequestCommonHelper __didEventBeforeStartRequestWithUrl:Url params:allParams cacheSettingModel:cacheSettingModel logType:logType success:success];
    if (shouldStartRequestNetworkData == NO) {
        return nil;
    }

    if (method == CJRequestMethodGET) {
        void (^downloadProgress)(NSProgress * _Nonnull) = progress;
        
        NSURLSessionDataTask *URLSessionDataTask =
        [self GET:Url parameters:allParams headers:headers progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [CJRequestCommonHelper __didRequestSuccessForTask:task withResponseObject:responseObject isCacheData:NO forUrl:Url params:allParams cacheSettingModel:cacheSettingModel logType:logType success:success];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [CJRequestCommonHelper __didRequestFailureForTask:task withResponseError:error forUrl:Url params:allParams logType:logType failure:failure];
        }];
        
        return URLSessionDataTask;
        
    } else {
        void (^uploadProgress)(NSProgress * _Nonnull) = progress;
        
        NSURLSessionDataTask *URLSessionDataTask =
        [self POST:Url parameters:allParams headers:headers progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [CJRequestCommonHelper __didRequestSuccessForTask:task withResponseObject:responseObject isCacheData:NO forUrl:Url params:allParams cacheSettingModel:cacheSettingModel logType:logType success:success];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [CJRequestCommonHelper __didRequestFailureForTask:task withResponseError:error forUrl:Url params:allParams logType:logType failure:failure];
        }];
        
        return URLSessionDataTask;
    }
}

@end
