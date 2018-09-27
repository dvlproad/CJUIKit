//
//  IjinbuResponseModel.m
//  IjinbuNetworkDemo
//
//  Created by ciyouzen on 2016/12/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "IjinbuResponseModel.h"

@implementation IjinbuResponseModel

- (instancetype)initWithResponseDictionary:(NSDictionary *)responseDictionary {
    self = [super init];
    if (self) {
        NSInteger statusCode = [[responseDictionary objectForKey:@"status"] integerValue];
        self.status = statusCode;
        
        NSString *message = responseDictionary[@"msg"];
        if ([self isNoNullForObject:message]) {
            self.message = message;
        }
        
        id result = responseDictionary[@"result"];
        if ([self isNoNullForObject:result]) {
            self.result = result;
        }
        
    }
    return self;
}

- (BOOL)isNoNullForObject:(id)object {
    if ([object isKindOfClass:[NSNull class]]) {
        return NO;
    } else {
        return YES;
    }
}

@end
