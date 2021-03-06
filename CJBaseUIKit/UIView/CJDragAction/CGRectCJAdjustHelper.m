//
//  CGRectCJAdjustHelper.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/05.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CGRectCJAdjustHelper.h"

@implementation CGRectCJAdjustHelper

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
isKeepBoundsYWhenContaintInBound:(BOOL)isKeepBoundsYWhenContaintInBound
{
    NSAssert(isKeepBoundsXYWhenBeyondBound == YES ||
             isKeepBoundsXWhenContaintInBound == YES ||
             isKeepBoundsYWhenContaintInBound == YES, @"都不需要对frame进行调整/吸附的时候，不需要多余的取调用此方法");
    
    // 视图可移动的四边分别是
    CGFloat bondMinX = CGRectGetMinX(cageFrame);//黏合区域的minX
    CGFloat bondMaxX = CGRectGetMaxX(cageFrame);//黏合区域的maxX
    
    //1、x的黏合：先判断是否超出边界，如果超出边界，是否自动黏合
    if (CGRectGetMinX(smallFrame) < bondMinX) {
        if (isKeepBoundsXYWhenBeyondBound) {    //超出左边界，自动黏合到左侧
            smallFrame.origin.x = bondMinX;
        }
        
    } else if(CGRectGetMaxX(smallFrame) > bondMaxX) {
        if (isKeepBoundsXYWhenBeyondBound) {    //超出右边界，自动黏合到右侧
            smallFrame.origin.x = bondMaxX - CGRectGetWidth(smallFrame);
        }
    } else if (CGRectGetMidX(smallFrame) < bondMinX + (bondMaxX-bondMinX)/2) {
        if (isKeepBoundsXWhenContaintInBound) { //在左边界及中间边界之间，自动黏合到左侧
            smallFrame.origin.x = bondMinX;
        }
        
    } else {
        if (isKeepBoundsXWhenContaintInBound) { //在中间边界及右边界之间，自动黏合到右侧
            smallFrame.origin.x = bondMaxX - CGRectGetWidth(smallFrame);
        }
    }
    
    
    CGFloat bondMinY = CGRectGetMinY(cageFrame); //黏合区域的minY
    CGFloat bondMaxY = CGRectGetMaxY(cageFrame); //黏合区域的maxY
    //2、y的黏合：只需考虑超出边界是否黏合，不超出边界的话，不用处理y
    if (CGRectGetMinY(smallFrame) < bondMinY) {
        if (isKeepBoundsXYWhenBeyondBound) {    //超出上边界，自动黏合到上侧
            smallFrame.origin.y = bondMinY;
        }
        
    } else if(CGRectGetMaxY(smallFrame) > bondMaxY){
        if (isKeepBoundsXYWhenBeyondBound) {    //超出下边界，自动黏合到下侧
            smallFrame.origin.y = bondMaxY - CGRectGetHeight(smallFrame);
        }
    } else if (CGRectGetMidY(smallFrame) < bondMinY + (bondMaxY-bondMinY)/2) {
        if (isKeepBoundsYWhenContaintInBound) { //在上边界及中间边界之间，自动黏合到上侧
            smallFrame.origin.y = bondMinY;
        }
        
    } else {
        if (isKeepBoundsYWhenContaintInBound) { //在中间边界及下边界之间，自动黏合到下侧
            smallFrame.origin.y = bondMaxY - CGRectGetHeight(smallFrame);
        }
    }
    
    return smallFrame;
}



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
             adjustCageXY:(BOOL)adjustCageXY
{
    CGRect newCageFrame = cageFrame;
    
    // 1.调整大小Size
    if (adjustCageSize) {
        CGSize newCageSize = [self adjustSizeForCageSize:cageFrame.size accordingToSmallSize:smallFrame.size];
        
        // 保持中心不变，得到调整大小后的cage的区域
        CGPoint currentCageCenter = CGPointMake(CGRectGetMidX(cageFrame), CGRectGetMidY(cageFrame)); // 未调整前的cage中心
        CGFloat newCageWidth = newCageSize.width;
        CGFloat newCageHeight = newCageSize.height;
        CGFloat newCageOriginX = currentCageCenter.x - newCageWidth/2;
        CGFloat newCageOriginY = currentCageCenter.y - newCageHeight/2;
        newCageFrame = CGRectMake(newCageOriginX, newCageOriginY, newCageWidth, newCageHeight);
    }
    
    
    // 2.调整位置XY
    if (adjustCageXY) {
        newCageFrame = [self adjustXYForCageFrame:newCageFrame accordingToSmallFrame:smallFrame];
    }
    
    return newCageFrame;
}


