//
//  ServerSensitiveCJHelper.m
//  AppServerHelper
//
//  Created by ciyouzen on 2018/10/22.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "ServerSensitiveCJHelper.h"

NSString *sensitive_nickname                = @"输入文字中包含敏感内容，请修改";
NSString *sensitive_others                  = @"输入文字中包含敏感内容，请修改";

@implementation ServerSensitiveCJHelper

/*
 *  下载指定版本的敏感词库
 *
 *  @param version              要下载的敏感词库版本
 *  @param sensitiveFileUrl     敏感词库的文件地址
 *  @param completeBlock        敏感词库下载完成的回调
 */
+ (void)checkAndDownloadSensitiveWithVersion:(NSString *)version
                            sensitiveFileUrl:(NSString *)sensitiveFileUrl
                               completeBlock:(void(^)(void))completeBlock
{
    NSString *localVer = [[NSUserDefaults standardUserDefaults] objectForKey:@"CQ_SENSITIVE_VERSION"];
    BOOL newVersion = ![localVer isEqualToString:version];
    
    NSString *chachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [chachePath stringByAppendingPathComponent:@"mgc.txt"];
    BOOL fileExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    
    if (!fileExist || newVersion) { // 如果不存在或者版本更新，则使用新的
        if (fileExist) {
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        }
        __weak __typeof(&*self)weakSelf = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSError *error = nil;
            NSURL *sensitiveFileURL = [NSURL URLWithString:sensitiveFileUrl];
            NSString *strTxt = [NSString stringWithContentsOfURL:sensitiveFileURL encoding:NSUTF8StringEncoding error:&error];
            [strTxt writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error]; // 写入到磁盘中
            
            if (!error) {
                [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"CQ_SENSITIVE_VERSION"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                
            } else {
                //
            }
            
            !completeBlock ?: completeBlock();
        });
    }
}


+ (BOOL)checkTexts:(NSArray<NSString *> *)texts {
    BOOL haveSensitive = NO;
    for (NSString *text in texts) {
        haveSensitive = [self checkText:text];
        if (haveSensitive) {
            break;
        }
    }
    return haveSensitive;
}

+ (BOOL)checkText:(NSString *)text {
    NSString *chachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [chachePath stringByAppendingPathComponent:@"mgc.txt"];

//    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"mgc" ofType:@"txt"];
    NSString *strAllWord = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    strAllWord  = [strAllWord stringByReplacingOccurrencesOfString:@"\r\n" withString:@"~!@#$%^&"];
    strAllWord  = [strAllWord stringByReplacingOccurrencesOfString:@"\n" withString:@"~!@#$%^&"];

    NSArray <NSString *>*arrayMgc = [strAllWord componentsSeparatedByString:@"~!@#$%^&"];
    __block BOOL haveSW = NO;
    [arrayMgc enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([text containsString:obj]) {
            *stop = YES;
            haveSW = YES;
        }
    }];
    return haveSW;
}


@end
