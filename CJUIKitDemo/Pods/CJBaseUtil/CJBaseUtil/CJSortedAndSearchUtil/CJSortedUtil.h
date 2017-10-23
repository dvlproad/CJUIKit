//
//  CJSortedUtil.h
//  CJBaseViewControllerDemo
//
//  Created by ciyouzen on 2016/06/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "CJSortedCategoryResult.h"

@interface CJSortedUtil : NSObject

/**
 *  对数组进行分组
 *
 *  @param sortedDataSource 要分组的数据(数组的元素可以为自定义类，也可以为NSString)
 *  @param dataSelector     根据数据中的哪个字段进行分组
 *  @param order            是否根据对分组后的每组进行排序
 *
 *  return 分组结果
 */
+ (CJSortedCategoryResult *)sortCategoryPinyinInDataArray:(NSArray *)sortedDataSource
                                         withDataSelector:(SEL)dataSelector
                                               andOrderIt:(BOOL)order;

/**
 *  对数组进行排序
 *
 *  @param sortedDataSource 要排序的数据
 *  @param dataSelector     根据数据的哪个字段排序
 *
 *  return 排序结果
 */
+ (NSArray *)sortedOrderInDataArray:(NSArray *)sortedDataSource
                   withDataSelector:(SEL)dataSelector;

@end
