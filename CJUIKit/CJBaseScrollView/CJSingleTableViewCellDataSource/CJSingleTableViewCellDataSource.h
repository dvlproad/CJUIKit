//
//  CJSingleTableViewCellDataSource.h
//  AllScrollViewDemo
//
//  Created by ciyouzen on 2016/11/12.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//建议：Configure类的设置强烈建议优先用block，而事件类的可以优先使用delegate
//cell的block
typedef void (^TableViewCellConfigureBlock)(id cell, id dataModel);


/**
 *  tableView只有一种Cell，且tableView不分区时候的dataSoure
 */
@interface CJSingleTableViewCellDataSource : NSObject <UITableViewDataSource> {
    
}
/**
 *  初始化dataSource类
 *
 *  @param datas                        dataSource的data
 *  @param cellIdentifier               dataSource中的Cell重用的标识Identifier
 *  @param cellConfigureCellBlock       dataSource中的Cell进行定制用的block
 */
- (id)initWithDatas:(NSArray<NSArray *> *)datas
     cellIdentifier:(NSString *)cellIdentifier
 cellConfigureBlock:(TableViewCellConfigureBlock )cellConfigureCellBlock;

/**
 *  dataSoure中indexPath位置的dataModel值
 *
 *  @param indexPath    tableView的indexPath
 */
- (id)dataModelAtIndexPath:(NSIndexPath *)indexPath;

@end
