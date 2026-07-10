//
//  UIImageCQCutHelper.m
//  TSImageDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "UIImageCQCutHelper.h"
#import <CJBaseUIKit/UIImageCJCutHelper.h>

@implementation UIImageCQCutHelper


#pragma mark - 裁剪获取新图
/*
 *  对指定图片做指定的裁剪得到新图
 *
 *  @param image        要裁剪的图片
 *  @param dealType     要裁剪的方式
 *
 *  @return 裁剪后得到的新图
 */
+ (UIImage *)newImageFromOriginImage:(UIImage *)image withCutType:(CQImageViewCutType)cutType {
    UIImage *newImage;
    switch (cutType) {
        case CQImageViewCutTypeOne: {
            /**< 裁剪方式1：判断是否太宽(ratio>1/1.0)或太高(ratio<343/580.0)；太宽则使用1/1.0，太高也使用343/580.0，不太宽也不太高使用1/1.0（注意不是使用原比例） */
            newImage = [UIImageCJCutHelper cutImage:image
                                     fromRegionType:UIImageCutFromRegionCenter
                                           tooWidthKeepRatio:343/580.0
                                          tooHeightKeepRatio:343/580.0
                                 noTooWidthOrHeightKeepRatio:1/1.0];
            break;
        }
        case CQImageViewCutTypeTwo: {
            /**< 裁剪方式2：判断是否太宽(ratio>4/3.0)或太高(ratio<343/580.0)；太宽则使用4/3.0，太高则使用343/580.0，不太宽也不太高使用原比例 */
            newImage = [UIImageCJCutHelper cutImage:image
                                     fromRegionType:UIImageCutFromRegionCenter
                                           tooWidthKeepRatio:4/3.0
                                          tooHeightKeepRatio:343/580.0
                                 noTooWidthOrHeightKeepRatio:0];
            break;
        }
        default: {
            newImage = image;
            break;
        }
    }
    
    return newImage;
}







#pragma mark - 获取图片视图比例

/*
 *  根据图片比例，纠正最后的图片视图所希望的比例(用于：列表中计算图片视图所要占用的高度)
 *
 *  @param imageRatio   图片比例
 *
 *  @return 最后的图片视图所希望的比例
 */
+ (CJImageTrimmedModel *)correctImageViewRatioWithImage:(nullable UIImage *)image {
    CJImageTrimmedModel *trimmedModel = [CJImageTrimmedModel trimmedModelForImage:image
                                          tooWidthTrimmedWidthKeepHeightWithRatio:4/3.0
                                          tooHeightTrimmedHeightKeepWithWithRatio:343/580.0
                                                      noTooWidthOrHeightKeepRatio:0];
    
    return trimmedModel;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
