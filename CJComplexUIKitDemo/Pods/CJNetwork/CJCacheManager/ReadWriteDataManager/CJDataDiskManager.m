//
//  CJDataDiskManager.m
//  CommonFMDBUtilDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJDataDiskManager.h"

@implementation CJDataDiskManager

/** 完整的描述请参见文件头部 */
+ (BOOL)saveFileData:(NSData *)data
        withFileName:(NSString *)fileName
toRelativeDirectoryPath:(NSString *)relativeDirectoryPath
{
    NSAssert(data && fileName && relativeDirectoryPath, @"要缓存到磁盘的数据、地址及以什么作为文件名等都不能为空");
    
    NSString *absoluteDirectoryPath = [NSHomeDirectory() stringByAppendingPathComponent:relativeDirectoryPath];
    if (![[NSFileManager defaultManager] fileExistsAtPath:absoluteDirectoryPath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:absoluteDirectoryPath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:NULL];
    }
    
    NSString *absoluteFilePath = [absoluteDirectoryPath stringByAppendingPathComponent:fileName];
    BOOL saveSuccess = [[NSFileManager defaultManager] createFileAtPath:absoluteFilePath contents:data attributes:nil]; //两种接口二选一即可
    //BOOL saveSuccess = [data writeToFile:absoluteFilePath atomically:YES];
    
    return saveSuccess;
}

/** 完整的描述请参见文件头部 */
+ (NSData *)readFileDataWithFileName:(NSString *)fileName
           fromRelativeDirectoryPath:(NSString *)relativeDirectoryPath
{
    NSAssert(fileName && relativeDirectoryPath, @"要读取的文件地址、文件名都不能为空");
    
    NSString *absoluteDirectoryPath = [NSHomeDirectory() stringByAppendingPathComponent:relativeDirectoryPath];
    if (![[NSFileManager defaultManager] fileExistsAtPath:absoluteDirectoryPath]){
        return nil;
    }
    
    NSString *absoluteFilePath = [absoluteDirectoryPath stringByAppendingPathComponent:fileName];
    //NSData *data = [[NSData alloc] initWithContentsOfFile:absoluteFilePath];
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:absoluteFilePath];
    
    return data;
}


@end
