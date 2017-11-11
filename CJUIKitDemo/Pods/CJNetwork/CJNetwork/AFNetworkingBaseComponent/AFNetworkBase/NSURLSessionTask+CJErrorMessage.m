//
//  NSURLSessionTask+CJErrorMessage.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2016/12/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "NSURLSessionTask+CJErrorMessage.h"

@implementation NSURLSessionTask (CJErrorMessage)

//400 (语法错误)　　401 (未通过验证)　　403 (拒绝请求)　　404 (找不到请求的页面)　　500 (服务器内部错误)
- (NSString *)errorMessage {
    NSString *errorMessage = @"";
    
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)self.response;
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
            errorMessage = @"";
            break;
        }
    }
    
    return errorMessage;
}

@end
