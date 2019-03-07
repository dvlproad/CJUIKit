//
//  CJFileManager+DeleteCleanFile.h
//  CommonFMDBUtilDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJFileManager.h"

@interface CJFileManager (DeleteCleanFile)

/**
 *  删除单个文件
 *
 *  @param fileName                 要删除的文件名称
 *  @param relativeDirectoryPath    要删除的文件所在的相对目录
 */
+ (void)deleteFileWithFileName:(NSString *)fileName inRelativeDirectoryPath:(NSString *)relativeDirectoryPath;

#pragma mark - 删除多个文件
/**
 *  清理relativeDirectoryPath中的距离今天超过expiration秒的文件（即只保存最近一段时间的文件）
 *
 *  @param expiration               距离当天多长时间（单位秒）
 *  @param relativeDirectoryPath    要清理的目录
 */
+ (void)cleanFilesExpiration:(unsigned long long)expiration inRelativeDirectoryPath:(NSString *)relativeDirectoryPath;


/**
 *  清空relativeDirectoryPath中所有文件
 *
 *  @param relativeDirectoryPath    要清理的目录
 */
+ (void)clearFilesInRelativeDirectoryPath:(NSString *)relativeDirectoryPath;

@end
