//
//  MyCycleADView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/10/15.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "MyCycleADView.h"
#import "CJFullBottomCollectionViewCell.h"

@interface MyCycleADView () <UICollectionViewDataSource> {
    
}
@property (nonatomic) NSTimer *autoPlayNextTimer;
@property (nonatomic, assign) NSInteger currentIndex;

@end


@implementation MyCycleADView

- (void)commonInit {
    [super commonInit];
    
    [self setupEuqalCellSizeCollectionView];
}


- (void)setupEuqalCellSizeCollectionView {
    /* 基本设置 */
    self.pagingEnabled = YES;
//    self.showsVerticalScrollIndicator = NO;
//    self.showsHorizontalScrollIndicator = NO;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    /* 布局equalCellSizeSetting设置 */
    MyEqualCellSizeSetting *equalCellSizeSetting = [[MyEqualCellSizeSetting alloc] init];
//    equalCellSizeSetting.minimumInteritemSpacing = 0;
//    equalCellSizeSetting.minimumLineSpacing = 0;
//    equalCellSizeSetting.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    //以下值必须二选一设置（默认cellWidthFromFixedWidth设置后，另外一个自动失效）
    equalCellSizeSetting.cellWidthFromPerRowMaxShowCount = 1;
    //equalCellSizeSetting.cellWidthFromFixedWidth = 50;
    
    //以下值，可选设置
    //equalCellSizeSetting.cellHeightFromFixedHeight = 30;
    equalCellSizeSetting.cellHeightFromPerColumnMaxShowCount = 1;
    //equalCellSizeSetting.maxDataModelShowCount = 5;
    //equalCellSizeSetting.extralItemSetting = CJExtralItemSettingLeading;
    
    self.equalCellSizeSetting = equalCellSizeSetting;
    
    /* 设置Register的Cell或Nib */
    CJFullBottomCollectionViewCell *registerCell = [[CJFullBottomCollectionViewCell alloc] init];
    [self registerClass:[registerCell class] forCellWithReuseIdentifier:@"cell"];
    
    /* 设置DataSource */
    self.dataSource = self;
    
    /* 设置Delegate */
    __weak typeof(self)weakSelf = self;
    self.didTapItemBlock = ^(UICollectionView *collectionView, NSIndexPath *indexPath, BOOL isDeselect) {
        if (isDeselect) {
            return;
        }
        
        NSLog(@"当前点击的Item为数据源中的第%ld个", indexPath.item);
        
        CJFullBottomCollectionViewCell *cell = (CJFullBottomCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [weakSelf operateCell:cell withDataModelIndexPath:indexPath isSettingOperate:NO];
    };
    
    //TODO:定时器的处理，滑动的时候定时器要停止且位置要更新到滑动的位置等,请参考SDCycleScrollView
    //TODO:这个定时器方法是iOS10方法，在8.4模拟器上就会出现崩溃问题
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self goShowNextAD];
    }];
    self.autoPlayNextTimer = timer;
    self.currentIndex = 0;
}

- (void)goShowNextAD {
    self.currentIndex ++;
    NSIndexPath *scrollToIndexPath = [NSIndexPath indexPathForItem:self.currentIndex inSection:0];
    [self scrollToItemAtIndexPath:scrollToIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger actualDataModelCount = [self.equalCellSizeSetting getCellCountByDataModels:self.dataModels];
    return actualDataModelCount * 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger actualDataModelCount = [self.dataModels count];
    NSInteger newIndex = indexPath.item%actualDataModelCount;
    indexPath = [NSIndexPath indexPathForItem:newIndex inSection:indexPath.section];
    
    MyEqualCellSizeSetting *equalCellSizeSetting = self.equalCellSizeSetting;
    BOOL isExtralItem = [equalCellSizeSetting isExtraItemIndexPath:indexPath dataModels:self.dataModels];
    
    if (!isExtralItem) {
        CJFullBottomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        [self operateCell:cell withDataModelIndexPath:indexPath isSettingOperate:YES];
        
        return cell;
        
    } else {
        return nil;
    }
}


/**
 *  设置或者更新Cell
 *
 *  @param cell             要设置或者更新的Cell
 *  @param indexPath        用于获取数据的indexPath(此值一般情况下与cell的indexPath相等)
 *  @param isSettingOperate 是否是设置，如果否则为更新
 */
- (void)operateCell:(CJFullBottomCollectionViewCell *)cell withDataModelIndexPath:(NSIndexPath *)indexPath isSettingOperate:(BOOL)isSettingOperate {
    NSInteger actualDataModelCount = [self.dataModels count];
    NSInteger newIndex = indexPath.item%actualDataModelCount;
    indexPath = [NSIndexPath indexPathForItem:newIndex inSection:indexPath.section];
    
    MyADModel *dataModle = [self.equalCellSizeSetting getDataModelAtIndexPath:indexPath dataModels:self.dataModels];
    if (isSettingOperate) {
        cell.cjTextLabel.text = dataModle.text;
    }
    
    if (dataModle.imageName) {
        cell.cjImageView.image = [UIImage imageNamed:dataModle.imageName];
    } else {
        cell.cjImageView.image = [UIImage imageNamed:@"icon.png"];
    }
    
    
}


@end
