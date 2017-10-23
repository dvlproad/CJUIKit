//
//  CJBaseChooseCollectionView.m
//  AllScrollViewDemo
//
//  Created by ciyouzen on 2016/06/07.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJBaseChooseCollectionView.h"

@interface CJBaseChooseCollectionView() <UICollectionViewDataSource> {
    
}
@property (nonatomic, copy, readonly) CJConfigureCollectionViewCellBlock configureDataCellBlock;
@property (nonatomic, copy, readonly) CJConfigureCollectionViewCellBlock configureExtraCellBlock;
@property (nonatomic, copy, readonly) CJDidTapCollectionViewItemBlock didTapDataItemBlock;
@property (nonatomic, copy, readonly) CJDidTapCollectionViewItemBlock didTapExtraItemBlock;

@end


@implementation CJBaseChooseCollectionView

- (void)commonInit {
    [super commonInit];
    
    self.dataModels = [[NSMutableArray alloc] init];
    
    [self setupCollectionView];
}

- (void)setupCollectionView {
    /* //放在这里设置flowLayout,会由于CGRectGetWidth(self.frame);初始太大而导致计算错误
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //flowLayout.headerReferenceSize = CGSizeMake(110, 135);
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 15;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    //flowLayout.itemSize = CGSizeMake(60, 60);
    CGFloat maxShowItemCount = 4;
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat validWith = width-flowLayout.sectionInset.left-flowLayout.sectionInset.right-flowLayout.minimumInteritemSpacing*(maxShowItemCount-1);
    CGFloat collectionViewCellWidth = floorf(validWith/maxShowItemCount);
    flowLayout.itemSize = CGSizeMake(collectionViewCellWidth, collectionViewCellWidth);
    [self setCollectionViewLayout:flowLayout animated:NO completion:nil];
    */
    
    MyEqualCellSizeSetting *equalCellSizeSetting = [[MyEqualCellSizeSetting alloc] init];
    equalCellSizeSetting.minimumInteritemSpacing = 10;
    equalCellSizeSetting.minimumLineSpacing = 10;
    equalCellSizeSetting.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    //以下值必须二选一设置（默认cellWidthFromFixedWidth设置后，另外一个自动失效）
    equalCellSizeSetting.cellWidthFromPerRowMaxShowCount = 4;
    //equalCellSizeSetting.cellWidthFromFixedWidth = 50;
    
    //以下值，可选设置
    //equalCellSizeSetting.collectionViewCellHeight = 100;
    //equalCellSizeSetting.maxDataModelShowCount = 5;
    equalCellSizeSetting.extralItemSetting = CJExtralItemSettingLeading;
    
    self.equalCellSizeSetting = equalCellSizeSetting;
    
    
    /* 设置DataSource */
    self.dataSource = self;
    
    /* 设置Delegate */
    __weak typeof(self)weakSelf = self;
    self.didTapItemBlock = ^(UICollectionView *collectionView, NSIndexPath *indexPath, BOOL isDeselect) {
        MyEqualCellSizeSetting *equalCellSizeSetting = weakSelf.equalCellSizeSetting;
        BOOL isExtralItem = [equalCellSizeSetting isExtraItemIndexPath:indexPath dataModels:weakSelf.dataModels];
        if (!isExtralItem) {
            if (weakSelf.didTapDataItemBlock) {
                weakSelf.didTapDataItemBlock(weakSelf, indexPath, NO);
            }
            
        } else {
            if (weakSelf.didTapExtraItemBlock) {
                weakSelf.didTapExtraItemBlock(weakSelf, indexPath, NO);
            }
        }
    };
}

- (void)setupConfigureDataCellBlock:(CJConfigureCollectionViewCellBlock)configureDataCellBlock
            configureExtraCellBlock:(CJConfigureCollectionViewCellBlock)configureExtraCellBlock
             didTapDataItemBlock:(CJDidTapCollectionViewItemBlock)didTapDataItemBlock
            didTapExtraItemBlock:(CJDidTapCollectionViewItemBlock)didTapExtraItemBlock
{
    _configureDataCellBlock = configureDataCellBlock;
    _configureExtraCellBlock = configureExtraCellBlock;
    _didTapDataItemBlock = didTapDataItemBlock;
    _didTapExtraItemBlock = didTapExtraItemBlock;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger cellCount = [self.equalCellSizeSetting getCellCountByDataModels:self.dataModels];
    return cellCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyEqualCellSizeSetting *equalCellSizeSetting = self.equalCellSizeSetting;
    BOOL isExtralItem = [equalCellSizeSetting isExtraItemIndexPath:indexPath dataModels:self.dataModels];
    if (!isExtralItem) {
        NSAssert(self.configureDataCellBlock != nil, @"未设置configureDataCellBlock");
        return self.configureDataCellBlock(collectionView, indexPath);
        
    } else {
        NSAssert(self.configureExtraCellBlock != nil, @"未设置configureExtraCellBlock");
        return self.configureExtraCellBlock(collectionView, indexPath);
    }
}

@end
