//
//  CJImageTrimmedModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//
//  用途1：要裁剪的时候，获取要如何裁剪image图片像素的裁剪模型数据
//  用途2：不裁剪的时候，在固定宽的情况下，根据什么样的图片视图比例，来获取图片的高

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 要裁剪的边
typedef NS_ENUM(NSUInteger, CJTrimmedEdge) {
    CJTrimmedEdgeNone,          /**< 不用裁剪 */
    CJTrimmedEdgeWidth,         /**< 裁剪宽（宽太宽，宽高比超过最大比例，裁剪宽） */
    CJTrimmedEdgeHeight,        /**< 裁剪高（高太高，宽高比小于最小比例，裁剪高） */
};

@interface CJImageTrimmedModel : NSObject {
    
}
@property (nonatomic, assign) CGFloat hopeNewRatio;         /**< 裁剪后最后的希望比例 */
@property (nonatomic, assign) CJTrimmedEdge trimmedEdge;    /**< 要裁剪的边 */
@property (nonatomic, assign) CGFloat newWidth;             /**< 裁剪后的宽（宽高可能有一个变，一个不变） */
@property (nonatomic, assign) CGFloat newHeight;            /**< 裁剪后的高（宽高可能有一个变，一个不变） */


/*
 *  根据设置，获取要等会要如何裁剪image图片像素的裁剪模型数据（如果没有太宽也没有太高，则不裁剪保持原图大小）
 *
 *  @param image                        图片
 *  @param tooWidthWidthHeightRatio     宽太长时候，裁剪宽，保持高，裁剪后的图片比例
 *  @param tooHeightWidthHeightRatio    高太高时候，裁剪高，保持宽，裁剪后的图片比例
 *
 *  @return 裁剪后的新图
 */
+ (CJImageTrimmedModel *)trimmedModelForImage:(nullable UIImage *)image
      tooWidthTrimmedWidthKeepHeightWithRatio:(CGFloat)tooWidthWidthHeightRatio
      tooHeightTrimmedHeightKeepWithWithRatio:(CGFloat)tooHeightWidthHeightRatio;

@end

NS_ASSUME_NONNULL_END
