//
//  CQTSSandboxPhotoUtil.h
//  CQDemoKit
//
//  Created by ciyouzen on 2020/4/7.
//  Copyright © 2020 dvlproad. All rights reserved.
//
//  将下载到 app 沙盒中的媒体文件保存到相册中
//  目前使用于 CJNetworkDemo 的 TSDownloadUtil.h 中

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQTSSandboxPhotoUtil : NSObject

#pragma mark - 核心方法(推荐自行判断类型后，调用相应方法)
+ (void)saveImageToPhotoAlbum:(NSURL *)mediaLocalURL
                      success:(void (^)(void))success
                      failure:(void (^)(NSString *errorMessage))failure;

+ (void)saveVideoToPhotoAlbum:(NSURL *)mediaLocalURL
                      success:(void (^)(void))success
                      failure:(void (^)(NSString *errorMessage))failure;

+ (void)saveAudioToPhotoAlbum:(NSURL *)audioLocalURL
                      success:(void (^)(void))success
                      failure:(void (^)(NSString *errorMessage))failure;

#pragma mark - 易出错的"假智能"方法
/// 根据路径的后缀名保存任意媒体文件（此法不推荐，因为很多图片或视频的地址，并不一定是以其后缀名结尾）
+ (void)saveMediaByFileExtensionToPhotoAlbum:(NSURL *)mediaLocalURL
                                     success:(void (^)(void))success
                                     failure:(void (^)(NSString *errorMessage))failure;

@end

NS_ASSUME_NONNULL_END
