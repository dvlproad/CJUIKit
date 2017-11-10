//
//  CJFileManager+GetCreatePath.h
//  CommonFMDBUtilDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJFileManager.h"

typedef NS_ENUM(NSUInteger, CJLocalPathType) {
    CJLocalPathTypeAbsolute,    /**< 绝对路径 */
    CJLocalPathTypeRelative,    /**< 相对于Home的路径 */
};

typedef NS_ENUM(NSUInteger, CJFileExistAction) {
    CJFileExistActionShowError,
    CJFileExistActionUseOld,
    CJFileExistActionRerecertIt,
};


@interface CJFileManager (GetCreatePath)

/**
 *  获取searchPathDirectory文件夹下子文件夹的路径
 *
 *  @param localPathType        返回什么样的路径(绝对路径还是相对路径)
 *  @param subDirectoryPath     子文件夹的路径/名字(可多层xx/yy，也可为空)
 *  @param searchPathDirectory  searchPathDirectory
 *  @param createIfNoExist      createIfNoExist（文件夹不存在的时候是否创建）
 *
 *  return 文件夹的路径(绝对路径或者相对于home的路径)
 */
+ (NSString *)getLocalDirectoryPathType:(CJLocalPathType)localPathType
                     bySubDirectoryPath:(NSString *)subDirectoryPath
                  inSearchPathDirectory:(NSSearchPathDirectory)searchPathDirectory
                        createIfNoExist:(BOOL)createIfNoExist;

@end
