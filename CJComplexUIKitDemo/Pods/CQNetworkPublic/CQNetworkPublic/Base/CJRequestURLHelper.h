//
//  CJRequestURLHelper.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2018/6/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJRequestURLHelper : NSObject

/*
 *  获取请求的Url
 *
 *  @param baseUrl      baseUrl
 *  @param apiSuffix    apiSuffix
 *
 *  @return requestUrl
 */
+ (NSString *)requestUrlWithBaseUrl:(NSString *)baseUrl apiSuffix:(NSString *)apiSuffix;

/*
 *  连接请求的地址与参数，返回连接后所形成的字符串
 *
 *  @param requestUrl       请求的地址
 *  @param requestParams    请求的参数
 *
 *  @return 连接后所形成的字符串
 */
+ (NSString *)connectRequestUrl:(NSString *)requestUrl params:(nullable NSDictionary *)requestParams;

@end

NS_ASSUME_NONNULL_END
