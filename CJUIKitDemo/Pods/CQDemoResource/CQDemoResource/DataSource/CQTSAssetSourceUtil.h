//
//  CQTSAssetSourceUtil.h
//  CQDemoResource
//
//  Created by ciyouzen on 2020/4/7.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImage+CQDemoResource.h"

NS_ASSUME_NONNULL_BEGIN

@interface CQTSAssetSourceUtil : NSObject

#pragma mark 本地资源文件名
// 图片文件位置
typedef NS_OPTIONS(NSInteger, CQTSLocalFileOption) {
//    CQTSLocalFileOptionAll    = 0,       // 所有
    CQTSLocalFileOptionPNG          = 1 << 0,  // png
    CQTSLocalFileOptionJPG          = 1 << 1,  // jpg
    CQTSLocalFileOptionGIF          = 1 << 2,  // gif
    CQTSLocalFileOptionWebP         = 1 << 3,  // webp
    CQTSLocalFileOptionSVG          = 1 << 4,  // svg
    CQTSLocalFileOptionAudio        = 1 << 5,  // audio
    CQTSLocalFileOptionVideoNormal  = 1 << 6,  // video
    CQTSLocalFileOptionVideoVap     = 1 << 7,  // vap
};

/// 本地资源图片数组
+ (NSArray<NSString *> *)localFileNames:(NSArray<NSString *> *)folderNames;

/*
 *  获取指定文件夹下的所有图片
 *
 *  @param folderNames  图片源的位置(NSArray<NSString *> *folderNames = @[@"png", @"jpg", @"webp", @"svg"];)
 *
 *  @return 本地图片数组
 */
+ (NSArray<UIImage *> *)localImagesInFolderNames:(NSArray<NSString *> *)folderNames;

/*
NSInteger trySelIndex = random();
NSArray<NSString *> *folderNames = @[@"png", @"jpg", @"webp", @"svg"];
UIImage *localImageRandom = [CQTSAssetSourceUtil localImageAtIndex:trySelIndex folderNames:folderNames];
*/
/*
 *  获取指定位置的本地图片(为了cell显示的图片不会一直变化)
 *
 *  @param trySelIndex  指定位置(随机位置 NSInteger trySelIndex = random();)
 *  @param folderNames  图片源的位置(NSArray<NSString *> *folderNames = @[@"png", @"jpg", @"webp", @"svg"];)
 *
 *  @return 本地图片
 */
+ (UIImage *)localImageAtIndex:(NSInteger)trySelIndex folderNames:(NSArray<NSString *> *)folderNames;






#pragma mark 网络资源文件Url
/// 我自己 github 上的 资源图片
+ (NSArray<NSString *> *)networkFileUrls:(NSArray<NSString *> *)folderNames;
/*
NSInteger trySelIndex = random();
NSArray<NSString *> *folderNames = @[@"png", @"jpg", @"webp", @"svg"];
UIImage *imageUrlRandom = [CQTSAssetSourceUtil imageUrlAtIndex:trySelIndex folderNames:folderNames];
*/
/*
 *  获取指定位置的网络图片(为了cell显示的图片不会一直变化)
 *
 *  @param trySelIndex  指定位置(随机位置 NSInteger trySelIndex = random();)
 *  @param folderNames  图片源的位置(NSArray<NSString *> *folderNames = @[@"png", @"jpg", @"webp", @"svg"];)
 *
 *  @return 网络图片
 */
+ (NSString *)imageUrlAtIndex:(NSInteger)trySelIndex folderNames:(NSArray<NSString *> *)folderNames;





#pragma mark Icon资源文件 Url
/// 所有的网络测试icon图片地址
+ (NSArray<NSString *> *)iconUrls;

/*
NSInteger trySelIndex = random();
UIImage *iconUrlRandom = [CQTSAssetSourceUtil iconUrlAtIndex:trySelIndex];
*/
/*
 *  获取指定位置的Icon图片Url(为了cell显示的图片不会一直变化)
 *
 *  @param trySelIndex  指定位置(随机位置 NSInteger trySelIndex = random();)
 *
 *  @return 网络图片
 */
+ (NSString *)iconUrlAtIndex:(NSInteger)trySelIndex;

@end

NS_ASSUME_NONNULL_END
