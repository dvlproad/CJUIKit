//
//  CJDataUtil+Value.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/06/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJDataUtil.h"

@interface CJDataUtil (Value)

/**
 *  取数组内元素对应属性值
 *
 *  @param dataSelector dataSelector为空的时候取自身
 *  @param dataModel    dataModel
 *
 *  return 数组内元素的属性值（dataSelector为空时，返回元素自身）
 */
+ (NSString *)stringValueForDataSelector:(SEL)dataSelector inDataModel:(id)dataModel;

/**
 *  取数组内元素对应属性值
 *
 *  @param dataSelector dataSelector为空的时候取自身
 *  @param dataModel    dataModel
 *
 *  return 数组内元素的属性值（dataSelector为空时，返回元素自身）
 */
+ (NSArray *)arrayValueForDataSelector:(SEL)dataSelector inDataModel:(id)dataModel;

@end
