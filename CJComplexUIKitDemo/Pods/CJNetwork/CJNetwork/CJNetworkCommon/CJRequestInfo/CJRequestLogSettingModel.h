//
//  CJRequestLogSettingModel.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2018/5/8.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  网络请求中的Log相关设置

#import <Foundation/Foundation.h>

/// 网络请求结果显示方式
typedef NS_ENUM(NSUInteger, CJRequestLogType) {
    CJRequestLogTypeNone = 0,
    CJRequestLogTypeClean,
    CJRequestLogTypeConsoleLog,
    CJRequestLogTypeSuppendWindow,
};


@interface CJRequestLogSettingModel : NSObject {
    
}

@end
