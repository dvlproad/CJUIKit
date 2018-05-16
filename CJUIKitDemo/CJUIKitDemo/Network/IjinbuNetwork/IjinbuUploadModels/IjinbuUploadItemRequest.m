//
//  IjinbuUploadItemRequest.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2017/1/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "IjinbuUploadItemRequest.h"

@implementation IjinbuUploadItemRequest

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"localUrl":       NSNull.null,
             @"block":          NSNull.null,
             @"uploadItemToWhere":   @"uploadType",
             };
}

@end
