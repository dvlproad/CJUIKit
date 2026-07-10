//
//  CJRequestCommonHelper.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2017/6/13.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJRequestCommonHelper.h"
#import <objc/runtime.h>
#import "CJNetworkCacheUtil.h"

@implementation CJRequestCommonHelper

#pragma mark - 网络操作
/// 将params拼接到Url后
+ (NSString *)__appendUrl:(NSString *)Url withParams:(NSDictionary *)urlParams {
    NSMutableString *newUrl = [[NSMutableString alloc] initWithString:Url];
    if (urlParams == nil || urlParams.allKeys.count == 0) {
        return newUrl;
    }
    
    [newUrl appendString:@"?"];
    NSInteger keyCount = urlParams.allKeys.count;
    for (NSInteger i = 0; i < keyCount; i++) {
        NSString *key = urlParams.allKeys[i];
        if (i != 0) {
            [newUrl appendString:@"&"];
        }
        NSString *string = [NSString stringWithFormat:@"%@=%@", key, urlParams[key]];
        [newUrl appendString:string];
    }
    return newUrl;
}

/// 在请求前根据设置做相应处理
+ (BOOL)__didEventBeforeStartRequestWithUrl:(NSString *)Url
                                     params:(nullable NSDictionary *)params
                          cacheSettingModel:(nullable CJRequestCacheSettingModel *)cacheSettingModel
                                    logType:(CJRequestLogType)logType
                                    success:(nullable void (^)(CJSuccessRequestInfo * _Nonnull successRequestInfo))success
{
    CJRequestCacheStrategy cacheStrategy = cacheSettingModel.cacheStrategy;
    BOOL beforeStartRequestWillShowCache = YES; //在开始请求之前是否会先用缓存数据做一次快速显示
    BOOL shouldStartRequestNetworkData = YES;   //是否应该请求网络，如果最后不需要以实际的网络值显示，且能获取到缓存值，则不用进行请求
    if (cacheStrategy == CJRequestCacheStrategyEndWithCacheIfExist) {
        //成功/失败的时候，如果有缓存，则不用再去取网络错误值
        beforeStartRequestWillShowCache = YES;
        shouldStartRequestNetworkData = NO;
        
    } else if (cacheStrategy == CJRequestCacheStrategyUseCacheToTransition) {
        //成功/失败的时候，如果有缓存，使用缓存过去，最终以网络数据显示
        beforeStartRequestWillShowCache = YES;
        shouldStartRequestNetworkData = YES;
        
    } else { //CJRequestCacheStrategyNoneCache
        //NSLog(@"提示：这里之前不使用缓存，也就无法读取缓存，提示网络不给力");
        beforeStartRequestWillShowCache = NO;
        shouldStartRequestNetworkData = YES;
    }
    
    if (beforeStartRequestWillShowCache) {
        id responseObject = [CJNetworkCacheUtil requestCacheDataByUrl:Url params:params];
        if (responseObject) {
            [self __didGetCacheSuccessWithResponseObject:responseObject forUrl:Url params:params logType:logType success:success];
        } else { //获取缓存失败一定要进行请求，且一旦进行请求，最后肯定是以网络请求数据作为最后的显示，要不你请求干嘛
            shouldStartRequestNetworkData = YES;
        }
    }
    
    return shouldStartRequestNetworkData;
}

///得到缓存数据时候执行的方法(私有方法)
+ (void)__didGetCacheSuccessWithResponseObject:(nullable id)responseObject
                                        forUrl:(NSString *)Url
                                        params:(nullable id)params
                                       logType:(CJRequestLogType)logType
                                       success:(nullable void (^)(CJSuccessRequestInfo * _Nonnull successRequestInfo))success
{
    NSURLRequest *request = nil;
    
    CJSuccessRequestInfo *successRequestInfo = [CJSuccessRequestInfo successNetworkLogWithType:logType Url:Url params:params request:request responseObject:responseObject];
    successRequestInfo.isCacheData = YES;
    if (success) {
        success(successRequestInfo);
    }
}

///网络请求获取到数据时候执行的方法(responseObject必须是解密后的数据)
+ (void)__didRequestSuccessForTask:(NSURLSessionDataTask * _Nonnull)task
                withResponseObject:(nullable id)responseObject
                       isCacheData:(BOOL)isCacheData
                            forUrl:(NSString *)Url
                            params:(nullable id)params
                 cacheSettingModel:(nullable CJRequestCacheSettingModel *)cacheSettingModel
                           logType:(CJRequestLogType)logType
                           success:(nullable void (^)(CJSuccessRequestInfo * _Nonnull successRequestInfo))success
{
    CJRequestCacheStrategy cacheStrategy = cacheSettingModel.cacheStrategy;
    if (cacheStrategy != CJRequestCacheStrategyNoneCache) {  //是否需要本地缓存现在请求下来的网络数据
        [CJNetworkCacheUtil cacheResponseObject:responseObject forUrl:Url params:params cacheTimeInterval:cacheSettingModel.cacheTimeInterval];
    }
    
    NSURLRequest *request = task.originalRequest;
    
    CJSuccessRequestInfo *successRequestInfo = [CJSuccessRequestInfo successNetworkLogWithType:logType Url:Url params:params request:request responseObject:responseObject];
    successRequestInfo.isCacheData = isCacheData;
    if (success) {
        success(successRequestInfo);
    }
}

///网络请求不到数据的时候（无网 或者 有网但服务器异常等无数据时候）执行的方法
+ (void)__didRequestFailureForTask:(NSURLSessionDataTask * _Nonnull)task
                 withResponseError:(NSError * _Nullable)error
                            forUrl:(NSString *)Url
                            params:(nullable id)params
                           logType:(CJRequestLogType)logType
                           failure:(nullable void (^)(CJFailureRequestInfo * _Nullable failureRequestInfo))failure
{
    NSURLRequest *request = task.originalRequest;
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
    CJFailureRequestInfo *failureRequestInfo = [CJFailureRequestInfo errorNetworkLogWithType:logType Url:Url params:params request:request error:error URLResponse:response];
    failureRequestInfo.isRequestFailure = YES;
    if (failure) {
        failure(failureRequestInfo);
    }
}

@end
