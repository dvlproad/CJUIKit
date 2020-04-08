//
//  MySearchEqualCellSizeCollectionViewDataSource.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/12.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "MySearchEqualCellSizeCollectionViewDataSource.h"

@interface MySearchEqualCellSizeCollectionViewDataSource () {
    
}
@property (nonatomic, copy) UICollectionViewCell* (^cellForItemAtIndexPathBlock)(UICollectionView *collectionView, NSIndexPath *indexPath, BOOL isExtralItem);

@end



@implementation MySearchEqualCellSizeCollectionViewDataSource

- (id)init {
    return nil; //没有使用data初始化的时候，dataSoure类设为空，防止该类会执行一些不知道的方法
}

/*
 *  初始化dataSource类(初始化完之后，必须在之后设置想要展示的数据dataModels)
 *
 *  @param equalCellSizeSetting                 集合视图的布局设置
 *  @param cellForItemAtIndexPathBlock          dataSource中的cell(含dataCell和extralCell)进行定制用的block
 */
- (id)initWithEqualCellSizeSetting:(MyEqualCellSizeSetting *)equalCellSizeSetting
       cellForItemAtIndexPathBlock:(UICollectionViewCell* (^)(UICollectionView *collectionView, NSIndexPath *indexPath, BOOL isExtralItem))cellForItemAtIndexPathBlock
{
    self = [super init];
    if (self) {
        _equalCellSizeSetting = equalCellSizeSetting;
        self.cellForItemAtIndexPathBlock = [cellForItemAtIndexPathBlock copy];      //block 要copy
    }
    return self;
}

#pragma mark - Update
/// 更新额外cell的样式即位置，(默认不添加）
- (void)updateExtralItemSetting:(CJExtralItemSetting)extralItemSetting {
    _equalCellSizeSetting.extralItemSetting = extralItemSetting;
}

#pragma mark - UICollectionViewDataSource

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    BOOL isSearching = self.isSearching;
    NSArray *sectionDataModels = isSearching ? self.resultSectionDataModels : self.originSectionDataModels;
    
    NSInteger sectionCount = sectionDataModels.count;
    return sectionCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger cellCount = [self __numberOfItemsInSection:section];
    return cellCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL isExtralItem = [self isExtraItemIndexPath:indexPath];
    
    UICollectionViewCell *cell = self.cellForItemAtIndexPathBlock(collectionView, indexPath, isExtralItem);
    
    return cell;
}


/**
*  dataSoure中indexPath位置的dataModel值
*
*  @param indexPath    collectionView的indexPath
*/
- (id)dataModelAtIndexPath:(NSIndexPath *)indexPath {
    BOOL isSearching = self.isSearching;
    NSArray *sectionDataModels = isSearching ? self.resultSectionDataModels : self.originSectionDataModels;
    
    CJSectionDataModel *sectionDataModel = [sectionDataModels objectAtIndex:indexPath.section];
    NSMutableArray *dataModels = sectionDataModel.values;
    
    
    id dataModle = nil;
    
    CJExtralItemSetting extralItemSetting = self.equalCellSizeSetting.extralItemSetting;
    switch (extralItemSetting) {
        case CJExtralItemSettingLeading:
        {
            dataModle = [dataModels objectAtIndex:indexPath.item-1];
            break;
        }
        case CJExtralItemSettingTailing:
        case CJExtralItemSettingNone:
        default:
        {
            dataModle = [dataModels objectAtIndex:indexPath.item];
            break;
        }
    }
    
    return dataModle;
}



/*
*  判断indexPath是否是非数据即额外加上去的cell（如添加图片的cell）
*
*  @param indexPath     要判断的indexPath
*
*  @return indexPath    是否是非数据即额外加上去的cell（如添加图片的cell）
*/
- (BOOL)isExtraItemIndexPath:(NSIndexPath *)indexPath {
    BOOL isSearching = self.isSearching;
    NSArray *sectionDataModels = isSearching ? self.resultSectionDataModels : self.originSectionDataModels;
    
    CJSectionDataModel *sectionDataModel = [sectionDataModels objectAtIndex:indexPath.section];
    NSMutableArray *dataModels = sectionDataModel.values;
    
    BOOL isExtraItem = NO;
    
    CJExtralItemSetting extralItemSetting = self.equalCellSizeSetting.extralItemSetting;
    switch (extralItemSetting) {
        case CJExtralItemSettingLeading:
        {
            if (indexPath.row >= 1) {
                isExtraItem = NO;
            } else {
                isExtraItem = YES;
            }
            break;
        }
        case CJExtralItemSettingTailing:
        {
            if (indexPath.row < dataModels.count) {
                isExtraItem = NO;
            } else {
                isExtraItem = YES;
            }
            break;
        }
        case CJExtralItemSettingNone:
        default:
        {
            isExtraItem = NO;
            break;
        }
    }
    
    return isExtraItem;
}


/**
*  获取在数据是dataModels的时候，整个cellCount的个数(因为有可能有extralItem)
*
*  @param dataModels   dataModels的个数
*
*  @return 整个cellCount的个数
*/
- (NSInteger)__numberOfItemsInSection:(NSInteger)section {
    
    BOOL isSearching = self.isSearching;
    NSArray *sectionDataModels = isSearching ? self.resultSectionDataModels : self.originSectionDataModels;
    
    CJSectionDataModel *sectionDataModel = [sectionDataModels objectAtIndex:section];
    NSMutableArray *dataModels = sectionDataModel.values;
    NSInteger dataModelCount = dataModels.count;
    
    CJExtralItemSetting extralItemSetting = self.equalCellSizeSetting.extralItemSetting;
    switch (extralItemSetting) {
        case CJExtralItemSettingLeading:
        case CJExtralItemSettingTailing:
        {
            if (dataModelCount < self.equalCellSizeSetting.maxDataModelShowCount) {
                return dataModelCount + 1;
            } else {
                return dataModelCount;
            }
            
            break;
        }
        case CJExtralItemSettingNone:
        default:
        {
            return dataModelCount;
            break;
        }
    }
}



@end
