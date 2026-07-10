//
//  CJRequestErrorUtil.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2016/12/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJRequestErrorUtil.h"

@implementation CJRequestErrorUtil

///将moreUserInfo添加到pError中
+ (void)perfectError:(NSError * *)pError withMoreUserInfo:(NSDictionary *)moreUserInfo
{
    NSMutableDictionary *newUserInfo = [NSMutableDictionary dictionary];
    [newUserInfo addEntriesFromDictionary:moreUserInfo];
    
    NSError *error = *pError;
    if (error == nil) {
        //nothing
    } else {
        NSDictionary *oldUserInfo = error.userInfo;
        [newUserInfo addEntriesFromDictionary:oldUserInfo];
        
        [newUserInfo setObject:error.domain forKey:@"cjOriginErrorDomain"];
        [newUserInfo setObject:@(error.code) forKey:@"cjOriginErrorCode"];
    }
    
    
    NSError *newError = [[NSError alloc] initWithDomain:@"com.dvlproad.network.error" code:-1 userInfo:newUserInfo];
    *pError = newError;
}

+ (NSError *)getNewErrorWithError:(NSError *)error withMoreUserInfo:(NSDictionary *)moreUserInfo {
    NSMutableDictionary *newUserInfo = [NSMutableDictionary dictionary];
    [newUserInfo addEntriesFromDictionary:moreUserInfo];
    
    if (error == nil) {
        //nothing
    } else {
        NSDictionary *oldUserInfo = error.userInfo;
        [newUserInfo addEntriesFromDictionary:oldUserInfo];
        
        [newUserInfo setObject:error.domain forKey:@"cjOriginErrorDomain"];
        [newUserInfo setObject:@(error.code) forKey:@"cjOriginErrorCode"];
    }
    
    
    NSError *newError = [[NSError alloc] initWithDomain:@"com.dvlproad.network.error" code:-1 userInfo:newUserInfo];
    
    return newError;
}

+ (NSString *)getErrorMessageFromURLSessionTask:(NSURLSessionTask *)task {
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
    NSString *errorMessage = [self getErrorMessageFromHTTPURLResponse:response];
    
    return errorMessage;
}


+ (NSString *)getErrorMessageFromURLResponse:(NSURLResponse *)URLResponse {
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)URLResponse;
    return [self getErrorMessageFromHTTPURLResponse:response];
}

/**
 *  从Response中获取错误信息
 *  400 (语法错误)　　401 (未通过验证)　　403 (拒绝请求)　　404 (找不到请求的页面)　　500 (服务器内部错误)
 *
 */
+ (NSString *)getErrorMessageFromHTTPURLResponse:(NSHTTPURLResponse *)response {
    NSString *errorMessage = @"";
    if (response == nil) {
        errorMessage = NSLocalizedString(@"无法连接服务器", nil);
        return errorMessage;
    }
    
    NSInteger statusCode = response.statusCode;//参照服务器状态码大全
    switch (statusCode) {
        case 400:{
            errorMessage = NSLocalizedString(@"语法错误", nil);
            break;
        }
        case 401:{
            errorMessage = NSLocalizedString(@"未通过验证", nil);
            break;
        }
        case 403:{
            errorMessage = NSLocalizedString(@"拒绝请求", nil);
            break;
        }
        case 404:{
            errorMessage = NSLocalizedString(@"找不到请求的页面", nil);
            break;
        }
        case 500:{
            errorMessage = NSLocalizedString(@"服务不可用(500 Internal Server Error)，服务器内部错误", nil);
            break;
        }
        case 501:{
            errorMessage = NSLocalizedString(@"服务不可用(501)，服务器不具有请求功能", nil);
            break;
        }
        case 502:{
            errorMessage = NSLocalizedString(@"服务不可用(502 Bad Gateway)，错误忘关", nil);
            break;
        }
        case 503:{
            errorMessage = NSLocalizedString(@"服务不可用(503 Service Unavailable)，可能是服务器正在维护或者暂停", nil);
            break;
        }
        case 504:{
            errorMessage = NSLocalizedString(@"服务不可用(504 Gateway Time-out)，网关超时", nil);
            break;
        }
        default:{
            //errorMessage = task.responseString;
            errorMessage = @"未知网络错误";
            break;
        }
    }
    
    return errorMessage;
}

@end
