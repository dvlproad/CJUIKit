//
//  CJDateUtil.h
//  CJFoundationDemo
//
//  Created by ciyouzen on 2017/8/18.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  与时间相关的处理工具
 */
@interface CJDateUtil : NSString

#pragma mark - 传入秒得到时分秒算法
///传入 秒  得到 xx:xx:xx
- (NSString *)getHHmmssFromTimeInterval:(NSInteger)timeInterval;

///传入 秒  得到  xx分钟xx秒
- (NSString *)getmmssFromTimeInterval:(NSInteger)timeInterval;

@end
