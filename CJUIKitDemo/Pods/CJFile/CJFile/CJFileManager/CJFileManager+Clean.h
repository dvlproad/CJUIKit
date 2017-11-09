//
//  CJFileManager+Clean.h
//  CommonFMDBUtilDemo
//
//  Created by lichq on 6/25/15.
//  Copyright (c) 2015 ciyouzen. All rights reserved.
//

#import "CJFileManager.h"

@interface CJFileManager (Clean)

/**
 *  清理relativeDirectoryPath中的过期文件
 *
 *  @param expiration               距离当天多长时间
 *  @param relativeDirectoryPath    要清理的目录
 */
+ (void)cleanFileExpiration:(unsigned long long)expiration inRelativeDirectoryPath:(NSString *)relativeDirectoryPath;

@end
