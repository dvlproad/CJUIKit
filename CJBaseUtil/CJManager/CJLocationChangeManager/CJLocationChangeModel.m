//
//  CJLocationChangeModel.m
//  CJTotalDemo
//
//  Created by ciyouzen on 2018/1/18.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJLocationChangeModel.h"

@implementation CJLocationChangeModel

- (NSString *)description {
    //addInfoString
    NSMutableString *addInfoString = [[NSMutableString alloc] initWithString:@""];
    
    NSString *currentCalculateTimeString = [NSString stringWithFormat:@"本次计算时间差%zd秒\n", self.secondInterval];
    [addInfoString appendString:currentCalculateTimeString];
    
    NSString *currentAddMilesString = [NSString stringWithFormat:@"行驶距离新增：%.1f米(附百度计算为%.1f米)\n", self.addedMilesFromSystem, self.addedMilesFromBMK];
    [addInfoString appendString:currentAddMilesString];
    
    if (self.KMHSpeed < 12) {
        NSString *lowSpeedMessage = [NSString stringWithFormat:@"本次时速小于12Km/h，时速值为%.2f\n", self.KMHSpeed];;
        [addInfoString appendString:lowSpeedMessage];
    }
    
    
    //warningString
    NSMutableString *warningString = [[NSMutableString alloc] initWithString:@""];
    if (self.KMHSpeed > 150) {
         NSString *string = [NSString stringWithFormat:@"严重警告：本次时速超过了150km/h,请检查是否计算出现问题了\n"];
        [warningString appendString:string];
        
    } else if (self.KMHSpeed > 120) {
        NSString *string = [NSString stringWithFormat:@"警告：本次时速超过了120km/h,请检查是否计算出现问题了\n"];
        [warningString appendString:string];
    }
    
    NSString *lastMessage = [NSString stringWithFormat:@"%@\n%@", addInfoString, warningString];
    return lastMessage;
}

@end
