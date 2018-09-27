//
//  CJFileManager+CalculateFileSize.h
//  CommonFMDBUtilDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJFileManager.h"

typedef NS_ENUM(NSUInteger, CJFileSizeUnitType) {
    CJFileSizeUnitTypeBestUnit,
    CJFileSizeUnitTypeB,
    CJFileSizeUnitTypeKB,
    CJFileSizeUnitTypeMB,
    CJFileSizeUnitTypeGB
};

@interface CJFileManager (CalculateFileSize)

/**
 *  计算对应路径下的文件/文件夹大小(计算出来的单位为B)
 *
 *  @param fileAbsolutePath     要计算大小的文件/文件夹路径
 */
+ (NSInteger)calculateFileSizeForFileAbsolutePath:(NSString *)fileAbsolutePath;

/**
 *  采用什么单位来表示fileSize
 *
 *  @param fileSize         fileSize当前是以B为单位的
 *  @param fileSizeUnitType fileSize要采用的单位
 */
+ (NSString *)showFileSize:(NSInteger)fileSize unitType:(CJFileSizeUnitType)fileSizeUnitType;

@end
