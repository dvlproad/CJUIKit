//
//  CQFilesLookBadgeCollectionView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "CQFilesLookBadgeDataModel.h"


///用来测试将MyEqualCellSizeCollectionView包含在自定义的View中时候，时候会有错误
@interface CQFilesLookBadgeCollectionView : UICollectionView {
    
}
@property (nonatomic, strong) NSMutableArray<CQFilesLookBadgeDataModel *> *dataModels;/**< 数据源 */

/// 初始化方法
- (instancetype)initWithDidTapShowingItemBlock:(void(^)(UICollectionView *collectionView, NSIndexPath *indexPath, CQFilesLookBadgeDataModel *dataModel))didTapShowingItemBlock NS_DESIGNATED_INITIALIZER;


/*
*  获取collectionView的高度
*
*  @param marginLeft         collectionView与屏幕的左边距
*  @param marginRight        collectionView与屏幕的右边距
*
*  @return
*/
- (CGFloat)heightByScreenMarginLeft:(CGFloat)marginLeft
                  screenMarginRight:(CGFloat)marginRight;

@end
