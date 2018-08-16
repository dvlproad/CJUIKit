//
//  NSStringHelper.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "NSStringHelper.h"

@implementation NSStringHelper

#pragma mark - 判断是否为空字符串
///是否为空字符串
+ (BOOL)isEmptyForString:(NSString *)string {
    BOOL isEmpty = !string || [string isEqual:[NSNull null]] || [string isEqualToString:@""];
    return isEmpty;
}

///判断自己是否为空
+ (BOOL)isBlankForString:(NSString *)string {
    if (!string ||
        string == nil ||
        string == NULL ||
        (NSNull *)string == [NSNull null] ||
        [string isKindOfClass:[NSNull class]] ||
        [string isEqualToString:@"(null)"] ||
        [string isEqualToString:@"<null>"] ||
        [string isEqualToString:@"null"] ||
        [string isEqualToString:@"NULL"]
        ) {
        return YES;
    }else {
        return NO;
    }
}

@end
