//
//  CQTSResourceUtil.m
//  CQDemoKit
//
//  Created by lcQian on 2020/4/7.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CQTSResourceUtil.h"

@implementation CQTSResourceUtil

#pragma mark - Extract FileName And Extension
+ (NSDictionary<NSString *, id> *)extractFileNameAndExtensionFromFileName:(NSString *)fileName {
    // 查找最后一个 "." 的位置
    NSRange dotRange = [fileName rangeOfString:@"." options:NSBackwardsSearch];
    
    if (dotRange.location != NSNotFound) {
        // 获取扩展名
        NSString *fileExtension = [fileName substringFromIndex:dotRange.location + 1];
        
        // 获取文件名（去掉扩展名部分）
        NSString *fileNameWithoutExtension = [fileName substringToIndex:dotRange.location];
        
        return @{@"fileName": fileNameWithoutExtension, @"fileExtension": fileExtension};
    } else {
        // 如果没有扩展名，返回 nil 扩展名
        return @{@"fileName": fileName, @"fileExtension": [NSNull null]};
    }
}

#pragma mark - File Type
+ (CQTSFileType)fileTypeForFilePathOrUrl:(NSString *)pathOrUrl {
    NSString *extension = [pathOrUrl pathExtension].lowercaseString;
    NSArray *imageExtensions = @[@"jpg", @"jpeg", @"png", @"gif", @"bmp", @"webp"];
    NSArray *audioExtensions = @[@"mp3", @"wav", @"m4a", @"aac", @"ogg"];
    NSArray *videoExtensions = @[@"mp4", @"mov", @"avi", @"mkv", @"flv"];
    if ([imageExtensions containsObject:extension]) {
        return CQTSFileTypeImage;
    } else if ([audioExtensions containsObject:extension]) {
        return CQTSFileTypeAudio;
    } else if ([videoExtensions containsObject:extension]) {
        return CQTSFileTypeVideo;
    } else {
        return CQTSFileTypeUnknown;
    }
}



@end
