//
//  NSString+CJTextLength.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "NSString+CJTextLength.h"
#import <CoreText/CoreText.h>

@implementation NSString (CJCalculateSize)

//得到中英文混合字符串长度 方法2
- (NSInteger)cj_length {
//    // 错误方法：一二三四五六七八九十 计算出来的长度不是20，而是19
//    int length = 0;
//    char *p = (char *)[self cStringUsingEncoding:NSUnicodeStringEncoding];
//    for (int i=0; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
//        if (*p) {
//            p++;
//            length++;
//        } else {
//            p++;
//        }
//    }
//    return length;
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData *data = [self dataUsingEncoding:enc];
    int length = [data length];
    return length;
}


@end
