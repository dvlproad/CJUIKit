//
//  CJFileManager+SaveFileData.h
//  CommonFMDBUtilDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJFileManager.h"

///数据保存(图片选择等要用到的保存数据方法（之前被整理到CJDataDiskManager了)），所以这里不要轻易删除
@interface CJFileManager (SaveData)

/**
 *  保存文件(包含图片等各种格式)到以home相对的相对路径下
 *
 *  @param fileData                 文件数据
 *  @param fileName                 文件以什么名字保存
 *  @param relativeDirectoryPath    文件保存的相对路径
 *
 *  return 是否保存成功
 */
+ (BOOL)saveFileData:(NSData *)fileData
        withFileName:(NSString *)fileName
toRelativeDirectoryPath:(NSString *)relativeDirectoryPath;

@end
