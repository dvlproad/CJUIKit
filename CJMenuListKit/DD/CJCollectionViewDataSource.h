//
//  CJCollectionViewDataSource.h
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
@interface CJCollectionViewDataSource : NSObject <UICollectionViewDataSource> {
    
}
@property (nonatomic, strong) NSArray *dataModels;

/*
 *  初始化dataSource类(初始化完之后，必须在之后设置想要展示的数据dataModels)
 *
 *  @param cellForItemAtIndexPathBlock          dataSource中的cell(含dataCell和extralCell)进行定制用的block
 */
- (id)initWithCellForItemAtIndexPathBlock:(UICollectionViewCell* (^)(UICollectionView *collectionView, NSIndexPath *indexPath))cellForItemAtIndexPathBlock;



#pragma mark - Update

/*
 *  dataSoure中indexPath位置的dataModel值
 *
 *  @param indexPath    tableView的indexPath
 */
- (id)dataModelAtIndexPath:(NSIndexPath *)indexPath;


@end
