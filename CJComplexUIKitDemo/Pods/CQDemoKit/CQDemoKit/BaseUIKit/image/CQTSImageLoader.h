//
//  CQTSImageLoader.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//
//  原始图片的加载

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQTSImageLoader : NSObject

#pragma mark - 原始图片的加载

/*
 *  加载网络图片的数据
 *
 *  @param imageUrl             要加载的网络图片的数据地址
 *  @param completed            设置完成的回调(返回的图片是将imageUrl得到的图片根据指定的方式处理后的图)
 */
+ (void)loadImageWithUrl:(NSString *)imageUrl completed:(void(^ _Nullable)(UIImage * _Nullable bImage, NSURL * _Nullable imageURL, NSError * _Nullable error))completedBlock;

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
+ (nullable UIImage *)syncLoadImageWithUrl:(nullable NSString *)imageUrl optionUseCache:(BOOL)useCache;

@end

NS_ASSUME_NONNULL_END
