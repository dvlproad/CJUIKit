//
//  AFHTTPSessionManager+CJCacheRequest.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "AFHTTPSessionManager+CJCacheRequest.h"

#import "CJNetworkErrorUtil.h"

//typedef NS_OPTIONS(NSUInteger, CJNeedGetCacheOption) {
//    CJNeedGetCacheOptionNone = 1 << 0,             /**< 不缓存 */
//    CJNeedGetCacheOptionNetworkUnable = 1 << 1,    /**< 无网 */
//    CJNeedGetCacheOptionRequestFailure = 1 << 2,   /**< 有网，但是请求地址或者服务器错误等 */
//};


@implementation AFHTTPSessionManager (CJCacheRequest)

#pragma mark - CJCache
/** 完整的描述请参见文件头部 */
- (nullable NSURLSessionDataTask *)cjCache_postUrl:(nullable NSString *)Url
                                            params:(nullable id)params
                                       shouldCache:(BOOL)shouldCache
                                          progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                           logType:(CJNetworkLogType)logType
                                           success:(nullable void (^)(CJSuccessNetworkInfo * _Nullable successNetworkInfo, BOOL isCacheData))success
                                           failure:(nullable void (^)(CJFailureNetworkInfo * _Nullable failureNetworkInfo))failure
{
    NSURLSessionDataTask *URLSessionDataTask = [self POST:Url parameters:params progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self didRequestSuccessForTask:task
                    withResponseObject:responseObject
                                forUrl:Url
                                params:params
                           shouldCache:shouldCache
                               encrypt:NO
                          encryptBlock:nil
                          decryptBlock:nil
                               logType:logType
                               success:success];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        [self didRequestFailureForTask:task
                     withResponseError:error
                           URLResponse:response
                                forUrl:Url
                                params:params
                        shouldGetCache:shouldCache
                               encrypt:NO
                          encryptBlock:nil
                          decryptBlock:nil
                               logType:logType
                               success:success
                               failure:failure];
        
    }];
    
    return URLSessionDataTask;
}





#pragma mark - CJCacheEncrypt
/** 完整的描述请参见文件头部 */
- (nullable NSURLSessionDataTask *)cjCache_postUrl:(nullable NSString *)Url
                                            params:(nullable id)params
                                       shouldCache:(BOOL)shouldCache
                                           encrypt:(BOOL)encrypt
                                      encryptBlock:(nullable NSData * _Nullable (^)(NSDictionary * _Nullable requestParmas))encryptBlock
                                      decryptBlock:(nullable NSDictionary * _Nullable (^)(NSString * _Nullable responseString))decryptBlock
                                          progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                           logType:(CJNetworkLogType)logType
                                           success:(nullable void (^)(CJSuccessNetworkInfo * _Nullable successNetworkInfo, BOOL isCacheData))success
                                           failure:(nullable void (^)(CJFailureNetworkInfo * _Nullable failureNetworkInfo))failure
{
    /* 利用Url和params，通过加密的方法创建请求 */
    NSData *bodyData = nil;
    if (encrypt && encryptBlock) {
        //bodyData = [CJEncryptAndDecryptTool encryptParmas:params];
        bodyData = encryptBlock(params);
    } else {
        bodyData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    }
    
    //正确的方法：
    NSURL *URL = [NSURL URLWithString:Url];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPBody:bodyData];
    [request setHTTPMethod:@"POST"];
    
    NSURLSessionDataTask *URLSessionDataTask =
    [self POST:Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self didRequestSuccessForTask:task
                    withResponseObject:responseObject
                                forUrl:Url
                                params:params
                           shouldCache:shouldCache
                               encrypt:encrypt
                          encryptBlock:encryptBlock
                          decryptBlock:decryptBlock
                               logType:logType
                               success:success];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSURLResponse *response = task.response;
        [self didRequestFailureForTask:task
                     withResponseError:error
                           URLResponse:response
                                forUrl:Url
                                params:params
                        shouldGetCache:shouldCache
                               encrypt:encrypt
                          encryptBlock:encryptBlock
                          decryptBlock:decryptBlock
                               logType:logType
                               success:success
                               failure:failure];
    }];
    
    return URLSessionDataTask;
}







