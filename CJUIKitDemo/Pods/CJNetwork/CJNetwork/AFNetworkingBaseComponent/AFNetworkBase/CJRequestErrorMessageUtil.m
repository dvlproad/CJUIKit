//
//  CJRequestErrorMessageUtil.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2016/12/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJRequestErrorMessageUtil.h"

@implementation CJRequestErrorMessageUtil

//+ (NSError *)getNewErrorFromError:(NSError *)error URLResponse:(NSURLResponse *)URLResponse {
//    NSHTTPURLResponse *response = (NSHTTPURLResponse *)URLResponse;
//    NSString *cjErrorMeesage = [self getErrorMessageFromHTTPURLResponse:response];
//    
//    
//    NSError *newError = [self getNewErrorWithError:error cjErrorMeesage:cjErrorMeesage];
//    
//    return newError;
//}

+ (NSError *)getNewErrorWithError:(NSError *)error cjErrorMeesage:(NSString *)cjErrorMeesage {
    NSMutableDictionary *newUserInfo = [NSMutableDictionary dictionary];
    [newUserInfo setObject:cjErrorMeesage forKey:@"cjNewErrorMeesage"];
    //[newUserInfo setValue:cjErrorMeesage forKey:NSLocalizedDescriptionKey];
    
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
            errorMessage = NSLocalizedString(@"服务器内部错误", nil);
            break;
        }
        default:{
            //errorMessage = task.responseString;
            errorMessage = @"未知错误";
            break;
        }
    }
    
    return errorMessage;
}

@end
