//
//  AFHTTPSessionManager+CJEncrypt.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2017/6/13.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "AFHTTPSessionManager+CJEncrypt.h"

@implementation AFHTTPSessionManager (CJEncrypt)

/* 完整的描述请参见文件头部 */
- (nullable NSURLSessionDataTask *)cj_getUrl:(nullable NSString *)Url
                                      params:(nullable NSDictionary *)params
                                    progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                     logType:(CJNetworkLogType)logType
                                     success:(nullable void (^)(CJSuccessNetworkInfo * _Nullable successNetworkInfo))success
                                     failure:(nullable void (^)(CJFailureNetworkInfo * _Nullable failureNetworkInfo))failure;
{
    NSURLSessionDataTask *dataTask =
    [self GET:Url parameters:params progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSURLRequest *request = task.originalRequest;
        CJSuccessNetworkInfo *successNetworkInfo = [CJSuccessNetworkInfo successNetworkLogWithType:logType Url:Url params:params request:request responseObject:responseObject];
        if (success) {
            success(successNetworkInfo);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSURLRequest *request = task.originalRequest;
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        CJFailureNetworkInfo *failureNetworkInfo = [CJFailureNetworkInfo errorNetworkLogWithType:logType Url:Url params:params request:request error:error URLResponse:response];
        if (failure) {
            failure(failureNetworkInfo);
        }
    }];
    
    return dataTask;
}

/** 完整的描述请参见文件头部 */
- (nullable NSURLSessionDataTask *)cj_postUrl:(nullable NSString *)Url
                                       params:(nullable id)params
                                     progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                      logType:(CJNetworkLogType)logType
                                      success:(nullable void (^)(CJSuccessNetworkInfo * _Nullable successNetworkInfo))success
                                      failure:(nullable void (^)(CJFailureNetworkInfo * _Nullable failureNetworkInfo))failure;
{
    NSURLSessionDataTask *URLSessionDataTask =
    [self POST:Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSURLRequest *request = task.originalRequest;
        CJSuccessNetworkInfo *successNetworkInfo = [CJSuccessNetworkInfo successNetworkLogWithType:logType Url:Url params:params request:request responseObject:responseObject];
        if (success) {
            success(successNetworkInfo);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSURLRequest *request = task.originalRequest;
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        CJFailureNetworkInfo *failureNetworkInfo = [CJFailureNetworkInfo errorNetworkLogWithType:logType Url:Url params:params request:request error:error URLResponse:response];
        if (failure) {
            failure(failureNetworkInfo);
        }
    }];
    
    return URLSessionDataTask;
}

/** 完整的描述请参见文件头部 */
- (nullable NSURLSessionDataTask *)cj_postUrl:(nullable NSString *)Url
                                       params:(nullable id)params
                                      encrypt:(BOOL)encrypt
                                 encryptBlock:(nullable NSData * _Nullable (^)(NSDictionary * _Nullable requestParmas))encryptBlock
                                 decryptBlock:(nullable NSDictionary * _Nullable (^)(NSString * _Nullable responseString))decryptBlock
                                     progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                      logType:(CJNetworkLogType)logType
                                      success:(nullable void (^)(CJSuccessNetworkInfo * _Nullable successNetworkInfo))success
                                      failure:(nullable void (^)(CJFailureNetworkInfo * _Nullable failureNetworkInfo))failure;
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
    [self dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error == nil) {
            NSDictionary *recognizableResponseObject = [self dealResponseObject:responseObject encrypt:encrypt decryptBlock:decryptBlock];
            
            CJSuccessNetworkInfo *successNetworkInfo = [CJSuccessNetworkInfo successNetworkLogWithType:logType Url:Url params:params request:request responseObject:recognizableResponseObject];
            if (success) {
                success(successNetworkInfo);
            }
            
        }
        else
        {
            CJFailureNetworkInfo *failureNetworkInfo = [CJFailureNetworkInfo errorNetworkLogWithType:logType Url:Url params:params request:request error:error URLResponse:response];
            if (failure) {
                failure(failureNetworkInfo);
            }
        }
    }];
    [URLSessionDataTask resume];
    
    return URLSessionDataTask;
    
    /*
    //不知为什么无效的方法：
    NSURLSessionDataTask *URLSessionDataTask =
    [self POST:Url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFormData:bodyData name:@"json"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *recognizableResponseObject = [self dealResponseObject:responseObject encrypt:encrypt decryptBlock:decryptBlock];
        
        //successNetworkLog
        id newResponseObject =
        [CJNetworkLogUtil printSuccessNetworkLogWithUrl:Url params:params responseObject:recognizableResponseObject];
        
        if (success) {
            success(newResponseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSURLResponse *response = task.response;
        //errorNetworkLog
        NSError *newError = [CJNetworkLogUtil printErrorNetworkLogWithUrl:Url params:params error:error URLResponse:response];
        
        if (failure) {
            failure(newError);
        }
        
    }];
    return URLSessionDataTask;
    //*/
}

- (NSDictionary *)dealResponseObject:(id  _Nullable)responseObject
                   encrypt:(BOOL)encrypt
              decryptBlock:(nullable NSDictionary * _Nullable (^)(NSString * _Nullable responseString))decryptBlock
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
    
    return recognizableResponseObject;
}




@end
