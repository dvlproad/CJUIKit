//
//  CQTSGitUtil.h
//  CQDemoKit
//
//  Created by lcQian on 2020/4/7.
//  Copyright © 2020 dvlproad. All rights reserved.
//
//  从git中获取指定资源Url的工具

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQTSGitUtil : NSObject

/*
 * 从Github中获取指定文件夹下的指定资源名的资源 RAW Url
 *
 * @param githubUrl GitHub 仓库的基础 URL，可以是 blob 或 raw 地址
 *                  例如: @"https://github.com/dvlproad/001-UIKit-CQDemo-iOS/blob/master/CQDemoResource/Resources"
 * @param folderName 图片所在文件夹名称，例如: @"jpg"
 * @param imageName  图片名称，例如: @"cqts_1.jpg"
 *                   如果带后缀则保留，不带后缀则不加
 *
 * @return 完整的资源 URL 字符串数组
 */
+ (nullable NSString *)githubAssetUrlFromBaseUrl:(NSString *)githubUrl
                                      folderName:(nullable NSString *)folderName
                                       imageName:(nullable NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
