//
//  CJComponentDataModelUtil.h
//  CJPDropDownViewDemo
//
//  Created by ciyouzen on 9/7/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJComponentDataModel.h"
#import "CJDataModelSample.h"

@interface CJComponentDataModelUtil : NSObject {

}

/**
 *  从dictionarys中选中indexs后得到的componentDataModels
 *
 *  @param selectedIndexs       当前选中的indexs
 *  @param dictionarys          数据
 *  @param categoryKeys         要取得分类所需的key
 *  @param categoryValueKeys    要取得该分类子值所需的key(eg:选择福建省，得到的值是福建省下的所有市)
 *
 *  @return 数据模型
 */
+ (NSMutableArray<CJComponentDataModel *> *)selectedIndexs:(NSArray *)selectedIndexs
                                           inDictionarys:(NSArray<NSDictionary *> *)dictionarys
                                      sortByCategoryKeys:(NSArray<NSString *> *)categoryKeys
                                       categoryValueKeys:(NSArray<NSString *> *)categoryValueKeys;

+ (NSMutableArray<CJComponentDataModel *> *)selectedIndexs:(NSArray *)selectedIndexs
                                                  inTitles:(NSArray<NSString *> *)titles;


+ (void)updateSelectedIndexs:(NSArray *)selectedIndexs inComponentDataModels:(NSMutableArray<CJComponentDataModel *> *)componentDataModels;

@end
