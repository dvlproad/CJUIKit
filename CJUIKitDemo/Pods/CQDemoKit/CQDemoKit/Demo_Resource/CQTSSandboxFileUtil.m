//
//  CQTSSandboxFileUtil.m
//  CQDemoKit
//
//  Created by lcQian on 2020/4/7.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CQTSSandboxFileUtil.h"
#import "CQTSSandboxPathUtil.h"
#import "NSError+CQTSErrorString.h"

@implementation CQTSSandboxFileUtil

#pragma mark - Copy Bundle File
/// 拷贝主工程中的文件到沙盒中
///
/// @param fileNameWithExtension        要拷贝的文件
/// @param inBundle                                     从项目中的哪个bundle中拷贝（nil时候为 [NSBundle mainBundle] ）
/// @param sandboxURL                                要放到的沙盒位置
/// @param subDirectory                             要放到的沙盒的子目录
///
/// @return 返回存放后的文件路径信息（存放失败，返回nil）
+ (nullable NSDictionary *)copyFile:(NSString *)fileNameWithExtension
                           inBundle:(nullable NSBundle *)bundle
                       toSandboxURL:(nonnull NSURL *)sandboxURL
                       subDirectory:(nullable NSString *)subDirectory
{
    if (sandboxURL == nil) {
        NSLog(@"失败");
        return nil;
    }
    
    NSDictionary *pathInfo = [CQTSSandboxPathUtil pathInfoWithHostSandboxURL:sandboxURL
                                                                subDirectory:subDirectory
                                                       fileNameWithExtension:fileNameWithExtension
                                         shouldCreateIntermediateDirectories:YES];
    
    NSString *fileName = pathInfo[@"fileName"];
    NSString *fileExtension = pathInfo[@"fileExtension"];
    
    // 获取项目工程中要拷贝的文件的路径
    if (bundle == nil) {
        bundle = [NSBundle mainBundle];
    }
    NSURL *imageURL = [bundle URLForResource:fileName withExtension:fileExtension];
    if (!imageURL) {
        NSLog(@"Image not found in bundle");
        return nil;
    }

    // 创建目标路径（共享资源目录下的目标文件路径）:相对路径
    NSURL *destinationPath = pathInfo[@"absoluteFilePath"];
    NSURL *destinationURL = [NSURL fileURLWithPath:destinationPath];

    NSError *error = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 检查目标文件是否已存在，如果存在则删除它
    if ([fileManager fileExistsAtPath:destinationURL.path]) {
        if (![fileManager removeItemAtURL:destinationURL error:&error]) {
            NSLog(@"Failed to remove existing file: %@", error.localizedDescription);
            return nil;
        }
    }
    
    // 将图片从源目录复制到共享目录
    if (![fileManager copyItemAtURL:imageURL toURL:destinationURL error:&error]) {
        NSLog(@"Failed to copy file: %@", error.localizedDescription);
        return nil;
    }

    NSLog(@"File copied to shared directory: %@", destinationURL.path);
    return pathInfo;
}


+ (void)downloadFileWithUrl:(NSString *)fileUrl
               toSandboxURL:(NSURL *)sandboxURL
               subDirectory:(nullable NSString *)subDirectory
                   fileName:(nullable NSString *)fileNameWithExtension
                    success:(void (^)(NSDictionary *fileDictionary))success
                    failure:(void (^)(NSString *errorMessage))failure
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [weakSelf _downloadFileWithUrl:fileUrl
                          toSandboxURL:sandboxURL
                         subDirectory:subDirectory
                             fileName:fileNameWithExtension
                              success:^(NSDictionary * _Nonnull fileDictionary) {
            dispatch_async(dispatch_get_main_queue(), ^{
                success(fileDictionary);
            });
        } failure:^(NSString * _Nonnull errorMessage) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(errorMessage);
            });
        }];
    });
}


+ (void)_downloadFileWithUrl:(NSString *)fileUrl
                toSandboxURL:(NSURL *)sandboxURL
               subDirectory:(nullable NSString *)subDirectory
                   fileName:(nullable NSString *)fileNameWithExtension
                    success:(void (^)(NSDictionary *fileDictionary))success
                    failure:(void (^)(NSString *errorMessage))failure
{
    NSURL *fileURL = [NSURL URLWithString:fileUrl];
    if (!fileURL) {
        failure(@"fileUrl错误");
        return;
    }
    
    NSURLSessionDownloadTask *downloadTask = [[NSURLSession sharedSession] downloadTaskWithURL:fileURL completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (!location || !response || error || ((NSHTTPURLResponse *)response).statusCode != 200) {
            failure(error.cqtsErrorString);
            return;
        }
        
        NSError *fileError = nil;
        NSData *data = [NSData dataWithContentsOfURL:location options:0 error:&fileError];
        if (!data || fileError) {
            failure(fileError.cqtsErrorString);
            return;
        }
        
        NSString *lastFileNameWithExtension = fileNameWithExtension == nil ? fileUrl.lastPathComponent : fileNameWithExtension;

        
        NSDictionary *pathInfo = [CQTSSandboxPathUtil pathInfoWithHostSandboxURL:sandboxURL subDirectory:subDirectory fileNameWithExtension:lastFileNameWithExtension shouldCreateIntermediateDirectories:YES];
        if (pathInfo == nil) {
            failure(@"获取路径信息失败");
            return;
        }
        NSString *destinationPath = pathInfo[@"absoluteFilePath"];
        [data writeToFile:destinationPath options:0 error:&fileError];
        if (fileError) {
            failure(fileError.cqtsErrorString);
            
        } else {
            NSLog(@"File success download to directory: %@", destinationPath);
            success(pathInfo);
        }
    }];
    
    [downloadTask resume];
}


@end
