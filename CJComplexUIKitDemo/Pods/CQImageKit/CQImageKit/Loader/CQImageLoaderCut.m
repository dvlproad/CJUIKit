//
//  CQImageLoaderCut.m
//  TSImageDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CQImageLoaderCut.h"
#import "CQImageLoader.h"
#import <SDWebImage/SDImageCache.h>

@implementation CQImageLoaderCut


#pragma mark - 原始图片再加工后的新图片的加载
/*
 *  对指定【网络图片】做指定的处理(缩放或裁剪等）得到新图（会默认通过originImageUrl进行缓存，以防止重复裁剪带来的性能影响）
 *
 *  @param image            要处理(缩放或裁剪等）的图片
 *  @param cutType          要处理(缩放或裁剪等）的方式
 *
 *  @return 处理(缩放或裁剪等）后得到的新图
 */
+ (UIImage *)newImageFromOriginImageUrl:(NSString *)originImageUrl withCutType:(CQImageViewCutType)cutType {
    NSString *imageCacheId = originImageUrl;
    UIImage *newImage;
    if (imageCacheId.length > 0) {
        newImage = [self getImageWithImageCacheId:imageCacheId];
        if (newImage) {
            return newImage;
        }
    }
    
    UIImage *originImage = [CQImageLoader syncLoadImageWithUrl:originImageUrl optionUseCache:YES];
    newImage = [self newImageFromOriginImage:originImage withCutType:cutType imageCacheId:imageCacheId];
    
    return newImage;
}

/*
 *  对指定【本地图片】做指定的处理(缩放或裁剪等）得到新图（本地图片的裁剪后新图不用设置缓存）
 *
 *  @param image            要处理(缩放或裁剪等）的图片
 *  @param cutType          要处理(缩放或裁剪等）的方式
 *
 *  @return 处理(缩放或裁剪等）后得到的新图
 */
+ (UIImage *)newImageFromOriginImage:(UIImage *)image withCutType:(CQImageViewCutType)cutType {
    return [self newImageFromOriginImage:image withCutType:cutType imageCacheId:nil];
}


#pragma mark - Private Method
/*
 *  对指定图片做指定的处理(缩放或裁剪等）得到新图
 *
 *  @param image            要处理(缩放或裁剪等）的图片
 *  @param cutType          要处理(缩放或裁剪等）的方式
 *  @param imageCacheId     处理后的图片的缓存id（如果为nil或空，则表示不缓存，一般要设置缓存，以防止重复裁剪。）
 *
 *  @return 处理(缩放或裁剪等）后得到的新图
 */
+ (UIImage *)newImageFromOriginImage:(UIImage *)image
                         withCutType:(CQImageViewCutType)cutType
                        imageCacheId:(nullable NSString *)imageCacheId
{
    UIImage *newImage;
    if (imageCacheId.length > 0) {
        newImage = [self getImageWithImageCacheId:imageCacheId];
        if (newImage) {
            return newImage;
        }
    }
    
    newImage = [UIImageCQCutHelper newImageFromOriginImage:image withCutType:cutType];
    if (imageCacheId.length > 0) {
        [self saveImage:newImage withImageCacheId:imageCacheId];
    }
    
    return newImage;
}



+ (UIImage *)getImageWithImageCacheId:(NSString *)imageCacheId {
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:imageCacheId];
    NSLog(@"cacheImage=== %@", cacheImage);

    return cacheImage;
}

+ (void)saveImage:(UIImage *)image withImageCacheId:(NSString *)imageCacheId {
    [[SDImageCache sharedImageCache] storeImageToMemory:image forKey:imageCacheId];
}


@end
