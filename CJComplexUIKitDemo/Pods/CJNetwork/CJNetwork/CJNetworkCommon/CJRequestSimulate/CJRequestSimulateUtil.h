//
//  CJRequestSimulateUtil.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2018/4/8.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJRequestSimulateUtil : NSObject

#pragma mark - remoteSimulateApi
/**
 *  获取模拟接口的完整模拟Url
 *
 *  @param simulateDomain   设置模拟接口所在的域名(若未设置则将使用http://localhost/+类名作为域名)
 *  @param apiSuffix        接口名
 *
 *  return  模拟接口的完整模拟Url
 */
+ (NSString *)remoteSimulateUrlWithDomain:(NSString *)simulateDomain apiSuffix:(NSString *)apiSuffix;

#pragma mark - localSimulateApi
/// 开始本地模拟接口请求
+ (void)localSimulateApi:(NSString *)apiSuffix completeBlock:(void (^)(NSDictionary *responseDictionary))completeBlock;

NS_ASSUME_NONNULL_END

@end
