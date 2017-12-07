//
//  IjinbuNetworkClient.m
//  CommonAFNUtilDemo
//
//  Created by ciyouzen on 2017/3/6.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "IjinbuNetworkClient.h"
#import "IjinbuHTTPSessionManager.h"
#import <CJNetwork/AFHTTPSessionManager+CJCacheRequest.h>

@implementation IjinbuNetworkClient

+ (IjinbuNetworkClient *)sharedInstance {
    static IjinbuNetworkClient *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (NSURLSessionDataTask *)postWithRelativeUrl:(NSString *)RelativeUrl
                                       params:(NSDictionary *)params
                                      success:(HPSuccess)success
                                      failure:(HPFailure)failure
{
    NSString *Url = API_BASE_Url_ijinbu(RelativeUrl);
    
    NSLog(@"Url = %@", Url);
    NSLog(@"params = %@", params);
    
    AFHTTPSessionManager *manager = [IjinbuHTTPSessionManager sharedInstance];
    
    NSString *sign = [self signWithParams:params path:nil];
    NSLog(@"sign = %@", sign);
    [manager.requestSerializer setValue:sign forHTTPHeaderField:@"sign"];
    
    NSURLSessionDataTask *dataTask =
    [manager cj_postRequestUrl:Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        NSLog(@"请求ijinbu成功");
        NSLog(@"responseObject = %@", responseObject);
        IjinbuResponseModel *responseModel = [MTLJSONAdapter modelOfClass:[IjinbuResponseModel class] fromJSONDictionary:responseObject error:nil];
        if ([responseModel.status integerValue] == 1) {
            if (success) {
                success(responseModel);
            }
            
        } else {
            if (failure) {
                failure(nil);
            }
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *errorMessage = [error localizedDescription];
        NSLog(@"Failure:请求ijinbu失败:%@", errorMessage);
        if (failure) {
            failure(nil);
        }
    }];
    
    return dataTask;
}


- (NSString *)signWithParams:(NSDictionary *)params path:(NSString*)path
{
#if 0
    return [[NSString stringWithFormat:@"%@123456", [HPDevice deviceId]] md5Hash];
#else
    NSURL *url = [NSURL URLWithString:path];
    NSString *q = [url query];
    NSArray *kvs = [q componentsSeparatedByString:@"&"];
    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:params];
    for (NSString *item in kvs)
    {
        NSArray *a = [item componentsSeparatedByString:@"="];
        if (a.count > 1)
            [d setValue:a[1] forKey:a[0]];
        else if (a.count == 1)
            [d setValue:@"" forKey:a[0]];
    }
    NSArray *keys = [[d allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        return [obj1 compare:obj2];
    }];
    NSMutableString *string = [NSMutableString string];
    for (NSUInteger i = 0; i < keys.count; i++) {
        NSObject *value = [d valueForKey:keys[i]];
        [string appendFormat:@"%@%@", keys[i], value!=[NSNull null]?value:@""];
    }
    if (string.length > 0)
    {
        //        [string appendString:@"appKey=9a628966c0f3ff45cf3c68a92ea0ec2a"];
    }
    return [string MD5];
#endif
}


@end
