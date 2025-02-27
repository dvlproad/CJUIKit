//
//  CQTSSandboxPathUtil.m
//  CQDemoKit
//
//  Created by lcQian on 2020/4/7.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CQTSSandboxPathUtil.h"
#import "CQTSResourceUtil.h"

@implementation CQTSSandboxPathUtil

#pragma mark - Get Path Info
/// 获取路径信息
///
/// @param sandboxURL                                要放到的沙盒host位置
/// @param subDirectory                            要放到的沙盒的子目录
/// @param fileNameWithExtension        要拷贝的文件
/// @param shouldCreateIntermediateDirectories      中间目录不存在时候是否创建
///
/// @return 返回文件路径信息（获取失败，返回nil）
+ (nullable NSDictionary *)pathInfoWithHostSandboxURL:(nonnull NSURL *)sandboxURL
                                         subDirectory:(nullable NSString *)subDirectory
                                fileNameWithExtension:(NSString *)fileNameWithExtension
                  shouldCreateIntermediateDirectories:(BOOL)shouldCreateIntermediateDirectories
{
    NSDictionary *result = [CQTSResourceUtil extractFileNameAndExtensionFromFileName:fileNameWithExtension];
    NSString *fileName = result[@"fileName"];
    NSString *fileExtension = result[@"fileExtension"];
    
    // 创建目标路径（共享资源目录下的目标文件路径）:相对路径
    NSString *relativePath = @"";
    if (subDirectory != nil && subDirectory.length > 0) {
        relativePath = subDirectory;
    }
    NSString *newFileName = [NSString stringWithFormat:@"%@.%@", fileName, fileExtension];
    relativePath = [relativePath stringByAppendingPathComponent:newFileName];
    // 完整的绝对路径
    NSURL *destinationURL = [sandboxURL URLByAppendingPathComponent:relativePath];

    if (shouldCreateIntermediateDirectories) {
        // 检查并创建目标路径的父目录（一次性创建所有中间目录）
        NSURL *parentDirectoryURL = [destinationURL URLByDeletingLastPathComponent];
        BOOL isDirectory;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:parentDirectoryURL.path isDirectory:&isDirectory] || !isDirectory) {
            NSError *createDirError;
            if (![fileManager createDirectoryAtURL:parentDirectoryURL
                       withIntermediateDirectories:YES attributes:nil error:&createDirError])
            {
                NSLog(@"Failed to create directory: %@", createDirError.localizedDescription);
                return nil;
            }
        }
    }

    NSLog(@"File copied to shared directory: %@", destinationURL.path);
    return @{
        @"fileName": fileName,
        @"fileExtension": fileExtension,
        @"absoluteFilePath": destinationURL.path,
        @"relativeFilePath": relativePath       // 相对 sandboxURL 的相对路径
    };
}


/// 将相对路径补全为绝对路径
///
/// @param relativeFilePath                   要补全的相对路径
/// @param sandboxType                              在那个沙盒中补全
/// @param checkIfExist                            是否要检查存在
///
/// @return 补全后的绝对路径（补全失败则返回nil。如果要检查文件是否存在，则不存在文件时，则返回nil）
+ (nullable NSString *)makeupAbsoluteFilePath:(NSString *)relativeFilePath
                                toSandboxType:(CQTSSandboxType)sandboxType
                                 checkIfExist:(BOOL)checkIfExist
{
    NSString *sandboxPath = [CQTSSandboxPathUtil sandboxPath:sandboxType];
    NSString *absoluteFilePath = [sandboxPath stringByAppendingPathComponent:relativeFilePath];
    
    if (checkIfExist) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:absoluteFilePath]) {
            return nil;
        }
    }
    
    return absoluteFilePath;
}

/// 将相对路径补全为绝对路径
///
/// @param relativeFilePath                   要补全的相对路径
/// @param appGroupId                                共享目录的id
/// @param checkIfExist                            是否要检查存在
///
/// @return 补全后的绝对路径（补全失败则返回nil。如果要检查文件是否存在，则不存在文件时，则返回nil）
+ (nullable NSString *)makeupAbsoluteFilePath:(NSString *)relativeFilePath
                                 toAppGroupId:(NSString *)appGroupId
                                 checkIfExist:(BOOL)checkIfExist
{
    NSURL *sandboxURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:appGroupId];
    NSString *sandboxPath = sandboxURL.path;
    NSString *absoluteFilePath = [sandboxPath stringByAppendingPathComponent:relativeFilePath];
    
    if (checkIfExist) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:absoluteFilePath]) {
            return nil;
        }
    }
    
    return absoluteFilePath;
}

/// 获取共享目录的沙盒目录路径
+ (NSURL *)sandboxURLWithAppGroupId:(nonnull NSString *)appGroupId {
    NSURL *sandboxURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:appGroupId];
    return sandboxURL;
}

/// 获取指定类型的沙盒目录路径
+ (NSURL *)sandboxURL:(CQTSSandboxType)sandboxType {
    NSString *sandboxPath = [CQTSSandboxPathUtil sandboxPath:sandboxType];
    NSURL *sandboxURL = [NSURL fileURLWithPath:sandboxPath];
    return sandboxURL;
}
+ (NSString *)sandboxPath:(CQTSSandboxType)sandboxType {
    NSString *sandboxPath;
    
    switch (sandboxType) {
        case CQTSSandboxTypeHome: {
            sandboxPath = NSHomeDirectory();
            break;
        }
        case CQTSSandboxTypeDocuments: {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            sandboxPath = paths.firstObject;
            break;
        }
        case CQTSSandboxTypeLibrary: {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
            sandboxPath = paths.firstObject;
            break;
        }
        case CQTSSandboxTypeCaches: {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            sandboxPath = paths.firstObject;
            break;
        }
        case CQTSSandboxTypeTemporary: {
            sandboxPath = NSTemporaryDirectory();
            break;
        }
        default:
            break;
    }
    return sandboxPath;
}

+ (NSString *)homeDirectory {
    return NSHomeDirectory();
}

+ (NSString *)documentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return paths.firstObject;
}

+ (NSString *)libraryDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return paths.firstObject;
}

+ (NSString *)cachesDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return paths.firstObject;
}

+ (NSString *)temporaryDirectory {
    return NSTemporaryDirectory();
}

@end
