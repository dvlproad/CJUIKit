//
//  UIImageView+CQBaseUtil.m
//  TSImageDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "UIImageView+CQBaseUtil.h"
#import <objc/runtime.h>        // 添加属性，处理imageView的重用

#import <SDWebImage/SDWebImage.h>
#import "CQImageUploadSimulateUtil.h"

#import "CQImageLoader.h"
#import "CQImageLoaderCut.h"
#import "CQPlaceholderImageSource.h"

@interface UIImageView () {
    
}

@end

@implementation UIImageView (CQUtil)

// 用于检查reuse的问题url属性
- (NSString *)cqCheckReuseImageUrl {
    return objc_getAssociatedObject(self, @selector(cqCheckReuseImageUrl));
}


- (void)setCqCheckReuseImageUrl:(NSString *)cqCheckReuseImageUrl {
    objc_setAssociatedObject(self, @selector(cqCheckReuseImageUrl), cqCheckReuseImageUrl, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


#pragma mark - 设置图片的基础接口
#pragma mark 设置图片：设置网络图片
/*
 *  为UIImageView设置网络图片
 *
 *  @param imageUrl             该网络图片的地址
 *  @param imageStatus          该网络图片的违规状态
 *  @param imageUseType         图片的使用场景（不同场景会有不同的占位图和失败图）
 *  @param dealType             要处理(缩放或裁剪等）的方式
 *  @param completed            设置完成的回调(返回的图片是将imageUrl得到的图片根据指定的方式处理后的图)
 */
- (void)cq_setImageWithUrl:(NSString *)imageUrl
               imageStatus:(CQImageStatus)imageStatus
              imageUseType:(CQImageUseType)imageUseType
                  dealType:(CQImageViewDealType)dealType
                 completed:(void(^ _Nullable)(UIImage * _Nullable bDealImage, NSURL * _Nullable imageURL))completedBlock
{
    [self setCqCheckReuseImageUrl:imageUrl];
    
    if (imageStatus == CQImageStatusBanned) {   // 如果是banned掉的就不要去使用之前图片了，即使加载得到
        UIImage *bannedImage = [CQPlaceholderImageSource bannedImageForImageUseType:imageUseType];
        self.image = bannedImage;
        return;
    }
    
    UIImage *placeholderImage = [CQPlaceholderImageSource placeholdeImageForImageUseType:imageUseType];
    
    // 需要裁减图片时候，执行的方法如下：
    if (dealType == CQImageViewDealTypeCutTypeOne || dealType == CQImageViewDealTypeCutTypeTwo) {
        self.image = placeholderImage;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if ([imageUrl isEqualToString:[self cqCheckReuseImageUrl]] == NO) {   // 防止重用
                NSLog(@"happen reuse111======\n realImageUrl:%@,\n reuseImageUrl:%@", imageUrl, [self cqCheckReuseImageUrl]);
                return;
            }
            CQImageViewCutType cutType = dealType;
            UIImage *newImage = [CQImageLoaderCut newImageFromOriginImageUrl:imageUrl withCutType:cutType];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([imageUrl isEqualToString:[self cqCheckReuseImageUrl]]) {   // 防止重用
                    if (newImage == nil) {    // 如果获取图片失败，则显示默认的失败图片
                        UIImage *errorImage = [CQPlaceholderImageSource errorImageForImageUseType:imageUseType];
                        self.image = errorImage;
                    } else {
                        self.image = newImage;
                    }
                    
                    NSURL *imageURL = [NSURL URLWithString:imageUrl];
                    !completedBlock ?: completedBlock(newImage, imageURL);
                } else {
                    NSLog(@"happen reuse222======\n realImageUrl:%@,\n reuseImageUrl:%@", imageUrl, [self cqCheckReuseImageUrl]);
                }
                
            });
        });
        return;
    }
    
    
    // 不需要裁减图片的时候，执行的方法如下：
#if CQSIMULATE_UPLOAD_IMAGE==1        // 如果之前有使用过模拟上传图片的，则要先去检查这个图片是不是网络图片，因为有可能是本地图片
    BOOL isNetworkImage = [imageUrl hasPrefix:@"http"];
    if (isNetworkImage == NO) {
        UIImage *image = [CQImageUploadSimulateUtil imageFromLocalSimulateImageUrl:imageUrl];
        
        NSURL *imageURL = [NSURL URLWithString:imageUrl];
        !completedBlock ?: completedBlock(image, imageURL);
        
        return
    }
#endif
    
    NSURL *mImageURL = [NSURL URLWithString:imageUrl];
    [self sd_setImageWithURL:mImageURL placeholderImage:placeholderImage options:0 completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error) {    // 如果获取图片失败，则显示默认的失败图片
            UIImage *errorImage = [CQPlaceholderImageSource errorImageForImageUseType:imageUseType];
            self.image = errorImage;
        }
        
        !completedBlock ?: completedBlock(image, imageURL);
    }];

    
//    [CQImageLoader loadImageWithUrl:imageUrl imageUseType:imageUseType completed:^(UIImage * _Nullable bImage, NSURL * _Nullable imageURL, NSError * _Nullable error) {
//        self.image = bImage;
//        !completedBlock ?: completedBlock(bImage, imageURL);
//    }];
}


@end
