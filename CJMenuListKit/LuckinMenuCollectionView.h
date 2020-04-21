//
//  LuckinMenuCollectionView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CQFilesLookBadgeCollectionView.h"
#import "LuckinMenuDataModel.h"

@interface LuckinMenuCollectionView : UICollectionView {
    
}
@property (nonatomic, strong) NSMutableArray<LuckinMenuDataModel *> *dataModels;/**< 数据源 */
@property (nonatomic, assign) NSInteger maxBadgeNumber;     /**< 允许显示的最大badge（默认99） */

/// 初始化方法
- (instancetype)initWithDidTapShowingItemBlock:(void(^)(UICollectionView *collectionView, NSIndexPath *indexPath, LuckinMenuDataModel *dataModel))didTapShowingItemBlock NS_DESIGNATED_INITIALIZER;


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
