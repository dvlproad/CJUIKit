//
//  CQImageLoader.m
//  TSImageDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CQImageLoader.h"
#import <SDWebImage/SDWebImageManager.h>
#import <SDWebImage/SDImageCache.h>
#import "CQPlaceholderImageSource.h"

@implementation CQImageLoader


#pragma mark - 原始图片的加载

/*
 *  加载网络图片的数据
 *
 *  @param imageUrl             要加载的网络图片的数据地址
 *  @param imageUseType         图片的使用场景（不同场景会有不同的占位图和失败图）
 *  @param completed            设置完成的回调(返回的图片是将imageUrl得到的图片根据指定的方式处理后的图)
 */
+ (void)loadImageWithUrl:(NSString *)imageUrl imageUseType:(CQImageUseType)imageUseType completed:(void(^ _Nullable)(UIImage * _Nullable bImage, NSURL * _Nullable imageURL, NSError * _Nullable error))completedBlock {
#if CQSIMULATE_UPLOAD_IMAGE==1        // 如果这个图片地址是之前用来模拟上传图片的本地字符串，则直接从本地取出图片
    BOOL isLocalSimulateImageUrl = [imageUrl hasPrefix:@"http"] == NO;
    if (isLocalSimulateImageUrl == YES) {
        UIImage *image = [CQImageUploadSimulateUtil imageFromLocalSimulateImageUrl:imageUrl];
        
        NSURL *imageURL = [NSURL URLWithString:imageUrl];
        !completedBlock ?: completedBlock(image, imageURL);
        
        return;
    }
#endif
    
    NSURL *imageURL = [NSURL URLWithString:imageUrl];
    [SDWebImageManager.sharedManager loadImageWithURL:imageURL options:SDWebImageRetryFailed progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        if (error) {    // 如果获取图片失败，则显示默认的失败图片
            UIImage *errorImage = [CQPlaceholderImageSource errorImageForImageUseType:imageUseType];
            image = errorImage;
        }
        !completedBlock ?: completedBlock(image, imageURL, error);
    }];
}

/*
 *  同步加载网络图片（会优先从缓存中获取，请求到的图片也会进行缓存）
 *  @brief      （会阻塞主线程，因为涉及imageWithData耗时操作，所以请在子线程执行）
 *  @brief2     （使用场景：有时候外部可能需要先获取到图片再裁剪)
 *
 *  @param imageUrl     网络图片地址
 *  @param useCache     是否使用缓存策略
 *
 *  @return 网络图片UIImage(可能为nil)
 */
+ (nullable UIImage *)syncLoadImageWithUrl:(nullable NSString *)imageUrl optionUseCache:(BOOL)useCache {
    if (imageUrl.length == 0) {
        return nil;
    }
    
    UIImage *image;
    NSURL *imageURL = [NSURL URLWithString:imageUrl];
    if (useCache == NO) {
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        image = [UIImage imageWithData:imageData];
        
    } else {
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        BOOL existBool = [manager cacheKeyForURL:imageURL];//判断是否有缓存
        if (existBool) {
            SDImageCache *imageCache = [manager imageCache];
            image = [imageCache imageFromCacheForKey:imageUrl];
        }
        
        if (image == nil) { // 容错，防止上述取不出图片的问题
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            image = [UIImage imageWithData:imageData];
            [[SDImageCache sharedImageCache] storeImage:image forKey:imageURL.absoluteString completion:nil];
        }
    }
    
    return image;
}

@end
