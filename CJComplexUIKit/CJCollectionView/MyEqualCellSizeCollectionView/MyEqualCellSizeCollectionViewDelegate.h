//
//  MyEqualCellSizeCollectionViewDelegate.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/4/10.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyEqualCellSizeSetting.h"


/**
 *  一个只有一个分区且分区中的每个cell大小相等的集合视图(cell的大小可通过方法①设置cell的固定大小和方法②通过设置每行最大显示的cell个数获得)(采用常用的init...方法后，即可初始化完成)
     这里的collectionLayout，只能为flow
 */
@interface MyEqualCellSizeCollectionViewDelegate : NSObject <UICollectionViewDelegateFlowLayout> {
    
}
//必须设置的值
@property (nonatomic, strong, readonly) MyEqualCellSizeSetting *equalCellSizeSetting; /**< 集合视图的布局设置 */

/**
 *  初始化delegate类
 *
 *  @param equalCellSizeSetting             集合视图的布局设置
 *  @param didTapItemBlock                         包括 didSelectItemAtIndexPath 和didDeselectItemAtIndexPath
 */
- (id)initWithEqualCellSizeSetting:(MyEqualCellSizeSetting *)equalCellSizeSetting
                   didTapItemBlock:(void (^)(UICollectionView *collectionView, NSIndexPath *indexPath, BOOL isDeselect, MyEqualCellSizeSetting *equalCellSizeSetting))didTapItemBlock NS_DESIGNATED_INITIALIZER;

/**
 *  dataSoure中indexPath位置的dataModel值
 *
 *  @param indexPath    tableView的indexPath
 */
- (id)dataModelAtIndexPath:(NSIndexPath *)indexPath;


/// 更新额外cell的样式即位置，(默认不添加）
- (void)updateExtralItemSetting:(CJExtralItemSetting)extralItemSetting;

#pragma mark - Update
/// 更新额外cell的样式即位置，(默认不添加）
- (void)updateExtralItemSetting:(CJExtralItemSetting)extralItemSetting;

/*
 *  获取当前collectionView的高度
 *
 *  @param allCellCount             collectionView中cell(含dataCell和extralCell)的总数
 *  @param collectionViewWidth      要传入的collectionView的宽度
 *  @param equalCellSizeSetting     集合视图的布局
 *
 *  @return 当前collectionView的高度
 */
+ (CGFloat)heightForAllCellCount:(NSInteger)allCellCount
           byCollectionViewWidth:(CGFloat)collectionViewWidth
        withEqualCellSizeSetting:(MyEqualCellSizeSetting *)equalCellSizeSetting;

@end
