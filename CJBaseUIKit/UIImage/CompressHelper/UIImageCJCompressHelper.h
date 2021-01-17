//
//  UIImageCJCompressHelper.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageCJCompressHelper : NSObject


#pragma mark - compress(图片压缩)
/// 压缩图片(先压缩图片质量，再压缩图片尺寸)
+ (NSData *)compressImage:(UIImage *)image withMaxDataLength:(NSInteger)maxDataLength;

@end

NS_ASSUME_NONNULL_END
