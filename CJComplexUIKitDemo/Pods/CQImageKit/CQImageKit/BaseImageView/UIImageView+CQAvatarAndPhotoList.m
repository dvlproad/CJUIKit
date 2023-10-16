//
//  UIImageView+CQAvatarAndPhotoList.m
//  TSImageDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "UIImageView+CQAvatarAndPhotoList.h"
#import "UIImageView+CQBaseUtil.h"
#import "CQImageLoaderCut.h"

@implementation UIImageView (CQAvatarAndPhotoList)

/// 为图片列表上的UIImageView设置占位图片
- (void)cq_setPlaceholderImageForImageListAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *placeholderImage;
    if (indexPath.row == 0) {
        placeholderImage = [UIImage imageNamed:@"icon_add_image_main"];
    } else {
        placeholderImage = [UIImage imageNamed:@"icon_add_image_sub"];
    }
    self.image = placeholderImage;
}

/// 为图片列表上的UIImageView设置网络图片
- (void)cq_setImageForImageListWithUrl:(NSString *)imageUrl
                             indexPath:(NSIndexPath *)indexPath
                             completed:(void(^ _Nonnull)(UIImage * _Nullable image, NSURL * _Nullable imageURL))completedBlock
{
    CQImageViewDealType dealType;
    CQImageUseType imageUseType;
    if (indexPath.row == 0) {
        dealType = CQImageViewDealTypeCutTypeOne;
        imageUseType = CQImageUseTypeAvatar;
    } else {
        dealType = CQImageViewDealTypeCutTypeTwo;
        imageUseType = CQImageUseTypeDefault;
    }
    
    [self cq_setImageWithUrl:imageUrl imageStatus:CQImageStatusActive imageUseType:imageUseType dealType:dealType completed:completedBlock];
}

#pragma mark - 图片列表
/// 为图片列表上的UIImageView设置本地图片
- (void)cq_setImageForImageListWithImage:(UIImage *)image
                             indexPath:(NSIndexPath *)indexPath
                               completed:(void(^ _Nullable)(UIImage * _Nullable newImage))completedBlock
{
    CQImageViewDealType dealType = indexPath.item==0 ? CQImageViewDealTypeCutTypeOne : CQImageViewDealTypeCutTypeTwo;
    [self configImageWithOriginImage:image dealType:dealType];
    
    UIImage *newImage = self.image;
    !completedBlock ?: completedBlock(newImage);
}

#pragma mark 设置图片：设置本地图片
/*
 *  以指定方式处理图片，并设置
 *
 *  @param image        要处理(缩放或裁剪等）的图片
 *  @param dealType     要处理(缩放或裁剪等）的方式
 */
- (void)configImageWithOriginImage:(UIImage *)image dealType:(CQImageViewDealType)dealType {
    CQImageViewCutType cutType = dealType;
    UIImage *newImage = [CQImageLoaderCut newImageFromOriginImage:image withCutType:cutType];
    
    self.image = newImage;
}


@end
