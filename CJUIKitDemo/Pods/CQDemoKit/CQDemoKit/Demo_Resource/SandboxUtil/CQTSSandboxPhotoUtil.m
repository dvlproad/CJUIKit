//
//  CQTSSandboxPhotoUtil.m
//  CQDemoKit
//
//  Created by ciyouzen on 2020/4/7.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CQTSSandboxPhotoUtil.h"
#import <Photos/Photos.h>
#import "CQTSResourceInfoUtil.h"    // 如果要尝试假智能的根据路径的后缀名保存任意媒体文件的时候需要

@implementation CQTSSandboxPhotoUtil

#pragma mark - 核心方法(推荐自行判断类型后，调用相应方法)
+ (void)saveImageToPhotoAlbum:(NSURL *)mediaLocalURL
                      success:(void (^)(void))success
                      failure:(void (^)(NSString *errorMessage))failure
{
    UIImage *watiToSaveImage = [UIImage imageWithContentsOfFile:mediaLocalURL.path];
    if (watiToSaveImage == nil) {
        NSString *errorMessage = [NSString stringWithFormat:@"图片数据获取失败，无法保存"];
        failure(errorMessage);
        return;
    }
    
    // 请求相册权限
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status != PHAuthorizationStatusAuthorized) {
            failure(@"没有相册权限");
            return;
        }
        
        NSError *error = nil;
        [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
            [PHAssetChangeRequest creationRequestForAssetFromImage:watiToSaveImage];
        } error:&error];
        
        if (error) {
            NSString *errorMessage = [NSString stringWithFormat:@"保存失败，请确认您的文件是不是图片: %@", error.localizedDescription];
            failure(errorMessage);
        } else {
            success();
        }
    }];
}


+ (void)saveVideoToPhotoAlbum:(NSURL *)mediaLocalURL
                      success:(void (^)(void))success
                      failure:(void (^)(NSString *errorMessage))failure
{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status != PHAuthorizationStatusAuthorized) {
            failure(@"没有相册权限");
            return;
        }
        
        NSError *error = nil;
        [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
            [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:mediaLocalURL];
        } error:&error];
        
        if (error) {
            NSString *errorMessage = [NSString stringWithFormat:@"保存失败，请确认您的文件是不是视频: %@", error.localizedDescription];
            failure(errorMessage);
        } else {
            success();
        }
    }];
}

+ (void)saveAudioToPhotoAlbum:(NSURL *)audioLocalURL
                      success:(void (^)(void))success
                      failure:(void (^)(NSString *errorMessage))failure
{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status != PHAuthorizationStatusAuthorized) {
            failure(@"没有相册权限");
            return;
        }
        
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            [PHAssetCreationRequest creationRequestForAssetFromVideoAtFileURL:audioLocalURL];
        } completionHandler:^(BOOL isSuccess, NSError * _Nullable error) {
            if (error != nil) {
                NSString *errorMessage = [NSString stringWithFormat:@"保存失败，请确认您的文件是不是音频: %@", error.localizedDescription];
                failure(errorMessage);
                return;
            }
            
            success();
        }];
    }];
}



#pragma mark - 易出错的"假智能"方法
/// 根据路径的后缀名保存任意媒体文件（此法不推荐，因为很多图片或视频的地址，并不一定是以其后缀名结尾）
+ (void)saveMediaByFileExtensionToPhotoAlbum:(NSURL *)mediaLocalURL
                                     success:(void (^)(void))success
                                     failure:(void (^)(NSString *errorMessage))failure
{
    NSString *fileExtension = [mediaLocalURL pathExtension].lowercaseString;    // 获取文件扩展名
    if (fileExtension == nil || fileExtension.length == 0) {
        failure(@"获取文件扩展名失败");
        return;
    }
    
    //UIImage *watiToSaveImage = nil;
    CQTSFileType fileType = [CQTSResourceInfoUtil fileTypeForFilePathOrUrl:fileExtension];
    if (fileType == CQTSFileTypeImage) {    // 如果是图片
        [self saveImageToPhotoAlbum:mediaLocalURL success:success failure:failure];

    } else if (fileType == CQTSFileTypeVideo) {
        [self saveVideoToPhotoAlbum:mediaLocalURL success:success failure:failure];
    
    } else if (fileType == CQTSFileTypeAudio) {
        [self saveAudioToPhotoAlbum:mediaLocalURL success:success failure:failure];

    } else {
        NSString *errorMessage = [NSString stringWithFormat:@"暂时不支持的文件类型: %@", fileExtension];
        failure(errorMessage);
    }
}

@end
