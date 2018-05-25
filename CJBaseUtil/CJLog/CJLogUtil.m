//
//  CJLogUtil.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 14-12-6.
//  Copyright (c) 2014年 dvlproad. All rights reserved.
//

#import "CJLogUtil.h"

#include <stdarg.h>

static NSString * const logType[4]={@"DEBUG", @"TRACE", @"INFO", @"ERROR"};

void CJAppLog(CJAppLogType appLogType, NSString *tag, NSString *format, ...) //tag即CJAPPLOG_FL
{
    va_list ap;
    va_start(ap, format);
    
    NSString *string = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end(ap);
    
    NSLog(@"%@ %@: %@",logType[appLogType], tag, string);
    
    /*
     NSString *output = [NSString stringWithFormat:@"%@ %@: %@", logType[appLogType], tag, string];
     printf ("%s\n", [output cStringUsingEncoding:NSStringEncodingConversionAllowLossy]);
     */
}







@implementation CJLogUtil

/* 完整的描述请参见文件头部 */
+ (void)cj_appendObject:(id)appendObject toLogFileName:(NSString *)logFileName
{
    NSData *appendingData = nil;
    if ([appendObject isKindOfClass:[NSData class]]) {      //NSData
        appendingData = (NSData *)appendObject;
    }
    if ([appendObject isKindOfClass:[NSString class]]) {    //NSString
        NSString *appendingString = (NSString *)appendObject;
        appendingData = [appendingString dataUsingEncoding:NSUTF8StringEncoding];
        
    } else if ([NSJSONSerialization isValidJSONObject:appendObject]) {//NSDictionary、NSArray
        NSError *error;
        appendingData = [NSJSONSerialization dataWithJSONObject:appendObject options:0 error:&error];
    } else {
        NSString *appendingString = [NSString stringWithFormat:@"this has a unappend appendObject and class is %@", NSStringFromClass([appendObject class])];
        appendingData = [appendingString dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    if (appendingData) {
        [self cj_appendData:appendingData toLogFileName:logFileName];
    }
}

/**
 *  将appendingData追加写入指定文件末尾(log文件统一存放在NSDocumentDirectory下的CJLog文件夹中)
 *
 *  @param appendingData    要追加写入的数据
 *  @param logFileName      追加的内容要写入的指定log文件的文件名
 */
+ (void)cj_appendData:(NSData *)appendingData toLogFileName:(NSString *)logFileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    
    NSString *cjLogDirectoryPath = [documentPath stringByAppendingPathComponent:@"CJLog"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:cjLogDirectoryPath]) {//如果不存在，则建立这个文件夹
        [fileManager createDirectoryAtPath:cjLogDirectoryPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *logFilePath = [cjLogDirectoryPath stringByAppendingPathComponent:logFileName];
    if(![fileManager fileExistsAtPath:logFilePath]) {//如果不存在，则建立这个文件夹
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
    NSMutableData *mutableData = [[NSMutableData alloc] init];
    
    NSString *separateString = @"\n----------------------------------\n";
    NSData *separateData = [separateString dataUsingEncoding:NSUTF8StringEncoding];
    [mutableData appendData:separateData];
    
    [mutableData appendData:appendingData];
    
    [fileHandle writeData:mutableData];
    
    //关闭读写文件
    [fileHandle closeFile];
}

/* 完整的描述请参见文件头部 */
+ (BOOL)cj_removeLogFileName:(NSString *)logFileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    
    NSString *cjLogDirectoryPath = [documentPath stringByAppendingPathComponent:@"CJLog"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:cjLogDirectoryPath]) {
        //NSLog(@"Document下不存在CJLog目录，则默认删除成功");
        return YES;
    }
    
    NSString *logFilePath = [cjLogDirectoryPath stringByAppendingPathComponent:logFileName];
    if(![fileManager fileExistsAtPath:logFilePath]) {
        //NSLog(@"CJLog下不存在该文件，则默认删除成功");
        return YES;
    }
    
    BOOL removeSuccess = [[NSFileManager defaultManager] removeItemAtPath:logFilePath error:nil];
    return removeSuccess;
}

/* 完整的描述请参见文件头部 */
+ (BOOL)cj_removeLogDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    
    NSString *cjLogDirectoryPath = [documentPath stringByAppendingPathComponent:@"CJLog"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:cjLogDirectoryPath]) {
        //NSLog(@"Document下不存在CJLog目录，则默认删除成功");
        return YES;
    }
    
    BOOL removeSuccess = [[NSFileManager defaultManager] removeItemAtPath:cjLogDirectoryPath error:nil];
    return removeSuccess;
}

@end
