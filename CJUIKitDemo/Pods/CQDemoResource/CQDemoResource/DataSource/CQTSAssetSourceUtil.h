//
//  CQTSAssetSourceUtil.h
//  CQDemoResource
//
//  Created by ciyouzen on 2020/4/7.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQTSAssetSourceUtil : NSObject

#pragma mark 资源文件名 / 资源文件Url
+ (NSArray<NSString *> *)localFileNames:(NSArray<NSString *> *)folderNames;

/// 我自己 github 上的 资源图片
+ (NSArray<NSString *> *)networkFileUrls:(NSArray<NSString *> *)folderNames;

#pragma mark Icon资源文件 Url
/// 所有的网络测试icon图片地址
+ (NSArray<NSString *> *)iconUrls;

@end

NS_ASSUME_NONNULL_END
