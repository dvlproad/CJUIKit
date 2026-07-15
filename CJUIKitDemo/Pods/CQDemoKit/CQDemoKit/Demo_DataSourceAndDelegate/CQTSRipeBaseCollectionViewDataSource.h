//
//  CQTSRipeBaseCollectionViewDataSource.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CQDMSectionDataModel.h"    // 在 subspec:BaseVC 下

NS_ASSUME_NONNULL_BEGIN

@interface CQTSRipeBaseCollectionViewDataSource : NSObject<UICollectionViewDataSource> {
    
}
@property (nonatomic, strong) NSArray<CQDMSectionDataModel *> *sectionDataModels;    /**< 每个section的数据 */

#pragma mark - Init
/*
 *  初始化 CollectionView 的 dataSource
 *
 *  @param sectionDataModels            每个section的数据(section中的数据元素必须是 CQDMModuleModel )
 *  @param registerHandler              集合视图cell等的注册
 *  @param cellForItemAtIndexPath       获取指定indexPath的cell
 *
 *  @return CollectionView 的 dataSource
 */
- (instancetype)initWithSectionDataModels:(NSArray<CQDMSectionDataModel *> *)sectionDataModels
                          registerHandler:(void(^)(void))registerHandler
                   cellForItemAtIndexPath:(UICollectionViewCell *(^)(UICollectionView *bCollectionView, NSIndexPath *bIndexPath, id bDataModel))cellForItemAtIndexPath NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;


/*
 *  获取指定位置的dataModel
 *
 *  @return 指定位置的dataModel
 */
- (id)dataModelAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
