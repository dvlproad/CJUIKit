//
//  NSString+CJAccuracy.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "NSString+CJAccuracy.h"

@implementation NSString (CJAccuracy)

///删除尾部多余的零
- (NSString *)removeEndZero {
    NSString *originNumberString = self;
    NSNumber *number = @(originNumberString.floatValue);
    NSString *lastNumberString = [NSString stringWithFormat:@"%@", number];
    
    return lastNumberString;
}

@end
