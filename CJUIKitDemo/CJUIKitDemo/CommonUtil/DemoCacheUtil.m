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
+ (BOOL)saveImageData:(NSData *)imageData withImageName:(NSString *)imageName callback:(void(^)(NSString *absoluteImagePath))callback {
    NSString *relativeDirectoryPath = [CJFileManager getLocalDirectoryPathType:CJLocalPathTypeRelative bySubDirectoryPath:@"DemoImage" inSearchPathDirectory:NSDocumentDirectory createIfNoExist:YES];
    BOOL saveSuccess = [CJFileManager saveFileData:imageData withFileName:imageName toRelativeDirectoryPath:relativeDirectoryPath];
    if (saveSuccess) {
        NSString *absoluteFileDirectory = [NSHomeDirectory() stringByAppendingPathComponent:relativeDirectoryPath];
        NSString *absoluteFilePath = [absoluteFileDirectory stringByAppendingPathComponent:imageName];
        !callback ?: callback(absoluteFilePath);
    }
    return saveSuccess;
}


@end
