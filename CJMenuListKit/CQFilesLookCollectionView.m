//
//  CQFilesLookCollectionView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CQFilesLookCollectionView.h"
#import "CQFilesLookCollectionViewCell.h"

#import "MyEqualCellSizeCollectionViewNormalDelegate.h"
#import "MyEqualCellSizeCollectionViewSelectDelegate.h"
#import "MyEqualCellSizeCollectionViewDataSource.h"

#import "UICollectionView+CJSelect.h"

@interface CQFilesLookCollectionView () <UICollectionViewDataSource> {
    
}
@property (nonatomic, strong) MyEqualCellSizeCollectionViewBaseDelegate *equalCellSizeCollectionViewDelegate;
@property (nonatomic, strong) MyEqualCellSizeCollectionViewDataSource *equalCellSizeCollectionViewDataSource;

@property (nonatomic, assign) DataCellActionType dataCellActionType;/**< 当前状态dataCell点击执行的操作是 */

@end


@implementation CQFilesLookCollectionView


/// 初始化方法
- (instancetype)init {
    UICollectionViewLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self = [super initWithFrame:CGRectZero collectionViewLayout:layout];
    if (self) {
        [self setupConfigure];
    }
    return self;
}
- (void)setupConfigure {
    self.backgroundColor = [UIColor clearColor];
    
    MyEqualCellSizeSetting *equalCellSizeSetting = [[MyEqualCellSizeSetting alloc] init];
    equalCellSizeSetting.minimumInteritemSpacing = 10;
    equalCellSizeSetting.minimumLineSpacing = 15;
    equalCellSizeSetting.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    //以下值必须二选一设置（默认cellWidthFromFixedWidth设置后，另外一个自动失效）
    equalCellSizeSetting.cellWidthFromPerRowMaxShowCount = 4;
    //equalCellSizeSetting.cellWidthFromFixedWidth = 50;

    //以下值，可选设置
    //equalCellSizeSetting.cellHeightFromFixedHeight = 100;
    //equalCellSizeSetting.cellHeightFromPerColumnMaxShowCount = 2;
    CJDataSourceSettingModel *dataSourceSettingModel = [[CJDataSourceSettingModel alloc] init];
    dataSourceSettingModel.maxDataModelShowCount = 5;
    dataSourceSettingModel.extralItemSetting = CJExtralItemSettingTailing;
    
    
    //以下值，可选设置
    //self.allowsMultipleSelection = YES; //是否打开多选
    
    /* 设置Register的Cell或Nib */
    CQFilesLookCollectionViewCell *registerCell = [[CQFilesLookCollectionViewCell alloc] init];
    [self registerClass:[registerCell class] forCellWithReuseIdentifier:@"cell"];
    [self registerClass:[registerCell class] forCellWithReuseIdentifier:@"addCell"];
    
    __weak typeof(self)weakSelf = self;
    
    /* 创建DataSource */
    MyEqualCellSizeCollectionViewDataSource *equalCellSizeCollectionViewDataSource = [[MyEqualCellSizeCollectionViewDataSource alloc] initWithDataSourceSettingModel:dataSourceSettingModel cellForItemAtIndexPathBlock:^UICollectionViewCell *(UICollectionView *collectionView, NSIndexPath *indexPath, BOOL isExtralItem) {
        if (!isExtralItem) {
            CQFilesLookCollectionViewCell *dataCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
            NSLog(@"dataCell.selected = %@", dataCell.selected ? @"YES" : @"NO");
            [weakSelf __operateDataCell:dataCell withIndexPath:indexPath isSettingOperate:YES];

            return dataCell;
        } else {
            CQFilesLookCollectionViewCell *extralCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"addCell" forIndexPath:indexPath];
            extralCell.cjImageView.image = [UIImage imageNamed:@"cjCollectionViewCellAdd"];
            
            return extralCell;
        }
    }];
    self.equalCellSizeCollectionViewDataSource = equalCellSizeCollectionViewDataSource;
    
    /* 创建Delegate (UICollectionViewDelegateFlowLayout也需实现UICollectionViewDelegate) */
    MyEqualCellSizeCollectionViewNormalDelegate *normalDelegate = [[MyEqualCellSizeCollectionViewNormalDelegate alloc] initWithEqualCellSizeSetting:equalCellSizeSetting didTapItemBlock:^(UICollectionView *collectionView, NSIndexPath *indexPath, BOOL isDeselect, MyEqualCellSizeSetting *equalCellSizeSetting) {
        BOOL isExtralItem = [weakSelf.equalCellSizeCollectionViewDataSource isExtraItemIndexPath:indexPath];
        
        if (isExtralItem) {
            NSLog(@"点击额外的item");
            
        } else {
            NSLog(@"当前点击的Item为数据源中的第%zd个", indexPath.item);
            if (weakSelf.dataCellActionType == DataCellActionTypeNone) {
                
            } else if (weakSelf.dataCellActionType == DataCellActionTypeBrowse) {
                NSLog(@"浏览");
            } else if (weakSelf.dataCellActionType == DataCellActionTypeSelect) {
                /* 测试“我与其他不共存功能” */
                [self my_didTapItemAtIndexPath:indexPath withAlwaysAloneIndexPath:self.alwaysAloneIndexPath thisCellUpdateBlock:^(UICollectionView *collectionView, NSIndexPath *indexPath) {
                    UICollectionViewCell *dataCell = [collectionView cellForItemAtIndexPath:indexPath];
                    [weakSelf __operateDataCell:dataCell withIndexPath:indexPath isSettingOperate:NO];
                }];
            }
        }
    }];
    
    MyEqualCellSizeCollectionViewSelectDelegate *selectDelegate = [[MyEqualCellSizeCollectionViewSelectDelegate alloc] initWithEqualCellSizeSetting:equalCellSizeSetting withAlwaysAloneIndexPath:self.alwaysAloneIndexPath cellBrowseBlock:^(UICollectionView *collectionView, NSIndexPath *indexPath) {
        NSLog(@"浏览");
    } cellSelectedBlock:^(UICollectionView *collectionView, NSIndexPath *indexPath) {
        UICollectionViewCell *dataCell = [self cellForItemAtIndexPath:indexPath];
        [weakSelf __operateDataCell:dataCell withIndexPath:indexPath isSettingOperate:NO];
    }];
    
    
    self.equalCellSizeCollectionViewDelegate = selectDelegate;
    
    /* 设置DataSource和Delegate */
    //self.dataSource = self;
    //self.delegate = self;
    self.dataSource = self.equalCellSizeCollectionViewDataSource;
    self.delegate = self.equalCellSizeCollectionViewDelegate;
    
    
    self.isChoosing = NO;
    self.dataCellActionType = DataCellActionTypeBrowse;
}