/*
 *  调整大/笼子区域的大小，使其宽高都不小于对应的最小值：常用于图片区域不能缩放到小于裁剪框的大小
 *
 *  @param cageSize         要调整的大/笼子区域的大小（使其宽高都不小于对应的最小值）
 *  @param smallSize        cage内部的小区域的大小
 *
 *  @return 宽高都不小于对应最小值的大框新大小
 */
+ (CGSize)adjustSizeForCageSize:(CGSize)cageSize accordingToSmallSize:(CGSize)smallSize {
    CGFloat minCageWidth = smallSize.width;
    CGFloat minCageHeight = smallSize.height;

    CGFloat currentCageWidth = cageSize.width;
    CGFloat currentCageHeight = cageSize.height;
    
    CGFloat minCageRatio = minCageWidth/minCageHeight;
    //CGFloat cageWidthWhenUseMinCageRatio = currentCageHeight * minCageRatio; // 采用minCageRatio后判断其宽度是否会超出currentCageWidth
    CGFloat keepCageRatio = currentCageWidth/currentCageHeight;
    // 相比要裁剪的minCageSize区域，原图的区域属于长图，还是宽图
    BOOL isLongCageFrame = keepCageRatio < minCageRatio;

    CGFloat newCageWidth;
    CGFloat newCageHeight;
    // 在维持原图的比例下，要保证宽高都大于其对应的最小值，
    if (isLongCageFrame) {
        // 长图的时候，只要保证宽不小于最小宽，高就会自动会不小于最小高
        if (currentCageWidth < minCageWidth) {  // 长图且宽太小，需要调整宽
            newCageWidth = minCageWidth;
            newCageHeight = newCageWidth/keepCageRatio;
        } else {                        // 不需要调整大小
            newCageWidth = currentCageWidth;
            newCageHeight = currentCageHeight;
        }
    } else {
        // 宽图的时候，只要保证高不小于最小高，宽就会自动会不小于最小宽
        if (currentCageHeight < minCageHeight) {// 宽图且高太小，需要调整高
            newCageHeight = minCageHeight;
            newCageWidth = newCageHeight*keepCageRatio;
        } else {                        // 不需要调整大小
            newCageHeight = currentCageHeight;
            newCageWidth = currentCageWidth;
        }
    }
    return CGSizeMake(newCageWidth, newCageHeight);
}



/*
 *  调整大/笼子区域的位置（使其能够包含住其内部的smallFrame小区域）：常用于图片区域不能拖出裁剪框
 *          (即拖出区域的时候是否会回弹：view左边的最大值、右边的最小值、上边的最大值、下边的最小值)
 *
 *
 *  @param cageFrame        要调整的大/笼子区域（使其能够包含住其内部的smallFrame小区域）
 *  @param smallFrame       cage内部的小区域
 *
 *  @return 吸附后得到新的frame
 */
+ (CGRect)adjustXYForCageFrame:(CGRect)cageFrame accordingToSmallFrame:(CGRect)smallFrame
{
    NSAssert(CGRectGetWidth(cageFrame) >= CGRectGetWidth(smallFrame) &&
             CGRectGetHeight(cageFrame) >= CGRectGetHeight(smallFrame),
             @"使用此方法前(比如缩放后)，请确保cageFrame的大小不小于smallFrame的大小");
    // 图片.left > 裁剪框.left：向右滑动，并且左侧超出裁剪范围后
    CGFloat viewLeftCur = CGRectGetMinX(cageFrame);
    CGFloat viewLeftMax = CGRectGetMinX(smallFrame);
    if(viewLeftCur > viewLeftMax) {
        cageFrame.origin.x = viewLeftMax;
    }
    
    // 图片.right < 裁剪框.right：向左滑动，并且右侧超出裁剪范围后
    CGFloat viewRightCur = CGRectGetMaxX(cageFrame);
    CGFloat viewRightMin = CGRectGetMaxX(smallFrame);
    if(viewRightCur < viewRightMin) {
        CGFloat space = viewRightMin - viewRightCur;
        cageFrame.origin.x += space;
    }
    
    // 图片.top < 裁剪框.top：向下滑动，顶部超出裁剪范围后
    CGFloat viewTopCur = CGRectGetMinY(cageFrame);
    CGFloat viewTopMax = CGRectGetMinY(smallFrame);
    if(viewTopCur > viewTopMax) {
        cageFrame.origin.y = viewTopMax;
    }
    
    // 图片.bottom < 裁剪框.bottom：向上滑动，并且底部超出裁剪范围后
    CGFloat viewBottomCur = CGRectGetMaxY(cageFrame);
    CGFloat viewBottomMin = CGRectGetMaxY(smallFrame);
    if(viewBottomCur < viewBottomMin) {
        CGFloat space = viewBottomMin - viewBottomCur;
        cageFrame.origin.y += space;
    }

    return cageFrame;
}


@end
