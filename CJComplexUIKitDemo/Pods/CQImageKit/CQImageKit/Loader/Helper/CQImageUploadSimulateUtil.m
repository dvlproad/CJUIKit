//
//  CQImageUploadSimulateUtil.m
//  TSImageDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CQImageUploadSimulateUtil.h"

static const NSString * localSimulateImageUrlPrefix = @"cq_simulate_upload:";

@implementation CQImageUploadSimulateUtil

// 图片转字符串（图片上传使用模拟的时候，需要使用此方法来获取图片url）
+ (NSString *)__localSimulateImageUrlFromImage:(UIImage *)image {
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImageString = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    encodedImageString = [localSimulateImageUrlPrefix stringByAppendingString:encodedImageString];
    return encodedImageString;
}


// 字符串转图片(如果之前有使用过模拟上传图片的，则这里应该调用此方法获取对应的图片)
+ (UIImage *)imageFromLocalSimulateImageUrl:(NSString *)encodedImageString {
    if ([encodedImageString hasPrefix:localSimulateImageUrlPrefix]) {
        encodedImageString = [encodedImageString substringFromIndex:localSimulateImageUrlPrefix.length];
    }
    NSData *decodedImageData = [[NSData alloc] initWithBase64EncodedString:encodedImageString options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *image = [UIImage imageWithData:decodedImageData];
    NSAssert(image != nil, @"本地模拟的上传图片，获取失败");
    return image;
}


@end
