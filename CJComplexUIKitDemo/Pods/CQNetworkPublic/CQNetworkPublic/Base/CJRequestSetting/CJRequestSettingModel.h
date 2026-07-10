//
//  CJRequestSettingModel.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2018/5/8.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJRequestSettingEnum.h"               // 网络请求中的请求方式、Log显示等相关设置
#import "CJRequestCacheSettingModel.h"  // 网络请求中的缓存相关设置

NS_ASSUME_NONNULL_BEGIN

@interface CJRequestSettingModel : NSObject {
    
}
#pragma mark log相关
// log类型(默认CJRequestLogTypeConsoleLog，但是 requestModel.settingModel 默认值是空的 )
@property (nonatomic, assign) CJRequestLogType logType;

#pragma mark 加密相关

// 加密方法
@property (nullable, nonatomic, copy) NSData* (^encryptBlock)(NSDictionary *requestParmas);

// 解密方法
@property (nullable, nonatomic, copy) NSDictionary* (^decryptBlock)(NSString *responseString);


#pragma mark 缓存相关
// 网络请求中的缓存相关设置
@property (nullable, nonatomic, strong) CJRequestCacheSettingModel *requestCacheModel;

@end

NS_ASSUME_NONNULL_END
