//
//  CJFileManager+CalculateFileSize.m
//  CommonFMDBUtilDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJFileManager+CalculateFileSize.h"

@implementation CJFileManager (CalculateFileSize)

/** 完整的描述请参见文件头部 */
+ (NSInteger)calculateFileSizeForFileAbsolutePath:(NSString *)fileAbsolutePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //判断字符串是否为文件/文件夹
    BOOL isFileDirectory = NO;
    BOOL isFileExists = [fileManager fileExistsAtPath:fileAbsolutePath
                                          isDirectory:&isFileDirectory];
    if (isFileExists == NO) {
        //NSLog(@"文件/文件夹不存在");
        return 0;
    }
    
    NSInteger totalByteSize = 0;
    //unsigned long long totalByteSize = 0;
    if (isFileDirectory == NO){   //fileAbsolutePath是文件路径
        NSDictionary *attributes = [fileManager attributesOfItemAtPath:fileAbsolutePath error:nil];
        totalByteSize += [attributes[NSFileSize] integerValue];
        //totalByteSize += attributes.fileSize;
        
    } else {    //fileAbsolutePath是文件夹路径，遍历文件夹中的所有内容，计算文件夹大小
        NSArray *subpaths = [fileManager subpathsAtPath:fileAbsolutePath];
        for (NSString *subpath in subpaths) {
            NSString *subFileAbsolutePath = [fileAbsolutePath stringByAppendingPathComponent:subpath];
            
            BOOL isSubFileDirectory = NO;
            [fileManager fileExistsAtPath:subFileAbsolutePath isDirectory:&isSubFileDirectory];
            if (isSubFileDirectory == NO){
                NSDictionary *attributes = [fileManager attributesOfItemAtPath:subFileAbsolutePath error:nil];
                totalByteSize += [attributes[NSFileSize] integerValue];
                //totalByteSize += attributes.fileSize;
                
            } else {
                totalByteSize += [self calculateFileSizeForFileAbsolutePath:subFileAbsolutePath];
            }
        }
        
    }
    
    return totalByteSize;
}

/** 完整的描述请参见文件头部 */
+ (NSString *)showFileSize:(NSInteger)fileSize unitType:(CJFileSizeUnitType)fileSizeUnitType {
    NSString *fileSizeString = @"";
    
    switch (fileSizeUnitType) {
        case CJFileSizeUnitTypeBestUnit:
        {
            if (fileSize >= pow(10, 9)) { // size >= 1GB
                fileSizeString = [NSString stringWithFormat:@"%.2fGB", fileSize / pow(10, 9)];
                
            } else if (fileSize >= pow(10, 6)) { // 1GB > size >= 1MB
                fileSizeString = [NSString stringWithFormat:@"%.2fMB", fileSize / pow(10, 6)];
                
            } else if (fileSize >= pow(10, 3)) { // 1MB > size >= 1KB
                fileSizeString = [NSString stringWithFormat:@"%.2fKB", fileSize / pow(10, 3)];
                
            } else { // 1KB > size
                fileSizeString = [NSString stringWithFormat:@"%zdB", fileSize];
            }
            break;
        }
        case CJFileSizeUnitTypeB:
        {
            fileSizeString = [NSString stringWithFormat:@"%zdB", fileSize];
            break;
        }
        case CJFileSizeUnitTypeKB:
        {
            fileSizeString = [NSString stringWithFormat:@"%.2fKB", fileSize / pow(10, 3)];
            break;
        }
        case CJFileSizeUnitTypeMB:
        {
            fileSizeString = [NSString stringWithFormat:@"%.2fMB", fileSize / pow(10, 6)];
            break;
        }
        case CJFileSizeUnitTypeGB:
        {
            fileSizeString = [NSString stringWithFormat:@"%.2fGB", fileSize / pow(10, 9)];
            break;
        }
        default:
        {
            break;
        }
    }
    
    return fileSizeString;
}

@end
