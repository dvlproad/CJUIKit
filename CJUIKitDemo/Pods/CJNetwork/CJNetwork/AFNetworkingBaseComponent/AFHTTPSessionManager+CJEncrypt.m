//
//  AFHTTPSessionManager+CJEncrypt.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2017/6/13.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "AFHTTPSessionManager+CJEncrypt.h"
#import "CJRequestErrorMessageUtil.h"
#import "CJNetworkLogUtil.h"

@implementation AFHTTPSessionManager (CJEncrypt)

/* 完整的描述请参见文件头部 */
- (nullable NSURLSessionDataTask *)cj_getUrl:(nullable NSString *)Url
                                      params:(nullable NSDictionary *)params
                                    progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                     success:(nullable void (^)(NSDictionary *_Nullable responseObject))success
                                     failure:(nullable void (^)(NSError * _Nullable error))failure
{
    NSLog(@"Url = %@", Url);
    NSLog(@"params = %@", params);
    
    //将传给服务器的参数用字符串打印出来
    /*
    NSString *allParamsJsonString = nil;
    if ([NSJSONSerialization isValidJSONObject:params]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:0 error:&error];
        allParamsJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    //*/
    NSString *allParamsJsonString = [CJNetworkLogUtil formattedStringFromObject:params];
    //NSLog(@"传给服务器的json参数:%@", allParamsJsonString);
    
    NSURLSessionDataTask *dataTask =
    [self GET:Url parameters:params progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        
        //successNetworkLog
        NSString *responseString = [CJNetworkLogUtil formattedStringFromObject:responseDict];
        NSMutableString *networkLog = [CJNetworkLogUtil networkLogWithUrl:Url paramsString:allParamsJsonString responseString:responseString];
        [CJNetworkLogUtil printNetworkLog:networkLog];
        
        if (success) {
            success(responseDict);
            
            /*
            NSMutableDictionary *mutableResponseObject = [NSMutableDictionary dictionaryWithDictionary:responseDict];
            [mutableResponseObject setObject:networkLog forKey:@"cjNetworkLog"];
            success(mutableResponseObject);
            //*/
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *cjErrorMeesage = [CJRequestErrorMessageUtil getErrorMessageFromURLSessionTask:task];
        
        //errorNetworkLog
        NSString *responseString = cjErrorMeesage;
        NSMutableString *networkLog = [CJNetworkLogUtil networkLogWithUrl:Url paramsString:allParamsJsonString responseString:responseString];
        [CJNetworkLogUtil printNetworkLog:networkLog];
        
        NSError *newError = [CJRequestErrorMessageUtil getNewErrorWithError:error cjErrorMeesage:cjErrorMeesage];
        if (failure) {
            failure(newError);
        }
    }];
    
    return dataTask;
}



/** 完整的描述请参见文件头部 */
- (nullable NSURLSessionDataTask *)cj_postUrl:(nullable NSString *)Url
                                       params:(nullable id)params
                                      encrypt:(BOOL)encrypt
                                 encryptBlock:(nullable NSData * _Nullable (^)(NSDictionary * _Nullable requestParmas))encryptBlock
                                 decryptBlock:(nullable NSDictionary * _Nullable (^)(NSString * _Nullable responseString))decryptBlock
                                     progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                      success:(nullable void (^)(NSDictionary *_Nullable responseObject))success
                                      failure:(nullable void (^)(NSError * _Nullable error))failure
{
    //将传给服务器的参数用字符串打印出来
    NSString *allParamsJsonString = [CJNetworkLogUtil formattedStringFromObject:params];
    //NSLog(@"传给服务器的json参数:%@", allParamsJsonString);
    
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
                success(recognizableResponseObject);
                
                /*
                NSMutableDictionary *mutableResponseObject = [NSMutableDictionary dictionaryWithDictionary:recognizableResponseObject];
                [mutableResponseObject setObject:networkLog forKey:@"cjNetworkLog"];
                success(mutableResponseObject);
                //*/
            }
        }
        else
        {
            
            NSString *cjErrorMeesage = [CJRequestErrorMessageUtil getErrorMessageFromURLResponse:response];
            NSError *newError = [CJRequestErrorMessageUtil getNewErrorWithError:error cjErrorMeesage:cjErrorMeesage];
            
            //errorNetworkLog
            NSString *responseString = cjErrorMeesage;
            NSMutableString *networkLog = [CJNetworkLogUtil networkLogWithUrl:Url paramsString:allParamsJsonString responseString:responseString];
            [CJNetworkLogUtil printNetworkLog:networkLog];
            
            if (failure) {
                failure(newError);
            }
        }
    }];
    [task resume];
    
    return task;

    /*
    //不知为什么无效的方法：
    NSURLSessionDataTask *URLSessionDataTask =
    [self POST:Url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFormData:bodyData name:@"json"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *recognizableResponseObject = nil; //可识别的responseObject,如果是加密的还要解密
        if (encrypt && decryptBlock) {
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            //responseDictionary = [CJEncryptAndDecryptTool decryptJsonString:responseString];
            recognizableResponseObject = decryptBlock(responseString);
            
        } else {
            recognizableResponseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        }
        
        NSLog(@"\n\n  >>>>>>>>>>>>  网络请求Start  >>>>>>>>>>>>  \n地址：%@ \n参数：%@ \n结果：%@ \n\n传给服务器的json参数:%@ \n  <<<<<<<<<<<<<  网络请求End  <<<<<<<<<<<<<  \n\n\n", Url, params, recognizableResponseObject, allParamsJsonString);
        
        if (success) {
            success(recognizableResponseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //NSDictionary *responseDictionary = @{@"status":@(-1), @"message":@"网络异常"};
        if (failure) {
            failure(error);
        }
        
        NSString *errorMessage = error.localizedDescription;
        NSLog(@"\n\n  >>>>>>>>>>>>  网络请求Start  >>>>>>>>>>>>  \n地址：%@ \n参数：%@ \n结果：%@ \n\n传给服务器的json参数:%@ \n  <<<<<<<<<<<<<  网络请求End  <<<<<<<<<<<<<  \n\n\n", Url, params, errorMessage, allParamsJsonString);
        
    }];
    return URLSessionDataTask;
    //*/
}



@end
