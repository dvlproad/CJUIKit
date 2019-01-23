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

@implementation DemoCacheUtil

/// 保存图片到Document
+ (BOOL)saveImageData:(NSData *)imageData callback:(void(^)(NSString *absoluteImagePath))callback {
    NSString *imageName = [self dateImageName];
    return [self saveImageData:imageData withImageName:imageName imageModuleType:ImageModuleTypeDefault callback:callback];
}

/// 保存'电子合同'图片到Document
+ (BOOL)saveAssetImageData:(NSData *)imageData callback:(void(^)(NSString *absoluteImagePath))callback {
    NSString *imageName = [self dateImageName];
    return [self saveImageData:imageData withImageName:imageName imageModuleType:ImageModuleTypeAsset callback:callback];
}

/// 以imageName保存图片到Document下的imageModuleType模块
+ (BOOL)saveImageData:(NSData *)imageData withImageName:(NSString *)imageName imageModuleType:(ImageModuleType)imageModuleType callback:(void(^)(NSString *absoluteImagePath))callback {
    NSString *imageModuleString = [self imageModuleStringForImageModuleType:imageModuleType];
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
+ (NSString *)imageModuleStringForImageModuleType:(ImageModuleType)imageModuleType {
    NSString *imageModuleString = @"DefaultModule";
    switch (imageModuleType) {
        case ImageModuleTypeContract: {
            imageModuleString = @"ContractModule";
            break;
        }
        case ImageModuleTypeAsset: {
            imageModuleString = @"AssetModule";
            break;
        }
        default: { //ImageModuleTypeDefault
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



@end
