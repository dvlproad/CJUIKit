//
//  CJLogModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 用来保存 log 的 Model 类
 */
@interface CJLogModel : NSObject

@property (nonatomic, assign) double timestamp;     /**< log 产生的时间戳，单位为 秒 */
@property (nonatomic, strong) NSString *logString;  /**< log 文本 */

+ (instancetype)logWithString:(NSString *)logString;

@end
