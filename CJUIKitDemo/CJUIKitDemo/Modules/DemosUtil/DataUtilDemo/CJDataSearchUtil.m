//
//  CJDataSearchUtil.m
//  CJUIKitDemo
//
//  Created by 李超前 on 2018/3/19.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CJDataSearchUtil.h"

@implementation CJDataSearchUtil


+ (NSInteger)binarySearchWithRecursion:(NSString *)propertyName value:(double)value inArray:(NSMutableArray *)array
{
    return [self binarySearchWithRecursion:propertyName value:value inArray:array low:0 high:array.count - 1];
}

+ (NSInteger)binarySearchWithRecursion:(NSString *)propertyName value:(double)value inArray:(NSMutableArray *)array low:(NSInteger)low high:(NSInteger)high
{
    if (low > high)
    {
        return -1;
    }
    
    //因为相比除法运算来说，计算机处理位运算要快得多。这里也等同于（NSInteger mid = low + (high - low) / 2）
    NSInteger mid = low + ((high - low) >> 1);
    double middleNumber = [[array[mid] valueForKey:propertyName] doubleValue];
    if ([@(middleNumber) compare:@(value)] == NSOrderedSame) {
        return mid;
        
    } else if ([@(middleNumber) compare:@(value)] == NSOrderedAscending) {
        return [self binarySearchWithRecursion:propertyName value:value inArray:array low:mid + 1 high:high];
        
    } else {
        return [self binarySearchWithRecursion:propertyName value:value inArray:array low:low high:mid - 1];
    }
}

@end
