//
//  CJDateUtil.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2017/8/18.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJDateUtil.h"

@implementation CJDateUtil

#pragma mark - 传入秒得到时分秒算法
///传入 秒  得到 xx:xx:xx
- (NSString *)getHHmmssFromTimeInterval:(NSInteger)timeInterval {
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",timeInterval/3600];
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(timeInterval%3600)/60];
    NSString *str_second = [NSString stringWithFormat:@"%02ld",timeInterval%60];
    
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    
    return format_time;
    
}

///传入 秒  得到  xx分钟xx秒
- (NSString *)getmmssFromTimeInterval:(NSInteger)timeInterval {
    NSString *str_minute = [NSString stringWithFormat:@"%ld",timeInterval/60];
    NSString *str_second = [NSString stringWithFormat:@"%ld",timeInterval%60];
    
    NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    return format_time;
    
}

@end
