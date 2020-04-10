//
//  CJDealTextModelFactory.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/10/29.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CJDealTextModelFactory.h"

@implementation CJDealTextModelFactory

/**
 *  初始化生成文本处理的数组
 *
 *  @param textArray        要处理的text数组
 *  @param placeholder      placeholder
 *  @param sameActionTitle  该文本要进行的操作含义
 *  @param sameActionBlock  该文本要进行的操作事件
 *
 *  @return 文本处理的数组
 */
+ (NSMutableArray<CJDealTextModel *> *)textArray:(NSArray<NSString *> *)textArray
                                 samePlaceholder:(NSString *)placeholder
                                 sameActionTitle:(NSString *)sameActionTitle
                                 sameActionBlock:(NSString*(^)(NSString *oldString))sameActionBlock
{
    NSMutableArray<CJDealTextModel *> *dealTextModels = [[NSMutableArray alloc] init];
    for (NSString *text in textArray) {
        CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
        dealTextModel.placeholder = placeholder;
        dealTextModel.text = text;
        dealTextModel.actionTitle = sameActionTitle;
        dealTextModel.actionBlock = sameActionBlock;
        
        [dealTextModels addObject:dealTextModel];
    }
    return dealTextModels;
}

@end
