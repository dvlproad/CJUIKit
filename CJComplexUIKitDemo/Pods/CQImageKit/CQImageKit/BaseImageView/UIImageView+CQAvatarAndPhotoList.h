//
//  UIImageView+CQAvatarAndPhotoList.h
//  TSImageDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  为头像和相册图片的列表设置图片（已内置裁剪需求）

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (CQAvatarAndPhotoList)

/// 为图片列表上的UIImageView设置占位图片
- (void)cq_setPlaceholderImageForImageListAtIndexPath:(NSIndexPath *)indexPath;
/// 为图片列表上的UIImageView设置网络图片
- (void)cq_setImageForImageListWithUrl:(NSString *)imageUrl
                             indexPath:(NSIndexPath *)indexPath
                             completed:(void(^ _Nonnull)(UIImage * _Nullable image, NSURL * _Nullable imageURL))completedBlock;

#pragma mark - 图片列表
/// 为图片列表上的UIImageView设置本地图片
- (void)cq_setImageForImageListWithImage:(UIImage *)image
                             indexPath:(NSIndexPath *)indexPath
                               completed:(void(^ _Nullable)(UIImage * _Nullable newImage))completedBlock;

@end

NS_ASSUME_NONNULL_END
