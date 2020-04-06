//
//  CQFilesLookCollectionView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "MyEqualCellSizeCollectionView.h"

typedef NS_ENUM(NSUInteger, DataCellActionType) {
    DataCellActionTypeNone = 0,     /**< 不操作 */
    DataCellActionTypeBrowse,       /**< 浏览 */
    DataCellActionTypeSelect,       /**< 勾选选中/取消选中 */
};

///用来测试将MyEqualCellSizeCollectionView包含在自定义的View中时候，时候会有错误
@interface CQFilesLookCollectionView : MyEqualCellSizeCollectionView {
    
}
@property (nonatomic, strong) NSMutableArray<NSString *> *dataModels;/**< 数据源 */
@property (nonatomic, assign) DataCellActionType dataCellActionType;/**< 当前状态dataCell点击执行的操作是 */
@property (nonatomic, strong) NSIndexPath *alwaysAloneIndexPath;/**< 与其他不共存的indexPath */

//UICollectionUpdateAction

@end
