//
//  CJSortUtil.h
//  CJUIKitDemo
//
//  Created by 李超前 on 2018/3/19.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJSortUtil : NSObject

/**
 *  冒泡排序
 *
 *  @param array        要排序的数组
 */
+ (void)maopaoSortArray:(NSMutableArray *)array;

/**
 *  选择排序
 *
 *  @param array        要排序的数组
 */
+ (void)choseSortArray:(NSMutableArray *)array;

/**
 *  快速排序
 *
 *  @param array        要排序的数组
 *  @param leftIndex    leftIndex
 *  @param rightIndex   rightIndex
 */
+ (void)quickSortArray:(NSMutableArray *)array withLeftIndex:(NSInteger)leftIndex andRightIndex:(NSInteger)rightIndex;

@end

NS_ASSUME_NONNULL_END
