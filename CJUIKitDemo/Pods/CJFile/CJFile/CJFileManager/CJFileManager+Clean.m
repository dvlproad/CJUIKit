//
//  CJFileManager+Clean.m
//  CommonFMDBUtilDemo
//
//  Created by lichq on 6/25/15.
//  Copyright (c) 2015 ciyouzen. All rights reserved.
//

#import "CJFileManager+Clean.h"

@implementation CJFileManager (Clean)

/** 完整的描述请参见文件头部 */
+ (void)cleanFileExpiration:(unsigned long long)expiration inRelativeDirectoryPath:(NSString *)relativeDirectoryPath {
    NSDate *expirationDate = [NSDate dateWithTimeIntervalSinceNow:-expiration];
    
    
    NSString *absoluteDirectoryPath = [NSHomeDirectory() stringByAppendingString:relativeDirectoryPath];
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:absoluteDirectoryPath];
    for (NSString *fileName in fileEnumerator)
    {
        NSString *filePath = [absoluteDirectoryPath stringByAppendingPathComponent:fileName];
        NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        if ([[attributes fileModificationDate] compare:expirationDate] == NSOrderedAscending)
        {
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        }
    }
}

@end
