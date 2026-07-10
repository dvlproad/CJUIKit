//
//  CQTSPhotoUtil.h
//  CQDemoKit
//
//  Created by ciyouzen on 2020/4/7.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQTSPhotoUtil : NSObject

+ (void)saveImageToPhotoAlbum:(NSURL *)mediaLocalURL
                      success:(void (^)(void))success
                      failure:(void (^)(NSString *errorMessage))failure;

+ (void)saveVideoToPhotoAlbum:(NSURL *)mediaLocalURL
                      success:(void (^)(void))success
                      failure:(void (^)(NSString *errorMessage))failure;

/// 根据路径的后缀名保存任意视频（此法不推荐，因为很多图片或视频的地址，并不一定是以其后缀名结尾）
+ (void)saveMediaByFileExtensionToPhotoAlbum:(NSURL *)mediaLocalURL
                                     success:(void (^)(void))success
                                     failure:(void (^)(NSString *errorMessage))failure;

@end

NS_ASSUME_NONNULL_END
