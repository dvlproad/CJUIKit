//
//  CJFileManager+SaveFileData.m
//  CommonFMDBUtilDemo
//
//  Created by lichq on 6/25/15.
//  Copyright (c) 2015 ciyouzen. All rights reserved.
//

#import "CJFileManager+SaveFileData.h"

@implementation CJFileManager (SaveData)

/** 完整的描述请参见文件头部 */
+ (BOOL)saveFileData:(NSData *)data
        withFileName:(NSString *)fileName
toRelativeDirectoryPath:(NSString *)relativeDirectoryPath
{
    NSString *relativeFilePath = [relativeDirectoryPath stringByAppendingPathComponent:fileName];
    NSString *absoluteFilePath = [NSHomeDirectory() stringByAppendingPathComponent:relativeFilePath];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:absoluteFilePath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:absoluteFilePath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:NULL];
    }
    
    BOOL saveSuccess = [data writeToFile:absoluteFilePath atomically:YES];
    return saveSuccess;
}

@end
