//
//  CJLogUtil.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  log工具
 */
@interface CJLogUtil : NSObject

/**
 *  将newFileContent追加写入logFileName文件末尾
 *
 *  @param newFileContent   要追加写入的内容
 *  @param logFileName      内容要写入的文件名
 */
+ (void)cj_writeFileContent:(NSString *)newFileContent toLogFileName:(NSString *)logFileName;

@end
