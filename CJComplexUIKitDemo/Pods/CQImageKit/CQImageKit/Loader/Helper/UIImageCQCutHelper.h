//
//  UIImageCQCutHelper.h
//  TSImageDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CJBaseUIKit/CJImageTrimmedModel.h>

typedef NS_ENUM(NSUInteger, CQImageViewCutType) {
    /**< 不做任何处理，直接拿原图 */
    CQImageViewCutTypeDefault = 0,
    
    // 头图使用
    /**< 裁剪方式1：判断是否太宽(ratio>1/1.0)或太高(ratio<343/580.0)；太宽则使用1/1.0，太高也使用343/580.0，不太宽也不太高使用1/1.0（注意不是使用原比例） */
    CQImageViewCutTypeOne,
    
    /**< 裁剪方式2：判断是否太宽(ratio>4/3.0)或太高(ratio<343/580.0)；太宽则使用4/3.0，太高则使用343/580.0，不太宽也不太高使用原比例 */
    CQImageViewCutTypeTwo,
};


NS_ASSUME_NONNULL_BEGIN

@interface UIImageCQCutHelper : NSObject {
    
}

#pragma mark - 裁剪获取新图
/*
 *  对指定图片做指定的裁剪得到新图
 *
 *  @param image        要裁剪的图片
 *  @param dealType     要裁剪的方式
 *
 *  @return 裁剪后得到的新图
 */
+ (UIImage *)newImageFromOriginImage:(UIImage *)image withCutType:(CQImageViewCutType)cutType;




#pragma mark - 获取图片视图比例

/*
 *  根据图片比例，纠正最后的图片视图所希望的比例(用于：列表中计算图片视图所要占用的高度)
 *
 *  @param imageRatio   图片比例
 *
 *  @return 最后的图片视图所希望的比例
 */
+ (CJImageTrimmedModel *)correctImageViewRatioWithImage:(nullable UIImage *)image;




@end

NS_ASSUME_NONNULL_END
