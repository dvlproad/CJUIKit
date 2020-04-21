//
//  MyEqualCellSizeCollectionViewDataSource.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/12.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "MyEqualCellSizeCollectionViewDataSource.h"

@interface MyEqualCellSizeCollectionViewDataSource () {
    
}
@property (nonatomic, copy) UICollectionViewCell* (^cellForItemAtIndexPathBlock)(UICollectionView *collectionView, NSIndexPath *indexPath, BOOL isExtralItem);

@end



@implementation MyEqualCellSizeCollectionViewDataSource

- (id)init {
    return nil; //没有使用data初始化的时候，dataSoure类设为空，防止该类会执行一些不知道的方法
}

/*
 *  初始化dataSource类(初始化完之后，必须在之后设置想要展示的数据dataModels)
 *
 *  @param dataSourceSettingModel           集合视图的数据类
 *  @param cellForItemAtIndexPathBlock          dataSource中的cell(含dataCell和extralCell)进行定制用的block
 */
- (id)initWithDataSourceSettingModel:(CJDataSourceSettingModel *)dataSourceSettingModel
         cellForItemAtIndexPathBlock:(UICollectionViewCell* (^)(UICollectionView *collectionView, NSIndexPath *indexPath, BOOL isExtralItem))cellForItemAtIndexPathBlock
{
    self = [super init];
    if (self) {
        if (dataSourceSettingModel == nil) {
            dataSourceSettingModel = [[CJDataSourceSettingModel alloc] init];
        }
        _dataSourceSettingModel = dataSourceSettingModel;
        self.cellForItemAtIndexPathBlock = [cellForItemAtIndexPathBlock copy];      //block 要copy
    }
    return self;
}

#pragma mark - Update
/// 更新额外cell的样式即位置，(默认不添加）
- (void)updateExtralItemSetting:(CJExtralItemSetting)extralItemSetting {
    _dataSourceSettingModel.extralItemSetting = extralItemSetting;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
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
    id dataModle = nil;
    
    CJExtralItemSetting extralItemSetting = self.dataSourceSettingModel.extralItemSetting;
    switch (extralItemSetting) {
        case CJExtralItemSettingLeading:
        {
            dataModle = [self.dataModels objectAtIndex:indexPath.item-1];
            break;
        }
        case CJExtralItemSettingTailing:
        case CJExtralItemSettingNone:
        default:
        {
            dataModle = [self.dataModels objectAtIndex:indexPath.item];
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
    BOOL isExtraItem = NO;
    
    CJExtralItemSetting extralItemSetting = self.dataSourceSettingModel.extralItemSetting;
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
            if (indexPath.row < self.dataModels.count) {
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
*  获取指定section的item个数
*
*  @param section   指定的section
*
*  @return 整个cellCount的个数
*/
- (NSInteger)__numberOfItemsInSection:(NSInteger)section {
    NSInteger dataModelCount = self.dataModels.count;
    
    CJExtralItemSetting extralItemSetting = self.dataSourceSettingModel.extralItemSetting;
    switch (extralItemSetting) {
        case CJExtralItemSettingLeading:
        case CJExtralItemSettingTailing:
        {
            if (dataModelCount < self.dataSourceSettingModel.maxDataModelShowCount) {
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