#pragma mark - Private
///请求得到数据时候执行的方法
- (void)didRequestSuccessForTask:(NSURLSessionDataTask * _Nonnull)task
              withResponseObject:(nullable id)responseObject
                          forUrl:(nullable NSString *)Url
                          params:(nullable id)params
                     shouldCache:(BOOL)shouldCache
                         encrypt:(BOOL)encrypt
                    encryptBlock:(nullable NSData * _Nullable (^)(NSDictionary * _Nullable requestParmas))encryptBlock
                    decryptBlock:(nullable NSDictionary * _Nullable (^)(NSString * _Nullable responseString))decryptBlock
                         logType:(CJNetworkLogType)logType
                         success:(nullable void (^)(CJSuccessNetworkInfo * _Nullable successNetworkInfo, BOOL isCacheData))success
{
    NSDictionary *recognizableResponseObject = nil; //可识别的responseObject,如果是加密的还要解密
    if (encrypt && decryptBlock) {
        NSString *responseString = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        
        //recognizableResponseObject = [CJEncryptAndDecryptTool decryptJsonString:responseString];
        recognizableResponseObject = decryptBlock(responseString);
        
    } else {
        if ([NSJSONSerialization isValidJSONObject:responseObject]) {
            recognizableResponseObject = responseObject;
        } else {
            recognizableResponseObject = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:NSJSONReadingMutableContainers error:nil];
        }
        
    }
    
    //successNetworkLog
    NSURLRequest *request = task.originalRequest;
    CJSuccessNetworkInfo *successNetworkInfo = [CJSuccessNetworkInfo successNetworkLogWithType:logType Url:Url params:params request:request responseObject:recognizableResponseObject];
    if (success) {
        success(successNetworkInfo, NO);//有网络的时候,responseObject等就不是来源磁盘(缓存),故为NO
    }
    
    if (shouldCache) {  //是否需要本地缓存现在请求下来的网络数据
        [CJRequestCacheDataUtil cacheNetworkData:responseObject byRequestUrl:Url parameters:params];
    }
}

///请求不到数据时候（无网 或者 有网但服务器异常等无数据时候）执行的方法
- (void)didRequestFailureForTask:(NSURLSessionDataTask * _Nonnull)task
               withResponseError:(NSError * _Nullable)error
                     URLResponse:(NSURLResponse *)URLResponse
                          forUrl:(nullable NSString *)Url
                          params:(nullable id)params
                  shouldGetCache:(BOOL)shouldGetCache
                         encrypt:(BOOL)encrypt
                    encryptBlock:(nullable NSData * _Nullable (^)(NSDictionary * _Nullable requestParmas))encryptBlock
                    decryptBlock:(nullable NSDictionary * _Nullable (^)(NSString * _Nullable responseString))decryptBlock
                         logType:(CJNetworkLogType)logType
                         success:(nullable void (^)(CJSuccessNetworkInfo * _Nullable successNetworkInfo, BOOL isCacheData))success
                         failure:(nullable void (^)(CJFailureNetworkInfo * _Nullable failureNetworkInfo))failure
{
    if (shouldGetCache) {
        [CJRequestCacheDataUtil requestCacheDataByUrl:Url params:params success:^(NSDictionary * _Nullable responseObject) {
            //NSDictionary *recognizableResponseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *recognizableResponseObject = responseObject;
            
            //successNetworkLog
            NSURLRequest *request = task.originalRequest;
            CJSuccessNetworkInfo *successNetworkInfo = [CJSuccessNetworkInfo successNetworkLogWithType:logType Url:Url params:params request:request responseObject:recognizableResponseObject];
            if (success) {
                success(successNetworkInfo, YES);
            }
            
        } failure:^(CJRequestCacheFailureType failureType) {
            //从服务器请求不到数据，连从缓存中也都取不到
            NSURLRequest *request = task.originalRequest;
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
            CJFailureNetworkInfo *failureNetworkInfo = [CJFailureNetworkInfo errorNetworkLogWithType:logType Url:Url params:params request:request error:error URLResponse:response];
            
            if (failure) {
                if (failure == CJRequestCacheFailureTypeCacheKeyNil) {
                    failure(failureNetworkInfo);
                } else {
                    failure(failureNetworkInfo);
                }
            }
        }];
        
    } else {
        NSLog(@"提示：这里之前未缓存，无法读取缓存，提示网络不给力");
        //errorNetworkLog
        NSURLRequest *request = task.originalRequest;
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        CJFailureNetworkInfo *failureNetworkInfo = [CJFailureNetworkInfo errorNetworkLogWithType:logType Url:Url params:params request:request error:error URLResponse:response];
        
        if (failure) {
            failure(failureNetworkInfo);
        }
    }
}


@end
