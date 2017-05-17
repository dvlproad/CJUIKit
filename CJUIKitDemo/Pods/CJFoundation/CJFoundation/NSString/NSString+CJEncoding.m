//
//  NSString+CJEncoding.m
//  CJFoundationDemo
//
//  Created by lichq on 15/3/25.
//  Copyright (c) 2015年 lichq. All rights reserved.
//

#import "NSString+CJEncoding.h"

static NSString * const CharactersToBeEscapedInQueryString = @"!*'\"();:@&=+$,/?%#[]% ";

@implementation NSString (Encoding)

/** 完整的描述请参见文件头部 */
- (NSString *)cjEncodeUnicodeToChinese{
    
    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2]stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString* returnStr =
        /*
        [NSPropertyListSerialization propertyListFromData:tempData
                                         mutabilityOption:NSPropertyListImmutable
                                                   format:NULL
                                         errorDescription:NULL];
        */
        //iOS8.0以后
        [NSPropertyListSerialization propertyListWithData:tempData
                                                  options:NSPropertyListImmutable
                                                   format:NULL
                                                    error:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
    
}



- (NSString *)cjEncodeURL {
    return [self URLEncodeUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)cjDecodeURL {
    return [self URLDecodeUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark - Private
- (NSString *)URLEncodeUsingEncoding:(NSStringEncoding)encoding {
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (__bridge CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)CharactersToBeEscapedInQueryString,
                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding));
}

- (NSString *)URLDecodeUsingEncoding:(NSStringEncoding)encoding {
    return (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                 (__bridge CFStringRef)self,
                                                                                                 CFSTR(""),
                                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding));
}





@end
