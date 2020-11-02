//
//  CJRequestSimulateUtil.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2018/4/8.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJRequestSimulateUtil.h"

@implementation CJRequestSimulateUtil

#pragma mark - remoteSimulateApi
/**
 *  获取模拟接口的完整模拟Url
 *
 *  @param simulateDomain   设置模拟接口所在的域名(若未设置则将使用http://localhost/+类名作为域名)
 *  @param apiSuffix        接口名
 *
 *  return  模拟接口的完整模拟Url
 */
+ (NSString *)remoteSimulateUrlWithDomain:(NSString *)simulateDomain apiSuffix:(NSString *)apiSuffix
{
    if (!simulateDomain || simulateDomain.length == 0) {
        simulateDomain = [@"http://localhost/" stringByAppendingString:NSStringFromClass([self class])];
    }
    NSString *Url = [simulateDomain stringByAppendingString:apiSuffix];
    return Url;
}

#pragma mark - localSimulateApi

/// 开始本地模拟接口请求
+ (void)localSimulateApi:(NSString *)apiSuffix completeBlock:(void (^)(NSDictionary *responseDictionary))completeBlock
{
    if ([apiSuffix hasPrefix:@"/"]) {
        apiSuffix = [apiSuffix substringFromIndex:1];
    }
    NSString *jsonName = [apiSuffix stringByReplacingOccurrencesOfString:@"/" withString:@":"];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:jsonName ofType:nil];
    //BOOL exists = [[NSFileManager new] fileExistsAtPath:filePath];
    NSData *responseObject = [NSData dataWithContentsOfFile:filePath];
    if (!responseObject) { //不设置会崩溃
        NSDictionary *lackOfLocalResponseDic =
        @{@"status" : @"0",
          @"message": @"本地请求模拟：却未实现模拟的请求文件",
          @"result" : @""
          };
        responseObject = [NSJSONSerialization dataWithJSONObject:lackOfLocalResponseDic options:NSJSONWritingPrettyPrinted error:nil];
    }
    
    NSDictionary *recognizableResponseObject = nil;
    //if ([NSJSONSerialization isValidJSONObject:responseObject]) {
    //    recognizableResponseObject = responseObject;
    //} else {
    NSError *jsonError = nil;
    recognizableResponseObject = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:NSJSONReadingMutableContainers error:&jsonError];
    //}
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSDictionary *responseDictionary = recognizableResponseObject;
        if (completeBlock) {
            completeBlock(responseDictionary);
        }
        /* // responseDictionary --> responseModel
        CJResponseModel *responseModel = [[CJResponseModel alloc] init];
        responseModel.statusCode = [responseDictionary[@"status"] integerValue];
        responseModel.message = responseDictionary[@"message"];
        responseModel.result = responseDictionary[@"result"];
        responseModel.isCacheData = NO;
        if (success) {
            success(responseModel);
        }
        */
    });
}


@end
