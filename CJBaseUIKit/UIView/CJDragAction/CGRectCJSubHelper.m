//
//  CGRectCJSubHelper.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/05.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CGRectCJSubHelper.h"

@implementation CGRectCJSubHelper


#pragma mark - 获取最大的子区域:常用于图片裁剪之获取要裁剪指定比例时的裁剪框能够设置到的最大frame
/*
 *  从大/笼子区域cageFrame中获取宽高大小比例为widthHeightRatio、位置在cage中心的最大小区域
 *
 *  @param widthHeightRatio         最大视图的宽高比
 *  @param cageFrame                最大视图所在的父视图frame
 *  @param subFramePositon          最大视图在父视图的哪个位置(中心等)
 *
 *  @return 大小比例为widthHeightRatio、在指定位置的最大小区域
 */
+ (CGRect)getMaxSubFrameWithRatio:(CGFloat)widthHeightRatio
                      inCageFrame:(CGRect)cageFrame
                  subFramePositon:(BOOL)inCageCenter
{
    CGSize maxSubSize = [self getMaxSmallSizeWithRatio:widthHeightRatio inCageSize:cageFrame.size];
    
    CGFloat cageWidth = CGRectGetWidth(cageFrame);
    CGFloat cageHeight = CGRectGetHeight(cageFrame);
    CGFloat maxSubWidth = maxSubSize.width;
    CGFloat maxSubHeight = maxSubSize.height;
    CGFloat maxSubOriginX = cageWidth/2 - maxSubWidth/2;
    CGFloat maxSubOriginY = cageHeight/2 - maxSubHeight/2;
    CGRect maxSubFrame = CGRectMake(maxSubOriginX, maxSubOriginY, maxSubWidth, maxSubHeight);
    
    return maxSubFrame;
}

/*
 *  从大/笼子区域中获取比例为widthHeightRatio的最大size
 *
 *  @param smallFrameWidthHeightRatio   要取的小视图的宽高比
 *  @param cageSize                     从cage内部取
 *
 *  @return 比例为widthHeightRatio的最大size
 */
+ (CGSize)getMaxSmallSizeWithRatio:(CGFloat)smallFrameWidthHeightRatio inCageSize:(CGSize)cageSize {
    CGFloat cageWidth = cageSize.width;
    CGFloat cageHeight = cageSize.height;
    
    // 判断是否【内部最大小区域的高】的最大值可以等于【外部笼子cage】的高
    CGFloat smallFrameWidthIfUseRatio = cageHeight * smallFrameWidthHeightRatio;
    BOOL isMaxSmallFrameMaxHeightCanEqualCageHeight = smallFrameWidthIfUseRatio <= cageWidth;
    
    CGFloat smallFrameMaxWidth;
    CGFloat smallFrameMaxHeight;
    if (isMaxSmallFrameMaxHeightCanEqualCageHeight) {
        smallFrameMaxHeight = cageHeight;
        smallFrameMaxWidth = smallFrameMaxHeight*smallFrameWidthHeightRatio;
    } else {
        smallFrameMaxWidth = cageWidth;
        smallFrameMaxHeight = smallFrameMaxWidth/smallFrameWidthHeightRatio;
    }
    
    return CGSizeMake(smallFrameMaxWidth, smallFrameMaxHeight);
}


#pragma mark - 获取最小的父区域:常用于图片裁剪之获取要包含住裁剪区的最小图片frame

/*
 *  从大/笼子区域cageFrame中获取宽高大小比例为superRatio、位置在cage中心、宽不小于minCageWidth，高不小于minCageHeight的最小superFrame
 *
 *  @param widthHeightRatio         最小视图的宽高比
 *  @param minWidth                 最小视图的宽度不能小于此值
 *  @param minHeight                最小视图的高度不能小于此值
 *  @param cageFrame                最小视图所在的父视图frame
 *  @param subFramePositon          最小视图在父视图的哪个位置(中心等)
 *
 *  @return 最小superFrame
 */
+ (CGRect)getMinSubFrameWithRatio:(CGFloat)widthHeightRatio
                         minWidth:(CGFloat)minWidth
                        minHeight:(CGFloat)minHeight
                      inCageFrame:(CGRect)cageFrame
                  subFramePositon:(BOOL)inCageCenter
{
    CGSize minSize = [self getMinSizeWithRatio:widthHeightRatio
                                      minWidth:minWidth
                                     minHeight:minHeight];
    
    CGFloat cageWidth = CGRectGetWidth(cageFrame);
    CGFloat cageHeight = CGRectGetHeight(cageFrame);
    CGFloat minSubWidth = minSize.width;
    CGFloat minSubHeight = minSize.height;
    CGFloat minSubOriginX = cageWidth/2 - minSubWidth/2;
    CGFloat minSubOriginY = cageHeight/2 - minSubHeight/2;
    CGRect minSubFrame = CGRectMake(minSubOriginX, minSubOriginY, minSubWidth, minSubHeight);
    
    return minSubFrame;
}

/*
 *  获取大小比例为widthHeightRatio，宽不能小于minWidth，高不能小于minHeight的最小size
 *
 *  @param widthHeightRatio         最小视图的宽高比
 *  @param minWidth                 最小视图的宽度不能小于此值
 *  @param minHeight                最小视图的高度不能小于此值
 *
 *  @return 符合条件的最小size
 */
+ (CGSize)getMinSizeWithRatio:(CGFloat)widthHeightRatio
                     minWidth:(CGFloat)minWidth
                    minHeight:(CGFloat)minHeight
{
    // 判断是否【外部最小大区域的高】的最小值可以等于【内部smallSize】的高
    CGFloat superFrameMinWidthIfUseRatio = minHeight * widthHeightRatio;
    BOOL isSuperFrameMinHeightCanEqualCageHeight = superFrameMinWidthIfUseRatio >= minWidth;

    CGFloat superFrameMinWidth;
    CGFloat superFrameMinHeight;
    if (isSuperFrameMinHeightCanEqualCageHeight) {
        superFrameMinHeight = minHeight;
        superFrameMinWidth = superFrameMinHeight*widthHeightRatio;
    } else {
        superFrameMinWidth = minWidth;
        superFrameMinHeight = superFrameMinWidth/widthHeightRatio;
    }
    
    return CGSizeMake(superFrameMinWidth, superFrameMinHeight);
}


@end
