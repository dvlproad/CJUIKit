//
//  CJRequestErrorUtil.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2016/12/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJRequestErrorUtil : NSObject

///将moreUserInfo添加到pError中
//+ (void)perfectError:(NSError * *)pError withMoreUserInfo:(NSDictionary *)moreUserInfo;

+ (NSError *)getNewErrorWithError:(NSError *)error withMoreUserInfo:(NSDictionary *)moreUserInfo;

+ (NSString *)getErrorMessageFromURLSessionTask:(NSURLSessionTask *)task;

+ (NSString *)getErrorMessageFromURLResponse:(NSURLResponse *)URLResponse;

+ (NSString *)getErrorMessageFromHTTPURLResponse:(NSHTTPURLResponse *)response;

@end

NS_ASSUME_NONNULL_END