#pragma mark - Setter
- (void)setIsChoosing:(BOOL)isChoosing {
    _isChoosing = isChoosing;
    
    if (isChoosing) {
        _dataCellActionType = DataCellActionTypeSelect;
    } else {
        _dataCellActionType = DataCellActionTypeBrowse;
    }
    
    [self reloadData];
}

- (void)setDataModels:(NSMutableArray<CJFilesLookDataModel *> *)dataModels {
    _dataModels = dataModels;
    self.equalCellSizeCollectionViewDataSource.dataModels = dataModels;
}

#pragma mark - Update
/// 更新额外cell的样式即位置，(默认不添加）
- (void)updateExtralItemSetting:(CJExtralItemSetting)extralItemSetting {
    [self.equalCellSizeCollectionViewDataSource updateExtralItemSetting:extralItemSetting];
}


#pragma mark - Private Method
/*
 *  设置或者更新Cell
 *
 *  @param cell             要设置或者更新的Cell
 *  @param indexPath        要设置或者更新的Cell的indexPath
 *  @param isSettingOperate 是否是设置，如果否则为更新
 */
- (void)__operateDataCell:(CQFilesLookCollectionViewCell *)dataCell
                withIndexPath:(NSIndexPath *)indexPath
            isSettingOperate:(BOOL)isSettingOperate
{
    CJFilesLookDataModel *dataModel = [self.equalCellSizeCollectionViewDataSource dataModelAtIndexPath:indexPath];
    
    if (isSettingOperate) {
        dataCell.cjTextLabel.text = dataModel.title;
        dataCell.cjImageView.image = dataModel.image;
        dataCell.cjSelectedButton.hidden = !self.isChoosing;
    }
}


@end
