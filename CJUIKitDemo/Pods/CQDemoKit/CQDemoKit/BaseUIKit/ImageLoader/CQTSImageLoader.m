//
//  CQTSImageLoader.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CQTSImageLoader.h"

@implementation CQTSImageLoader


#pragma mark - 原始图片的加载

/*
 *  加载网络图片的数据
 *
 *  @param imageUrl             要加载的网络图片的数据地址
 *  @param completed            设置完成的回调(返回的图片是将imageUrl得到的图片根据指定的方式处理后的图)
 */
+ (void)loadImageWithUrl:(NSString *)imageUrl completed:(void(^ _Nullable)(UIImage * _Nullable bImage, NSURL * _Nullable imageURL, NSError * _Nullable error))completedBlock {
    NSURL *imageURL = [NSURL URLWithString:imageUrl];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSError *error = nil;
            !completedBlock ?: completedBlock(image, imageURL, error);
        });
    });
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
    
    // 不使用缓存的时候
    if (useCache == NO) {
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
        return image;
    }
    
    // 使用缓存的时候
    UIImage *image = nil;
    NSURL *imageURL = [NSURL URLWithString:imageUrl];
    NSString *imageCacheDirectory = [self __imageCacheDirectory];
    NSString *imageLocalPath = [NSString stringWithFormat:@"%@/%@.png", imageCacheDirectory, imageUrl];
    BOOL existBool = [[NSFileManager defaultManager] fileExistsAtPath:imageLocalPath];  //判断是否有缓存
    if (existBool == YES) {  // 如果存在本地缓存图片，直接读取cache内的缓存图片
        NSData *imageData = [NSData dataWithContentsOfFile:imageLocalPath];
        image = [UIImage imageWithData:imageData];
        
    } else {                // 如果本地缓存没有，保存图片
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        [imageData writeToFile:imageLocalPath atomically:YES];
        
        image = [UIImage imageWithData:imageData];
    }
    
    return image;
}


#pragma mark - Private Method
/// 获取图片缓存目录，如果没有则创建一个
+ (NSString *)__imageCacheDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *diskCachePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"cqdemo_imageCache"];
    
    // 如果目录imageCache不存在，创建目录
    if (![[NSFileManager defaultManager] fileExistsAtPath:diskCachePath]) {
        NSLog(@"fuck1");
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:diskCachePath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    return diskCachePath;
}

@end
