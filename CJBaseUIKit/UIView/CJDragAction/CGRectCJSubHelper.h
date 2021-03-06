//
//  CGRectCJSubHelper.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/05.
//  Copyright © 2016年 dvlproad. All rights reserved.
//
//  从frame中获取最大子区域的方法：常用于拖动图片进行裁剪的时候

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGRectCJSubHelper : NSObject

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
                  subFramePositon:(BOOL)inCageCenter;


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
                  subFramePositon:(BOOL)inCageCenter;


@end

NS_ASSUME_NONNULL_END
