//
//  CJFileManager+DeleteCleanFile.m
//  CommonFMDBUtilDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJFileManager+DeleteCleanFile.h"

@implementation CJFileManager (DeleteCleanFile)

#pragma mark - 删除单个文件
+ (void)deleteFileWithFileName:(NSString *)fileName inRelativeDirectoryPath:(NSString *)relativeDirectoryPath
{
    NSString *absoluteDirectoryPath = [NSHomeDirectory() stringByAppendingString:relativeDirectoryPath];
    if (![[NSFileManager defaultManager] fileExistsAtPath:absoluteDirectoryPath]){
        NSLog(@"要删除的文件所在的目录不存在");
        return;
    }
    
    NSString *absoluteFilePath = [absoluteDirectoryPath stringByAppendingPathComponent:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:absoluteFilePath]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:absoluteFilePath error:&error];
        if (error) {
            NSLog(@"删除单个文件的时候出现错误：%@",error.localizedDescription);
        }
        
    } else {
        NSLog(@"要删除的文件不存在");
    }
}

#pragma mark - 删除多个文件
/** 完整的描述请参见文件头部 */
+ (void)cleanFilesExpiration:(unsigned long long)expiration inRelativeDirectoryPath:(NSString *)relativeDirectoryPath {
    NSDate *expirationDate = [NSDate dateWithTimeIntervalSinceNow:-expiration];
    
    NSString *absoluteDirectoryPath = [NSHomeDirectory() stringByAppendingString:relativeDirectoryPath];
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:absoluteDirectoryPath];
    for (NSString *fileName in fileEnumerator)
    {
        NSString *filePath = [absoluteDirectoryPath stringByAppendingPathComponent:fileName];
        NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        if ([[attributes fileModificationDate] compare:expirationDate] == NSOrderedAscending)
        {
            NSError *error = nil;
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
            if (error) {
                NSLog(@"清理过期文件时候出现错误：%@",error.localizedDescription);
            }
        }
    }
}

/** 完整的描述请参见文件头部 */
+ (void)clearFilesInRelativeDirectoryPath:(NSString *)relativeDirectoryPath {
    [self cleanFilesExpiration:0 inRelativeDirectoryPath:relativeDirectoryPath];
}

@end
