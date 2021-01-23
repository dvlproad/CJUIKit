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
/*
 *  压缩图片(先压缩图片质量，再压缩图片尺寸)
 *
 *  @param image                要压缩的图片
 *  @param lastPossibleSize     最后可能的大小(此过程保持图片比例)
 *  @param maxDataLength        指定的最大大小
 */
+ (NSData *)compressImage:(UIImage *)image withLastPossibleSize:(CGSize)lastPossibleSize maxDataLength:(NSInteger)maxDataLength;

@end

NS_ASSUME_NONNULL_END
