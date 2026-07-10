//
//  CJDataUtil+SortCategory.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/06/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJDataUtil.h"

#import <UIKit/UIKit.h>
#import "CJSortedCategoryResult.h"

@interface CJDataUtil (SortCategory)

/**
 *  对数组进行分组
 *
 *  @param sortedDataSource         要分组的数据(数组的元素可以为自定义类，也可以为NSString)
 *  @param dataSelector             根据数据中的哪个字段进行分组(dataSelector为空的时候取自身)
 *  @param order                    是否根据对分组后的每组进行排序
 *  @param pinyinFromStringBlock    字符串转换成拼音的方法/代码块
 *
 *  return 分组结果
 */
+ (CJSortedCategoryResult *)sortCategoryPinyinInDataArray:(NSArray *)sortedDataSource
                                         withDataSelector:(SEL)dataSelector
                                               andOrderIt:(BOOL)order
                                    pinyinFromStringBlock:(NSString *(^)(NSString *string))pinyinFromStringBlock;



@end
