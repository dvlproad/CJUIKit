//
//  DemoCacheUtil.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/1/18.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "DemoCacheUtil.h"
#import <CJFile/CJFileManager+GetCreatePath.h>
#import <CJFile/CJFileManager+SaveFileData.h>
#import <CJFile/CJFileManager+DeleteCleanFile.h>

@implementation DemoCacheUtil

#pragma mark - Save
/// 保存图片到Document下的moduleType模块
+ (BOOL)saveImageData:(NSData *)imageData forModuleType:(DemoModuleType)moduleType callback:(void(^)(NSString *absoluteImagePath, NSString *imageName))callback {
    NSString *imageName = [self dateImageName];
    return [self saveImageData:imageData withImageName:imageName forModuleType:moduleType callback:^(NSString *absoluteImagePath) {
        !callback ?: callback(absoluteImagePath, imageName);
    }];
}

/// 以imageName保存图片到Document下的moduleType模块
+ (BOOL)saveImageData:(NSData *)imageData withImageName:(NSString *)imageName forModuleType:(DemoModuleType)moduleType callback:(void(^)(NSString *absoluteImagePath))callback {
    NSString *imageModuleString = [self imageModuleStringForModuleType:moduleType];
    NSString *relativeDirectoryPath = [CJFileManager getLocalDirectoryPathType:CJLocalPathTypeRelative bySubDirectoryPath:imageModuleString inSearchPathDirectory:NSDocumentDirectory createIfNoExist:YES];
    BOOL saveSuccess = [CJFileManager saveFileData:imageData withFileName:imageName toRelativeDirectoryPath:relativeDirectoryPath];
    if (saveSuccess) {
        NSString *absoluteFileDirectory = [NSHomeDirectory() stringByAppendingPathComponent:relativeDirectoryPath];
        NSString *absoluteFilePath = [absoluteFileDirectory stringByAppendingPathComponent:imageName];
        !callback ?: callback(absoluteFilePath);
    }
    return saveSuccess;
}

/// 获取图片所在的模块对应的模块名
+ (NSString *)imageModuleStringForModuleType:(DemoModuleType)moduleType {
    NSString *imageModuleString = @"DefaultModule";
    switch (moduleType) {
        case DemoModuleTypeIot: {
            imageModuleString = @"IOTModule";
            break;
        }
        case DemoModuleTypeContract: {
            imageModuleString = @"ContractModule";
            break;
        }
        case DemoModuleTypeAsset: {
            imageModuleString = @"AssetModule";
            break;
        }
        default: {
            imageModuleString = @"DefaultModule";
            break;
        }
    }
    return imageModuleString;
}

/// 用globallyUniqueString命名图片名称
+ (NSString *)uniqueImageName {
    NSString *identifier = [[NSProcessInfo processInfo] globallyUniqueString];
    NSString *imageName = [identifier stringByAppendingPathExtension:@"jpg"];
    return imageName;
}

/// 用当前时间命名图片名称
+ (NSString *)dateImageName {
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    dateFormater.dateFormat = @"yyyyMMddHHmmss";
    NSString *dateString = [dateFormater stringFromDate:date];
    NSString *imageName = [dateString stringByAppendingPathExtension:@"jpg"];
    return imageName;
}

#pragma mark - Clear
/// 删除所有'资产管理'图片
+ (void)clearAssetImage {
    [self clearFilesForModuleType:DemoModuleTypeAsset];
}

/**
 *  清空imageModuleType模块中所有文件
 *
 *  @param moduleType   要清理的模块
 */
+ (void)clearFilesForModuleType:(DemoModuleType)moduleType {
    NSString *imageModuleString = [self imageModuleStringForModuleType:moduleType];
    NSString *relativeDirectoryPath = imageModuleString;
    [CJFileManager clearFilesInRelativeDirectoryPath:relativeDirectoryPath];
}
    
@end
