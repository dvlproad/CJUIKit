//
//  CJDataUtil+SortOrder.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/06/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJDataUtil.h"

@interface CJDataUtil (SortOrder)

/**
 *  对数组进行排序
 *
 *  @param sortedDataSource         要排序的数据
 *  @param dataSelector             根据数据的哪个字段排序(dataSelector为空的时候取自身)
 *  @param pinyinFromStringBlock    字符串转换成拼音的方法/代码块
 *
 *  return 排序结果
 */
+ (NSArray *)sortOrderInDataArray:(NSArray *)sortedDataSource
                 withDataSelector:(SEL)dataSelector
            pinyinFromStringBlock:(NSString *(^)(NSString *string))pinyinFromStringBlock;

@end
