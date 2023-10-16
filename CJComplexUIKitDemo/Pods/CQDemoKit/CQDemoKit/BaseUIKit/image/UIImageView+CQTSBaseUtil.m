//
//  UIImageView+CQTSBaseUtil.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "UIImageView+CQTSBaseUtil.h"
#import <objc/runtime.h>        // 添加属性，处理imageView的重用
#import "CQTSImageLoader.h"

@interface UIImageView () {
    
}

@end

@implementation UIImageView (CQTSBaseUtil)

// 用于检查reuse的问题url属性
- (NSString *)cqdmCheckReuseImageUrl {
    return objc_getAssociatedObject(self, @selector(cqdmCheckReuseImageUrl));
}


- (void)setCqdmCheckReuseImageUrl:(NSString *)cqdmCheckReuseImageUrl {
    objc_setAssociatedObject(self, @selector(cqdmCheckReuseImageUrl), cqdmCheckReuseImageUrl, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


#pragma mark - 设置图片的基础接口
#pragma mark 设置图片：设置网络图片
/*
 *  为UIImageView设置网络图片
 *
 *  @param imageUrl             该网络图片的地址
 *  @param completed            设置完成的回调(返回的图片是将imageUrl得到的图片根据指定的方式处理后的图)
 */
- (void)cqdm_setImageWithUrl:(NSString *)imageUrl
                   completed:(void(^ _Nullable)(UIImage * _Nullable bDealImage, NSURL * _Nullable imageURL))completedBlock
{
    [self setCqdmCheckReuseImageUrl:imageUrl];
    
    //UIImage *placeholderImage = [CQPlaceholderImageSource placeholdeImageForImageUseType:imageUseType];
    //self.image = placeholderImage;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if ([imageUrl isEqualToString:[self cqdmCheckReuseImageUrl]] == NO) {   // 防止重用
            NSLog(@"happen reuse111======\n realImageUrl:%@,\n reuseImageUrl:%@", imageUrl, [self cqdmCheckReuseImageUrl]);
            return;
        }
        
        UIImage *newImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([imageUrl isEqualToString:[self cqdmCheckReuseImageUrl]]) {   // 防止重用
                //if (newImage == nil) {    // 如果获取图片失败，则显示默认的失败图片
                //    UIImage *errorImage = [CQPlaceholderImageSource errorImageForImageUseType:imageUseType];
                //    self.image = errorImage;// 图片错乱根源:用户在滑动的过程中，因为cell的重用，第11行的cell可能使用的是第0行的cell，即self位置可能变了
                //} else {
                    self.image = newImage;  // 图片错乱根源:用户在滑动的过程中，因为cell的重用，第11行的cell可能使用的是第0行的cell，即self位置可能变了
                //}
                
                NSURL *imageURL = [NSURL URLWithString:imageUrl];
                !completedBlock ?: completedBlock(newImage, imageURL);
            } else {
                NSLog(@"happen reuse222======\n realImageUrl:%@,\n reuseImageUrl:%@", imageUrl, [self cqdmCheckReuseImageUrl]);
            }
            
        });
    });
    
    /*
    [CQTSImageLoader loadImageWithUrl:imageUrl completed:^(UIImage * _Nullable bImage, NSURL * _Nullable imageURL, NSError * _Nullable error) {
        if ([imageUrl isEqualToString:[self cqdmCheckReuseImageUrl]]) {   // 防止重用
            if (error) {    // 如果获取图片失败，则显示默认的失败图片
                UIImage *errorImage = [CQPlaceholderImageSource errorImageForImageUseType:imageUseType];
                bImage = errorImage;
            }
            
            self.image = bImage;    // 图片错乱根源:用户在滑动的过程中，因为cell的重用，第11行的cell可能使用的是第0行的cell，即self位置可能变了
            !completedBlock ?: completedBlock(bImage, imageURL);
            
        } else {
            NSLog(@"happen reuse222======\n realImageUrl:%@,\n reuseImageUrl:%@", imageUrl, [self cqdmCheckReuseImageUrl]);
        }
    }];
    */
}


@end
