//
//  CJLogUtil.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJLogUtil.h"

@implementation CJLogUtil

/* 完整的描述请参见文件头部 */
+ (void)cj_writeFileContent:(NSString *)newFileContent toLogFileName:(NSString *)logFileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    
    NSString *cjLogDirectoryPath = [documentPath stringByAppendingPathComponent:@"CJLog"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:cjLogDirectoryPath]){//如果不存在，则建立这个文件夹
        [fileManager createDirectoryAtPath:cjLogDirectoryPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *logFilePath = [cjLogDirectoryPath stringByAppendingPathComponent:logFileName];
    if(![fileManager fileExistsAtPath:logFilePath]){//如果不存在，则建立这个文件夹
        [fileManager createFileAtPath:logFilePath contents:nil attributes:nil];
    }
    
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:logFilePath];
    if(fileHandle == nil)
    {
        NSLog(@"Error: Open of file for writing failed");
    }
    
    //找到并定位到outFile的末尾位置(在此后追加文件)
    [fileHandle seekToEndOfFile];
    
    //读取inFile并且将其内容写到outFile中
    NSString *lastFileContent = [@"\n----------------------------------\n" stringByAppendingString:newFileContent];
    NSData *data = [lastFileContent dataUsingEncoding:NSUTF8StringEncoding];
    
    [fileHandle writeData:data];
    
    //关闭读写文件
    [fileHandle closeFile];
}

@end
