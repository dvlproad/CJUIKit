//
//  CJDefaultTableViewCell+ConfigureForDataModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/12.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJDefaultTableViewCell.h"

#import "TestDataModel.h"

/**
 *  Cell中数据的绘制（这里使用类别作用：可以区分开当前cell是对什么dataModel进行编辑）
 */
@interface CJDefaultTableViewCell (ConfigureForDataModel)

/**
 *  利用TestDataModel对cell进行编辑
 *
 *  @param dataModel    cell中的数据
 */
- (void)configureForDataModel:(TestDataModel *)dataModel;

@end
