//
//  NSObjectCJHelper.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "NSObjectCJHelper.h"

@implementation NSObjectCJHelper

///判断对象是否为NULL或nil
+ (BOOL)isNullForObject:(id)object {
    if (object == nil || object == NULL || [object isKindOfClass:[NSNull class]]) {
        return YES;
        
    } else {
        if ([object isKindOfClass:[NSString class]]) {
            NSString *string = (NSString *)object;
            if ((NSNull *)string == [NSNull null] ||
                [string isEqualToString:@"(null)"] ||
                [string isEqualToString:@"<null>"] ||
                [string isEqualToString:@"null"] ||
                [string isEqualToString:@"NULL"]
                ) {
                return YES;
            } else {
                return NO;
            }
        }
        return NO;
    }
}

///判断对象是否为空
+ (BOOL)isEmptyForObject:(id)object {
    if ([NSObjectCJHelper isNullForObject:object]) {
        return YES;
    }

    //NSString
    if ([object isKindOfClass:[NSString class]]) {
        NSString *string = (NSString *)object;
        if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
            return YES;
        }
        if (string.length == 0){
            return YES;
        }
        return NO;
    }
    
    //NSData
    if ([object isKindOfClass:[NSData class]]) {
        return [((NSData *)object) length]<=0;
    }
    
    //NSDictionary
    if ([object isKindOfClass:[NSDictionary class]]) {
        return [((NSDictionary *)object) count]<=0;
    }
    
    //NSArray
    if ([object isKindOfClass:[NSArray class]]) {
        return [((NSArray *)object) count]<=0;
    }
    
    //NSSet
    if ([object isKindOfClass:[NSSet class]]) {
        return [((NSSet *)object) count]<=0;
    }
    
    return NO;
}



@end
