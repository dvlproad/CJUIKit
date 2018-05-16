//
//  IjinbuNetworkClient+Login.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2017/3/6.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "IjinbuNetworkClient.h"

@interface IjinbuNetworkClient (Login)

- (NSURLSessionDataTask *)requestijinbuLogin_name:(NSString *)name
                                             pasd:(NSString*)pasd
                                    completeBlock:(void (^)(IjinbuResponseModel *responseModel))completeBlock;

@end
