//
//  CQFilesLookCollectionView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "CJFilesLookDataModel.h"
#import "UICollectionView+CJFlowLayoutScrollDirection.h"
#import "MyEqualCellSizeSetting.h"
#import "CJDataSourceSettingModel.h"


///用来测试将MyEqualCellSizeCollectionView包含在自定义的View中时候，时候会有错误
@interface CQFilesLookCollectionView : UICollectionView {
    
}
@property (nonatomic, strong) NSMutableArray<CJFilesLookDataModel *> *dataModels;/**< 数据源 */
@property (nonatomic, assign) BOOL isChoosing;  /**< 是否是选择操作，如果否则为只是展示 */
@property (nonatomic, strong) NSIndexPath *alwaysAloneIndexPath;/**< 与其他不共存的indexPath(当且仅当dataCellActionType == DataCellActionTypeSelect的时候才会用到这个值) */

//UICollectionUpdateAction

#pragma mark - Update
/// 更新额外cell的样式即位置，(默认不添加）
- (void)updateExtralItemSetting:(CJExtralItemSetting)extralItemSetting;

@end
