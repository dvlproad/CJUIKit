//
//  AFHTTPSessionManager+CJCacheRequest.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "AFHTTPSessionManager+CJCacheRequest.h"

#import "CJRequestErrorMessageUtil.h"
#import "CJNetworkLogUtil.h"

//typedef NS_OPTIONS(NSUInteger, CJNeedGetCacheOption) {
//    CJNeedGetCacheOptionNone = 1 << 0,             /**< 不缓存 */
//    CJNeedGetCacheOptionNetworkUnable = 1 << 1,    /**< 无网 */
//    CJNeedGetCacheOptionRequestFailure = 1 << 2,   /**< 有网，但是请求地址或者服务器错误等 */
//};


@implementation AFHTTPSessionManager (CJCacheRequest)

#pragma mark - CJCache
/** 完整的描述请参见文件头部 */
- (nullable NSURLSessionDataTask *)cj_postUrl:(nullable NSString *)Url
                                       params:(nullable id)params
                                  shouldCache:(BOOL)shouldCache
                                     progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                      success:(nullable void (^)(NSDictionary *_Nullable responseObject, BOOL isCacheData))success
                                      failure:(nullable void (^)(NSError * _Nullable error))failure
{
    NSURLSessionDataTask *URLSessionDataTask = [self POST:Url parameters:params progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self didRequestSuccessWithResponseObject:responseObject
                                           forUrl:Url
                                           params:params
                                      shouldCache:shouldCache
                                          encrypt:NO
                                     encryptBlock:nil
                                     decryptBlock:nil
                                          success:success];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *cjErrorMeesage = [CJRequestErrorMessageUtil getErrorMessageFromURLSessionTask:task];
        [self didRequestFailureWithResponseError:error
                                  cjErrorMeesage:cjErrorMeesage
                                          forUrl:Url
                                          params:params
                                  shouldGetCache:shouldCache
                                         encrypt:NO
                                    encryptBlock:nil
                                    decryptBlock:nil
                                         success:success
                                         failure:failure];
        
    }];
    
    return URLSessionDataTask;
}





#pragma mark - CJCacheEncrypt
/** 完整的描述请参见文件头部 */
- (nullable NSURLSessionDataTask *)cj_postUrl:(nullable NSString *)Url
                                       params:(nullable id)params
                                  shouldCache:(BOOL)shouldCache
                                      encrypt:(BOOL)encrypt
                                 encryptBlock:(nullable NSData * _Nullable (^)(NSDictionary * _Nullable requestParmas))encryptBlock
                                 decryptBlock:(nullable NSDictionary * _Nullable (^)(NSString * _Nullable responseString))decryptBlock
                                     progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                      success:(nullable void (^)(NSDictionary *_Nullable responseObject, BOOL isCacheData))success
                                      failure:(nullable void (^)(NSError * _Nullable error))failure
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
    
    NSURLSessionDataTask *task =
    [self dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error == nil) {
            [self didRequestSuccessWithResponseObject:responseObject
                                               forUrl:Url
                                               params:params
                                          shouldCache:shouldCache
                                              encrypt:encrypt
                                         encryptBlock:encryptBlock
                                         decryptBlock:decryptBlock
                                              success:success];
        }
        else
        {
            NSString *cjErrorMeesage = [CJRequestErrorMessageUtil getErrorMessageFromURLResponse:response];
            [self didRequestFailureWithResponseError:error
                                      cjErrorMeesage:cjErrorMeesage
                                              forUrl:Url
                                              params:params
                                      shouldGetCache:shouldCache
                                             encrypt:encrypt
                                        encryptBlock:encryptBlock
                                        decryptBlock:decryptBlock
                                             success:success
                                             failure:failure];
        }
    }];
    [task resume];
    
    return task;
}







