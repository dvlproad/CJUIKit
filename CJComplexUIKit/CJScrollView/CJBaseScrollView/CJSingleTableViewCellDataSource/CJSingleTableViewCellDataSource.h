//
//  CJSingleTableViewCellDataSource.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/12.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


/**
 *  tableView只有一种Cell，且tableView不分区时候的dataSoure
 */
@interface CJSingleTableViewCellDataSource : NSObject <UITableViewDataSource> {
    
}
/**
 *  初始化dataSource类
 *
 *  @param dataModels                   dataSource的dataModels
 *  @param cellIdentifier               dataSource中的Cell重用的标识Identifier
 *  @param cellConfigureCellBlock       dataSource中的Cell进行定制用的block
 */
- (id)initWithDataModels:(NSArray<NSArray *> *)dataModels
          cellIdentifier:(NSString *)cellIdentifier
      cellConfigureBlock:(void (^)(id cell, id dataModel))cellConfigureCellBlock;

/**
 *  dataSoure中indexPath位置的dataModel值
 *
 *  @param indexPath    tableView的indexPath
 */
- (id)dataModelAtIndexPath:(NSIndexPath *)indexPath;

@end
