//
//  UIImageView+CQUtil.m
//  TSImageDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "UIImageView+CQUtil.h"
#import "UIImageView+CQBaseUtil.h"
#import <SDWebImage/SDWebImage.h>
#import "CQImageUploadSimulateUtil.h"

#import "CQImageLoader.h"
#import "CQImageLoaderCut.h"
#import "CQPlaceholderImageSource.h"

@interface UIImageView () {
    
}

@end

@implementation UIImageView (CQUtil)

#pragma mark - 设置图片：设置网络图片
/// 为UIImageView设置网络图片
- (void)cq_setImageWithUrl:(NSString *)imageUrl {
    [self cq_setImageWithUrl:imageUrl imageStatus:CQImageStatusActive imageUseType:CQImageUseTypeDefault dealType:CQImageViewDealTypeDefault completed:nil];
}

/// 为头像视图设置头像图片（独立接口，因为头像的占位图和失败图有别于其他类型）：有些cell可能有时候是头像图片，有时候不是，如发现页顶部的collectionViewCell
- (void)cq_setAvatarImageWithUrl:(NSString *)imageUrl {
    [self cq_setImageWithUrl:imageUrl imageStatus:CQImageStatusActive imageUseType:CQImageUseTypeAvatar dealType:CQImageViewDealTypeDefault completed:nil];
}

#pragma mark - 卡片详情列表
/// 为卡片详情列表的cell设置网络图片（如果最终得到的图片是空，则还需要将该区域的高度设置为0）
- (void)cq_setImageForCardWithUrl:(NSString *)imageUrl completed:(void(^ _Nonnull)(BOOL isRealExistImage))completedBlock {
    [self cq_setImageWithUrl:imageUrl imageStatus:CQImageStatusActive imageUseType:CQImageUseTypeDefault dealType:CQImageViewDealTypeDefault completed:^(UIImage * _Nullable bDealImage, NSURL * _Nullable imageURL) {
        BOOL isRealExistImage = bDealImage != nil;
        !completedBlock ?: completedBlock(isRealExistImage);
    }];
}



#pragma mark - 卡片背景
/// 为卡片背景UIImageView设置网络图片
- (void)cq_setGradientImageWithUrl:(NSString *)imageUrl
{
    [self cq_setImageWithUrl:imageUrl imageStatus:CQImageStatusActive imageUseType:CQImageUseTypeGradientBG dealType:CQImageViewDealTypeDefault completed:nil];
}


@end
