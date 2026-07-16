//
//  CQTSGitUtil.m
//  CQDemoKit
//
//  Created by lcQian on 2020/4/7.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CQTSGitUtil.h"

@implementation CQTSGitUtil
/*
对
https://github.com/dvlproad/001-UIKit-CQDemo-iOS/blob/master/CQDemoResource/Resources/jpg/cqts_1.jpg

转成样式2:
https://github.com/dvlproad/001-UIKit-CQDemo-iOS/blob/master/CQDemoResource/Resources/jpg/cqts_1.jpg?raw=true    (即末尾加上 ?raw=true )
NSString *imageUrl = [NSString stringWithFormat:@"%@/%@?raw=true", resourceDir, imageNameOrUrl];

转成样式1：(当前代码的实现逻辑)
https://raw.githubusercontent.com/dvlproad/001-UIKit-CQDemo-iOS/master/CQDemoResource/Resources/jpg/cqts_1.jpg
*/
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
                                       imageName:(nullable NSString *)imageName
{
    if (!githubUrl || githubUrl.length == 0) {
        return nil;
    }
    
    if (!imageName || imageName.length == 0) {
        return nil;
    }
    
    // 自动将 blob 地址转换为 raw 地址
    NSString *baseRawUrl = [self _convertBlobToRawUrl:githubUrl];
    
    
    // 完全保留原始图片名，不添加任何后缀
    NSMutableArray *pathComponents = [NSMutableArray arrayWithObject:baseRawUrl];
    if (folderName.length > 0) {
        [pathComponents addObject:folderName];
    }
    [pathComponents addObject:imageName];
    
    NSString *fullUrl = [pathComponents componentsJoinedByString:@"/"];
    return fullUrl;
}


/**
 * 将 GitHub blob 地址转换为 raw 地址
 *
 * @param githubUrl GitHub 的 blob 地址，例如: https://github.com/dvlproad/001-UIKit-CQDemo-iOS/blob/master/CQDemoResource/Resources
 *
 * @return 转换后的 raw 地址，例如: https://raw.githubusercontent.com/dvlproad/001-UIKit-CQDemo-iOS/master/CQDemoResource/Resources
 */
+ (NSString *)_convertBlobToRawUrl:(NSString *)githubUrl {
    if (!githubUrl || githubUrl.length == 0) {
        return githubUrl;
    }
    
    // 如果已经是 raw 地址，直接返回
    if ([githubUrl containsString:@"raw.githubusercontent.com"]) {
        return githubUrl;
    }
    
    // 如果不是 github.com 的地址，直接返回
    if (![githubUrl containsString:@"github.com"]) {
        return githubUrl;
    }
    
    // 直接替换整个前缀
    // https://github.com/.../blob/... -> https://raw.githubusercontent.com/.../...
    NSString *rawURL = [githubUrl stringByReplacingOccurrencesOfString:@"https://github.com"
                                                            withString:@"https://raw.githubusercontent.com"];
    rawURL = [rawURL stringByReplacingOccurrencesOfString:@"/blob/"
                                                withString:@"/"];
    
    return rawURL;
}

@end
