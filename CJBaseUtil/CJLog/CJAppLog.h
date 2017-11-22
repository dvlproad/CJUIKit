//
//  CJAppLog.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 14-12-6.
//  Copyright (c) 2014年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

//@interface CJAppLog : NSObject
//
//@end

typedef NS_ENUM(NSUInteger, CJAppLogType) {
    CJAppLogTypeDEBUG,
    CJAppLogTypeTRACE,
    CJAppLogTypeINFO,
    CJAppLogTypeERROR
};

#define CJAppLog_FL   [NSString stringWithFormat:@"%s:%d", __func__, __LINE__]


#if CJDEBUG
    #define CJLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ## __VA_ARGS__)
#else
    #define CJLog(fmt, ...) /* */
#endif

void CJAppLog(CJAppLogType appLogType, NSString *tag, NSString *format, ...);


