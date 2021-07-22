//
//  ServerSensitiveCJHelper.h
//  AppServerHelper
//
//  Created by ciyouzen on 2018/10/22.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN NSString *sensitive_nickname;
FOUNDATION_EXTERN NSString *sensitive_others;

@interface ServerSensitiveCJHelper : NSObject

/*
 *  下载指定版本的敏感词库
 *
 *  @param version              要下载的敏感词库版本
 *  @param sensitiveFileUrl     敏感词库的文件地址
 *  @param completeBlock        敏感词库下载完成的回调
 */
+ (void)checkAndDownloadSensitiveWithVersion:(NSString *)version
                            sensitiveFileUrl:(NSString *)sensitiveFileUrl
                               completeBlock:(void(^)(void))completeBlock;

+ (BOOL)checkTexts:(NSArray<NSString *> *)texts;

+ (BOOL)checkText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
