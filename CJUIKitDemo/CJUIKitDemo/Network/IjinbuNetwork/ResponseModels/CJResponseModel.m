//
//  CJResponseModel.m
//  CommonAFNUtilDemo
//
//  Created by ciyouzen on 2016/12/18.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJResponseModel.h"

@implementation CJResponseModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"status":    @"status",
             @"message":   @"message",
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
    
//    if ([key isEqualToString:@"date"]) {
//        
//        
//        
//        return [MTLValueTransformer reversibleTransformerWithForwardBlock:
//                ^id(NSNumber *number)
//                {
//                    NSTimeInterval secs = [number doubleValue];
//                    return [NSDate dateWithTimeIntervalSince1970:secs];
//                } reverseBlock:^id(NSDate *d) {
//                    return @([d timeIntervalSince1970]);
//                }];
//    }
    
    return nil;
}


@end
