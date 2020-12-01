//
//  CQDMSectionDataModel+CJDealTextModel.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/10/29.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CQDMSectionDataModel+CJDealTextModel.h"
#import "CJDealTextModelFactory.h"

@implementation CQDMSectionDataModel (CJDealTextModel)

/**
 *  初始化生成sectionDataModel
 *
 *  @param textArray        要处理的text数组
 *  @param placeholder      placeholder
 *  @param sameActionTitle  该文本要进行的操作含义
 *  @param sameActionBlock  该文本要进行的操作事件
 *
 *  @return sectionDataModel
 */
+ (CQDMSectionDataModel *)sectionDataModelWithTextArray:(NSArray<NSString *> *)textArray
                                      samePlaceholder:(NSString *)placeholder
                                      sameActionTitle:(NSString *)sameActionTitle
                                      sameActionBlock:(NSString*(^)(NSString *oldString))sameActionBlock
{
    CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
    sectionDataModel.theme = sameActionTitle;
    
    // 创建dealTextModels，赋值给sectionDataModel.values
    NSMutableArray<CJDealTextModel *> *dealTextModels =
                        [CJDealTextModelFactory textArray:textArray
                                          samePlaceholder:placeholder
                                          sameActionTitle:sameActionTitle
                                          sameActionBlock:sameActionBlock];
    sectionDataModel.values = dealTextModels;
    
    return sectionDataModel;
}


@end
