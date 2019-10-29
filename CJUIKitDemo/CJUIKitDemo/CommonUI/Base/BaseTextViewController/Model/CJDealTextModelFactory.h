//
//  CJDealTextModelFactory.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/10/29.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJDealTextModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJDealTextModelFactory : NSObject {
    
}

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
                                 sameActionBlock:(NSString*(^)(NSString *oldString))sameActionBlock;

@end

NS_ASSUME_NONNULL_END
