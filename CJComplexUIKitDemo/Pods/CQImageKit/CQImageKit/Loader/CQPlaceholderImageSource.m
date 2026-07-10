//
//  CQPlaceholderImageSource.m
//  TSImageDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CQPlaceholderImageSource.h"
#import <CJBaseUIKit/UIImage+CJCreate.h>
#import <CJBaseUIKit/UIColor+CJHex.h>
#import "UIImage+CQImageKit.h"

@implementation CQPlaceholderImageSource

/// 获取指定场景下图片加载前，要使用的占位图
+ (UIImage *)placeholdeImageForImageUseType:(CQImageUseType)imageUseType {
    UIImage *placeholderImage = nil;
    if (imageUseType == CQImageUseTypeAvatar) {
        //placeholderImage = [UIImage cqImagekit_xcassetImageNamed:@"img_default_avatar"];
    } else if (imageUseType == CQImageUseTypePhotoInDetail) {
        placeholderImage = nil;
    } else if (imageUseType == CQImageUseTypePhotoInImageList) {
        UIColor *imageColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        placeholderImage = [UIImage cj_imageWithColor:imageColor size:CGSizeMake(10, 10)];
    } else if (imageUseType == CQImageUseTypeGradientBG) {
        placeholderImage = [UIImage imageNamed:@"img_placeholder_gradient"];
    } else {
        UIColor *imageColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        placeholderImage = [UIImage cj_imageWithColor:imageColor size:CGSizeMake(10, 10)];
    }
    return placeholderImage;
}

/// 获取指定场景下获取图片被封禁，要使用的违规图片占位图
+ (UIImage *)bannedImageForImageUseType:(CQImageUseType)imageUseType {
    UIImage *bannedImage = [UIImage cqImagekit_xcassetImageNamed:@"img_error_default"];
    if (imageUseType == CQImageUseTypeAvatar) {                         /**< 头像的默认图 */
        bannedImage = [UIImage cqImagekit_xcassetImageNamed:@"img_default_avatar"];
    }
    
    return bannedImage;
}

/// 获取指定场景下获取图片失败，要使用的错误图片
+ (UIImage *)errorImageForImageUseType:(CQImageUseType)imageUseType {
    UIImage *errorImage = nil;
    
    //UIImage *errorImage = [UIImage cqImagekit_xcassetImageNamed:@"img_error_default"];
    if (imageUseType == CQImageUseTypeAvatar) {                         /**< 头像的默认图 */
        //errorImage = [UIImage cqImagekit_xcassetImageNamed:@"img_default_avatar"];
        UIColor *imageColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        errorImage = [UIImage cj_imageWithColor:imageColor size:CGSizeMake(10, 10)];
        
    } else if (imageUseType == CQImageUseTypePhotoInDetail) {
        errorImage = nil;
    } else if (imageUseType == CQImageUseTypePhotoInImageList) {
        UIColor *imageColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        errorImage = [UIImage cj_imageWithColor:imageColor size:CGSizeMake(10, 10)];
    } else if (imageUseType == CQImageUseTypeGradientBG) {
        errorImage = [UIImage imageNamed:@"img_placeholder_gradient"];
    } else if (imageUseType == CQImageUseTypeGradientBGForTextCard) {   /**< 说说卡的默认图 */
        CGSize imageSize = CGSizeMake(4, 4);
        // 颜色竖直渐变
        CGPoint startPoint = CGPointZero;
        CGPoint endPoint = CGPointMake(0.0, 1.0);
        NSArray *colors = @[[UIColor cjColorAlphaWithHexString:@"#ECA0FF"],
                            [UIColor cjColorAlphaWithHexString:@"#618BDD"]];
        UIImage *gradientImage = [UIImage cj_imageWithGradientColors:colors gradientStartPoint:startPoint gradientEndPoint:endPoint size:imageSize];
        errorImage = gradientImage;
        
    } else if (imageUseType == CQImageUseTypeGradientBGForVoiceCard) {
        CGSize imageSize = CGSizeMake(4, 4);
        // 颜色竖直渐变
        CGPoint startPoint = CGPointZero;
        CGPoint endPoint = CGPointMake(0.0, 1.0);
        NSArray *colors = @[[UIColor cjColorAlphaWithHexString:@"#78DCB8"],
                            [UIColor cjColorAlphaWithHexString:@"#509BAC"]];
        UIImage *gradientImage = [UIImage cj_imageWithGradientColors:colors gradientStartPoint:startPoint gradientEndPoint:endPoint size:imageSize];
        errorImage = gradientImage;
    }
    
    return errorImage;
}



@end