#pragma mark - Private
///请求得到数据时候执行的方法
- (void)didRequestSuccessWithResponseObject:(nullable id)responseObject
                                     forUrl:(nullable NSString *)Url
                                     params:(nullable id)params
                                shouldCache:(BOOL)shouldCache
                                    encrypt:(BOOL)encrypt
                               encryptBlock:(nullable NSData * _Nullable (^)(NSDictionary * _Nullable requestParmas))encryptBlock
                               decryptBlock:(nullable NSDictionary * _Nullable (^)(NSString * _Nullable responseString))decryptBlock
                                    success:(nullable void (^)(NSDictionary *_Nullable responseObject, BOOL isCacheData))success
{
    //将传给服务器的参数用字符串打印出来
    NSString *allParamsJsonString = [CJNetworkLogUtil formattedStringFromObject:params];
    //NSLog(@"传给服务器的json参数:%@", allParamsJsonString);
    
    
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
    NSString *responseString = [CJNetworkLogUtil formattedStringFromObject:recognizableResponseObject];
    NSMutableString *networkLog = [CJNetworkLogUtil networkLogWithUrl:Url paramsString:allParamsJsonString responseString:responseString];
    [CJNetworkLogUtil printNetworkLog:networkLog];
    
    if (success) {
        success(recognizableResponseObject, NO);//有网络的时候,responseObject等就不是来源磁盘(缓存),故为NO
        
        /*
        NSMutableDictionary *mutableResponseObject = [NSMutableDictionary dictionaryWithDictionary:recognizableResponseObject];
        [mutableResponseObject setObject:networkLog forKey:@"cjNetworkLog"];
        success(mutableResponseObject, NO);
        //*/
    }
    
    if (shouldCache) {  //是否需要本地缓存现在请求下来的网络数据
        [CJRequestCacheDataUtil cacheNetworkData:responseObject byRequestUrl:Url parameters:params];
    }
}

///请求不到数据时候（无网 或者 有网但服务器异常等无数据时候）执行的方法
- (void)didRequestFailureWithResponseError:(NSError * _Nullable)error
                              cjErrorMeesage:(nullable NSString *)cjErrorMeesage
                                     forUrl:(nullable NSString *)Url
                                     params:(nullable id)params
                            shouldGetCache:(BOOL)shouldGetCache
                                    encrypt:(BOOL)encrypt
                               encryptBlock:(nullable NSData * _Nullable (^)(NSDictionary * _Nullable requestParmas))encryptBlock
                               decryptBlock:(nullable NSDictionary * _Nullable (^)(NSString * _Nullable responseString))decryptBlock
                                   success:(nullable void (^)(NSDictionary *_Nullable responseObject, BOOL isCacheData))success
                                    failure:(nullable void (^)(NSError * _Nullable error))failure
{
    //将传给服务器的参数用字符串打印出来
    NSString *allParamsJsonString = [CJNetworkLogUtil formattedStringFromObject:params];
    //NSLog(@"传给服务器的json参数:%@", allParamsJsonString);
    
    if (shouldGetCache) {
        [CJRequestCacheDataUtil requestCacheDataByUrl:Url params:params success:^(NSDictionary * _Nullable responseObject) {
            //NSDictionary *recognizableResponseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *recognizableResponseObject = responseObject;
            
            //successNetworkLog
            NSString *responseString = [CJNetworkLogUtil formattedStringFromObject:recognizableResponseObject];
            NSMutableString *networkLog = [CJNetworkLogUtil networkLogWithUrl:Url paramsString:allParamsJsonString responseString:responseString];
            [CJNetworkLogUtil printNetworkLog:networkLog];
            
            if (success) {
                success(recognizableResponseObject, YES);
                
                /*
                NSMutableDictionary *mutableResponseObject = [NSMutableDictionary dictionaryWithDictionary:recognizableResponseObject];
                [mutableResponseObject setObject:networkLog forKey:@"cjNetworkLog"];
                success(mutableResponseObject, YES);
                //*/
            }
        } failure:^(CJRequestCacheFailureType failureType) {
            //从服务器请求不到数据，连从缓存中也都取不到
            if (failure) {
                NSError *newError = [CJRequestErrorMessageUtil getNewErrorWithError:error cjErrorMeesage:cjErrorMeesage];
                
                //errorNetworkLog
                NSString *responseString = cjErrorMeesage;
                NSMutableString *networkLog = [CJNetworkLogUtil networkLogWithUrl:Url paramsString:allParamsJsonString responseString:responseString];
                [CJNetworkLogUtil printNetworkLog:networkLog];
                
                if (failure == CJRequestCacheFailureTypeCacheKeyNil) {
                    failure(newError);
                } else {
                    failure(newError);
                }
                
            }
        }];
        
    } else {
        NSLog(@"提示：这里之前未缓存，无法读取缓存，提示网络不给力");
        NSError *newError = [CJRequestErrorMessageUtil getNewErrorWithError:error cjErrorMeesage:cjErrorMeesage];
        
        //errorNetworkLog
        NSString *responseString = cjErrorMeesage;
        NSMutableString *networkLog = [CJNetworkLogUtil networkLogWithUrl:Url paramsString:allParamsJsonString responseString:responseString];
        [CJNetworkLogUtil printNetworkLog:networkLog];
        
        if (failure) {
            failure(newError);
        }
    }
}


@end
