//
//  IjinbuResponseModel.m
//  CommonAFNUtilDemo
//
//  Created by dvlproad on 2016/12/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "IjinbuResponseModel.h"

@implementation IjinbuResponseModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return  @{
              @"status":    @"status",
              @"message":   @"msg",
              @"result":    @"result"
              };
}

+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key
{
    if ([key isEqualToString:@"status"]) {
        return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *stringValue, BOOL *success, NSError *__autoreleasing *error) {
            return @([stringValue integerValue]);
            
        } reverseBlock:^id(NSNumber *numberValue, BOOL *success, NSError *__autoreleasing *error) {
            return numberValue;
        }];
    }
    
    return nil;
}

@end
