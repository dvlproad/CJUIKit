//
//  CJLogUtil.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 14-12-6.
//  Copyright (c) 2014年 dvlproad. All rights reserved.
//


//我们会在发行版（Release）取消所有的Log。如果一行一行地去注释掉Log，显然不是一个明确的选择
#ifdef CJDEBUG
    #define CJLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
    #define CJLog(fmt, ...) /* */
#endif

typedef NS_ENUM(NSUInteger, CJAppLogType) {
    CJAppLogTypeDEBUG,
    CJAppLogTypeTRACE,
    CJAppLogTypeINFO,
    CJAppLogTypeERROR
};

void CJAppLog(CJAppLogType appLogType, NSString *tag, NSString *format, ...);





#import <Foundation/Foundation.h>

/**
 *  log工具
 */
@interface CJLogUtil : NSObject

/**
 *  将appendObject追加写入指定文件末尾(log文件统一存放在NSDocumentDirectory下的CJLog文件夹中)
 *
 *  @param appendObject     要追加写入的数据（NSData、NSString、NSDictrionary、NSArray）
 *  @param logFileName      追加的内容要写入的指定log文件的文件名
 */
+ (void)cj_appendObject:(id)appendObject toLogFileName:(NSString *)logFileName;

/**
 *  删除指定的log文件
 *
 *  @param logFileName  指定的log文件
 *
 *  @return 是否删除成功
 */
+ (BOOL)cj_removeLogFileName:(NSString *)logFileName;

/**
 *  删除所有的log文件
 *
 *  @return 是否删除成功
 */
+ (BOOL)cj_removeLogDirectory;

@end






