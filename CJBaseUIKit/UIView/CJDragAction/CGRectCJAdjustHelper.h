//
//  CGRectCJAdjustHelper.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/05.
//  Copyright © 2016年 dvlproad. All rights reserved.
//
//  一个调整小区域的frame使其保持在cage内部，或调整大区域的frame使其包含住小区域的帮助类

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGRectCJAdjustHelper : NSObject

#pragma mark - 调整内部的框：常用于悬浮球不能拖出视图
/*
 *  调整小区域smallFrame的位置，使其保持在cage内部：常用于悬浮球不能拖出视图
 *
 *  @param smallFrame                       要调整的cage内部的小区域
 *  @param cageFrame                        要包含住小区域的大/笼子区域
 *  @param isKeepBoundsXYWhenBeyondBound    当视图超出边界的时候，XY是否调整回最近边界
 *  @param isKeepBoundsXWhenContaintInBound 当视图没超出边界的时候，X是否调整回最近边界
 *  @param isKeepBoundsYWhenContaintInBound 当视图没超出边界的时候，Y是否调整回最近边界
 *
 *  @return 内部frame的新值
 */
+ (CGRect)adjustXYForSmallFrame:(CGRect)smallFrame
           accordingToCageFrame:(CGRect)cageFrame
  isKeepBoundsXYWhenBeyondBound:(BOOL)isKeepBoundsXYWhenBeyondBound
isKeepBoundsXWhenContaintInBound:(BOOL)isKeepBoundsXWhenContaintInBound
isKeepBoundsYWhenContaintInBound:(BOOL)isKeepBoundsYWhenContaintInBound;


#pragma mark - 调整外部的框：常用于图片区域不能缩放到小于裁剪框大小、不能拖出裁剪框的限制
/*
 *  调整大/笼子区域的位置/大小
 *
 *
 *  @param cageFrame        要调整的大/笼子区域
 *  @param smallFrame       cage内部的小区域
 *  @param adjustCageSize   是否要调整大小（使其宽高都不小于对应的最小值）：常用于图片区域不能缩放到小于裁剪框的大小
 *  @param adjustCageXY     是否要调整位置（使其能够包含住其内部的smallFrame小区域）：常用于图片区域不能拖出裁剪框
 *
 *  @return 调整后大/笼子区域的新frame
 */
+ (CGRect)adjustCageFrame:(CGRect)cageFrame
    accordingToSmallFrame:(CGRect)smallFrame
           adjustCageSize:(BOOL)adjustCageSize
             adjustCageXY:(BOOL)adjustCageXY;

@end

NS_ASSUME_NONNULL_END
