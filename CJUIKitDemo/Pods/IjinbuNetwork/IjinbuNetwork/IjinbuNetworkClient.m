//
//  IjinbuNetworkClient.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2017/3/6.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "IjinbuNetworkClient.h"
#import "IjinbuHTTPSessionManager.h"

#import "AFHTTPSessionManager+CJCacheRequest.h"
#import "AFHTTPSessionManager+CJUploadFile.h"

@implementation IjinbuNetworkClient

+ (IjinbuNetworkClient *)sharedInstance {
    static IjinbuNetworkClient *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (nullable NSURLSessionDataTask *)ijinbu_postUrl:(nullable NSString *)Url
                                           params:(nullable id)params
                                            cache:(BOOL)cache
                                    completeBlock:(void (^)(IjinbuResponseModel *responseModel))completeBlock
{
    AFHTTPSessionManager *manager = [IjinbuHTTPSessionManager sharedInstance];
    
    NSString *sign = [self signWithParams:params path:nil];
    NSLog(@"sign = %@", sign);
    [manager.requestSerializer setValue:sign forHTTPHeaderField:@"sign"];
    
    NSURLSessionDataTask *URLSessionDataTask =
    [manager cj_postUrl:Url params:params shouldCache:cache progress:nil success:^(NSDictionary * _Nullable responseObject, BOOL isCacheData) {
        IjinbuResponseModel *responseModel = [[IjinbuResponseModel alloc] init];
        responseModel.status = [responseObject[@"status"] integerValue];
        responseModel.message = responseObject[@"msg"];
        responseModel.result = responseObject[@"result"];
        if (completeBlock) {
            completeBlock(responseModel);
        }
        
    } failure:^(NSError * _Nullable error) {
        IjinbuResponseModel *responseModel = [[IjinbuResponseModel alloc] init];
        responseModel.status = -1;
        responseModel.message = NSLocalizedString(@"网络请求失败", nil);
        responseModel.result = nil;
        if (completeBlock) {
            completeBlock(responseModel);
        }
    }];
    return URLSessionDataTask;
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
    
    NSString *md5Sign = [IjinbuHTTPSessionManager MD5String:string];
    
    return md5Sign;
#endif
}


@end
