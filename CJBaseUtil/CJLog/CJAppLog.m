//
//  CJAppLog.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 14-12-6.
//  Copyright (c) 2014年 dvlproad. All rights reserved.
//

#import "CJAppLog.h"

//@implementation CJAppLog
//
//
//@end

#include <stdarg.h>

static NSString *logType[4]={@"DEBUG", @"TRACE", @"INFO", @"ERROR"};

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
