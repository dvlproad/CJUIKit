//
//  IjinbuNetworkClient.h
//  CommonAFNUtilDemo
//
//  Created by dvlproad on 2017/3/6.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SVProgressHUD/SVProgressHUD.h>

#import "IjinbuResponseModel.h"

#import "IjinbuSession.h"
#import "IjinbuUser.h"

typedef  void ((^HPSuccess)(IjinbuResponseModel *responseModel));
typedef  void ((^HPFailure)(NSError *error));

@interface IjinbuNetworkClient : NSObject

+ (IjinbuNetworkClient *)sharedInstance;

- (NSURLSessionDataTask *)postWithRelativeUrl:(NSString *)RelativeUrl
                                       params:(NSDictionary *)params
                                      success:(HPSuccess)success
                                      failure:(HPFailure)failure;


- (NSString *)signWithParams:(NSDictionary *)params path:(NSString*)path;

@end
