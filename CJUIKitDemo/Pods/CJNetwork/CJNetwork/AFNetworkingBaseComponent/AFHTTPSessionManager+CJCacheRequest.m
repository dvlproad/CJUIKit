//
//  AFHTTPSessionManager+CJCacheRequest.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "AFHTTPSessionManager+CJCacheRequest.h"
#import <objc/runtime.h>

@implementation AFHTTPSessionManager (CJCategory)

#pragma mark - runtime
static NSString *cjNoNetworkHandleKey = @"cjNoNetworkHandleKey";

- (void (^)(void))cjNoNetworkHandle {
    return objc_getAssociatedObject(self, (__bridge const void *)(cjNoNetworkHandleKey));
}

- (void)setCjNoNetworkHandle:(void (^)(void))cjNoNetworkHandle {
    objc_setAssociatedObject(self, (__bridge const void *)(cjNoNetworkHandleKey), cjNoNetworkHandle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


/** 完整的描述请参见文件头部 */
- (nullable NSURLSessionDataTask *)cj_postRequestUrl:(nullable NSString *)Url
                                          parameters:(nullable id)parameters
                                            progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                             success:(nullable AFRequestSuccess)success
                                             failure:(nullable AFRequestFailure)failure
{
    //注：如果网络一直判断失败，请检查之前是否从不曾调用过[[CJNetworkMonitor sharedInstance] startNetworkMonitoring];如是，请提前调用至少一次即可
    BOOL isNetworkEnabled = [CJNetworkMonitor sharedInstance].networkSuccess;
    if (isNetworkEnabled == NO) {//网络不可用
        [self hud_showNoNetwork];
        return nil;
    }
    
    //网络可用
    NSURLSessionDataTask *URLSessionDataTask = [self POST:Url parameters:parameters progress:uploadProgress success:success failure:failure];
    
    return URLSessionDataTask;
}

/** 完整的描述请参见文件头部 */
- (nullable NSURLSessionDataTask *)cj_postRequestUrl:(nullable NSString *)Url
                                          parameters:(nullable id)parameters
                                    cacheReuqestData:(BOOL)cacheReuqestData
                                            progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                             success:(nullable CJRequestCacheSuccess)success
                                             failure:(nullable CJRequestCacheFailure)failure
{
    //注：如果网络一直判断失败，请检查之前是否从不曾调用过[[CJNetworkMonitor sharedInstance] startNetworkMonitoring];如是，请提前调用至少一次即可
    BOOL isNetworkEnabled = [CJNetworkMonitor sharedInstance].networkSuccess;
    if (isNetworkEnabled == NO) {
        /* 网络不可用，读取本地缓存数据 */
        BOOL canGetRequestDataFromCache = cacheReuqestData;
        BOOL getNetworkCacheDataSuccess =
        [CJRequestCacheDataUtil requestNetworkDataFromCache:canGetRequestDataFromCache
                                               byRequestUrl:Url
                                                 parameters:parameters
                                                    success:success
                                                    failure:failure];
        if (!getNetworkCacheDataSuccess) {
            [self hud_showNoNetwork];
        }
        
        return nil;
        
    } else {
        /* 网络可用，直接下载数据，并根据是否需要缓存来进行缓存操作 */
        
        BOOL fromRequestCacheData = NO;//有网络的时候,responseObject等就不是来源磁盘(缓存),故为NO
        NSURLSessionDataTask *URLSessionDataTask = [self POST:Url parameters:parameters progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(task, responseObject, fromRequestCacheData);
            }
            
            if (cacheReuqestData) { //是否需要本地缓存现在请求下来的网络数据
                [CJRequestCacheDataUtil cacheNetworkData:responseObject byRequestUrl:Url parameters:parameters];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(task, error, fromRequestCacheData);
            }
        }];
        
        return URLSessionDataTask;
    }
}

#pragma mark - 私有方法
- (void)hud_showNoNetwork {
    if (self.cjNoNetworkHandle) {
        self.cjNoNetworkHandle();
        //附：cjNoNetworkHandle一般为[SVProgressHUD showErrorWithStatus:NSLocalizedString(@"网络不给力", nil)];
    } else {
        NSLog(@"网络不给力");
    }
}




@end
