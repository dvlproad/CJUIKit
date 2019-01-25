//
//  CJBaseTableViewCell+ConfigureForDataModel.h
//  CJUIKitDemo
//
//  Created by 李超前 on 2019/1/25.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CJBaseTableViewCell.h"
#import "TestDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJBaseTableViewCell (ConfigureForDataModel)

/**
 *  利用TestDataModel对cell进行编辑
 *
 *  @param dataModel    cell中的数据
 */
- (void)default_configureForDataModel:(TestDataModel *)dataModel;

- (void)leftDetail_configureForDataModel:(TestDataModel *)dataModel;

- (void)rightDetail_configureForDataModel:(TestDataModel *)dataModel;

- (void)subTitle_configureForDataModel:(TestDataModel *)dataModel;

@end

NS_ASSUME_NONNULL_END
