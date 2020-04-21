//
//  CQFilesLookBadgeCollectionView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CQFilesLookBadgeCollectionView.h"
#import "CQFilesLookBadgeCollectionViewCell.h"

#import "MyEqualCellSizeCollectionViewNormalDelegate.h"
#import "MyEqualCellSizeCollectionViewDataSource.h"

#import <SDWebImage/UIImageView+WebCache.h>

#import "UICollectionView+CJFlowLayoutScrollDirection.h"
#import "CJCellHorizontalLayout.h"


@interface CQFilesLookBadgeCollectionView () <UICollectionViewDataSource> {
    
}
@property (nonatomic, strong, readonly) MyEqualCellSizeSetting *equalCellSizeSetting;
@property (nonatomic, strong) MyEqualCellSizeCollectionViewNormalDelegate *equalCellSizeCollectionViewDelegate;
@property (nonatomic, strong) MyEqualCellSizeCollectionViewDataSource *equalCellSizeCollectionViewDataSource;

@property (nonatomic, copy, readonly) void (^didTapShowingItemBlock)(UICollectionView *collectionView, NSIndexPath *indexPath, CQFilesLookBadgeDataModel *dataModel); /**< 点击item的事件 */

@end


@implementation CQFilesLookBadgeCollectionView

/// 初始化方法
- (instancetype)initWithDidTapShowingItemBlock:(void(^)(UICollectionView *collectionView, NSIndexPath *indexPath, CQFilesLookBadgeDataModel *dataModel))didTapShowingItemBlock {
    UICollectionViewLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self = [super initWithFrame:CGRectZero collectionViewLayout:layout];
    if (self) {
        _didTapShowingItemBlock = didTapShowingItemBlock;
        _maxBadgeNumber = 99;
        
        [self setupConfigure];
    }
    return self;
}

- (void)setupConfigure {
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = 6;
    
    MyEqualCellSizeSetting *equalCellSizeSetting = [[MyEqualCellSizeSetting alloc] init];
    equalCellSizeSetting.minimumInteritemSpacing = 10;
    equalCellSizeSetting.minimumLineSpacing = 10;
    equalCellSizeSetting.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    //以下值必须二选一设置（默认cellWidthFromFixedWidth设置后，另外一个自动失效）
    //equalCellSizeSetting.cellWidthFromPerRowMaxShowCount = 4;
    //equalCellSizeSetting.cellWidthFromFixedWidth = 50;

    //以下值，可选设置
    //equalCellSizeSetting.cellHeightFromFixedHeight = 100;
    equalCellSizeSetting.cellHeightFromPerColumnMaxShowCount = 2;
    //equalCellSizeSetting.maxDataModelShowCount = 5;
    //equalCellSizeSetting.extralItemSetting = CJExtralItemSettingTailing;
    _equalCellSizeSetting = equalCellSizeSetting;
    
    CJDataSourceSettingModel *dataSourceSettingModel = [[CJDataSourceSettingModel alloc] init];
    
    
    //以下值，可选设置
    //self.allowsMultipleSelection = YES; //是否打开多选
    
    /* 设置Register的Cell或Nib */
    CQFilesLookBadgeCollectionViewCell *registerCell = [[CQFilesLookBadgeCollectionViewCell alloc] init];
    [self registerClass:[registerCell class] forCellWithReuseIdentifier:@"cell"];
    
    __weak typeof(self)weakSelf = self;
    
    /* 创建DataSource */
    MyEqualCellSizeCollectionViewDataSource *equalCellSizeCollectionViewDataSource = [[MyEqualCellSizeCollectionViewDataSource alloc] initWithDataSourceSettingModel:dataSourceSettingModel cellForItemAtIndexPathBlock:^UICollectionViewCell *(UICollectionView *collectionView, NSIndexPath *indexPath, BOOL isExtralItem) {
        if (!isExtralItem) {
            CQFilesLookBadgeCollectionViewCell *dataCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
            dataCell.backgroundColor = [UIColor redColor];
            NSLog(@"dataCell.selected = %@", dataCell.selected ? @"YES" : @"NO");
            [weakSelf __operateDataCell:dataCell withIndexPath:indexPath isSettingOperate:YES];

            return dataCell;
        } else {
            CQFilesLookBadgeCollectionViewCell *extralCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"addCell" forIndexPath:indexPath];
            extralCell.iconImageView.image = [UIImage imageNamed:@"cjCollectionViewCellAdd"];
            
            return extralCell;
        }
    }];
    self.equalCellSizeCollectionViewDataSource = equalCellSizeCollectionViewDataSource;
    
    /* 创建Delegate (UICollectionViewDelegateFlowLayout也需实现UICollectionViewDelegate) */
    MyEqualCellSizeCollectionViewNormalDelegate *delegate = [[MyEqualCellSizeCollectionViewNormalDelegate alloc] initWithEqualCellSizeSetting:equalCellSizeSetting didTapItemBlock:^(UICollectionView *collectionView, NSIndexPath *indexPath, BOOL isDeselect, MyEqualCellSizeSetting *equalCellSizeSetting) {
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
        
        BOOL isExtralItem = [weakSelf.equalCellSizeCollectionViewDataSource isExtraItemIndexPath:indexPath];
        
        if (isExtralItem) {
            NSLog(@"点击额外的item");
            
        } else {
            NSLog(@"当前点击的Item为数据源中的第%zd个", indexPath.item);
            CQFilesLookBadgeDataModel *dataModel = [self.equalCellSizeCollectionViewDataSource dataModelAtIndexPath:indexPath];
            if (self.didTapShowingItemBlock) {
                self.didTapShowingItemBlock(collectionView, indexPath, dataModel);
            }
        }
    }];
    self.equalCellSizeCollectionViewDelegate = delegate;
    
    /* 设置DataSource和Delegate */
    //self.dataSource = self;
    //self.delegate = self;
    self.dataSource = self.equalCellSizeCollectionViewDataSource;
//    self.delegate = self.equalCellSizeCollectionViewDelegate;
}

#pragma mark - Getter
/*
*  获取collectionView的高度
*
*  @param marginLeft         collectionView与屏幕的左边距
*  @param marginRight        collectionView与屏幕的右边距
*
*  @return
*/
- (CGFloat)heightByScreenMarginLeft:(CGFloat)marginLeft
                  screenMarginRight:(CGFloat)marginRight
{
    CGFloat screenWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    CGFloat collectionViewWidth = screenWidth-marginLeft-marginRight;
    
    NSInteger allCellCount = self.equalCellSizeCollectionViewDataSource.dataModels.count;
    MyEqualCellSizeSetting *equalCellSizeSetting = self.equalCellSizeCollectionViewDelegate.equalCellSizeSetting;
    CGFloat height = [MyEqualCellSizeCollectionViewNormalDelegate heightForAllCellCount:allCellCount byCollectionViewWidth:collectionViewWidth withEqualCellSizeSetting:equalCellSizeSetting];
    return height;
}

#pragma mark - Setter
/// 将列表以水平滚动，并且行数为rowCount
- (void)showHorizontalWithRowCount:(NSInteger)rowCount {
//    self.cjScrollDirection = UICollectionViewScrollDirectionHorizontal;
    [self setupCJCellHorizontalLayout:rowCount];
    self.equalCellSizeSetting.cellHeightFromPerColumnMaxShowCount = rowCount;
}

- (void)setupCJCellHorizontalLayout:(NSInteger)rowCount {
    CJCellHorizontalLayout *cellHorizontalLayout = [[CJCellHorizontalLayout alloc] init];
    //以下值必须二选一设置（默认cellWidthFromFixedWidth设置后，另外一个自动失效）
    //cellHorizontalLayout.cellWidthFromPerRowMaxShowCount = 4;
//    cellHorizontalLayout.cellWidthFromFixedWidth = 70;
//
//    //以下值，可选设置
////    cellHorizontalLayout.cellHeightFromFixedHeight = 85;
    cellHorizontalLayout.cellHeightFromPerColumnMaxShowCount = rowCount;
//
//    cellHorizontalLayout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
//    cellHorizontalLayout.minimumLineSpacing = 1;
//    cellHorizontalLayout.minimumInteritemSpacing = 1;
    
    [self setCollectionViewLayout:cellHorizontalLayout];
}

- (void)setDataModels:(NSMutableArray<CQFilesLookBadgeDataModel *> *)dataModels {
    _dataModels = dataModels;
    self.equalCellSizeCollectionViewDataSource.dataModels = dataModels;
}

#pragma mark - Update
/// 更新额外cell的样式即位置，(默认不添加）
- (void)updateExtralItemSetting:(CJExtralItemSetting)extralItemSetting {
    [self.equalCellSizeCollectionViewDataSource updateExtralItemSetting:extralItemSetting];
    [self.equalCellSizeCollectionViewDelegate updateExtralItemSetting:extralItemSetting];
}


#pragma mark - Private Method
/*
 *  设置或者更新Cell
 *
 *  @param cell             要设置或者更新的Cell
 *  @param indexPath        要设置或者更新的Cell的indexPath
 *  @param isSettingOperate 是否是设置，如果否则为更新
 */
- (void)__operateDataCell:(CQFilesLookBadgeCollectionViewCell *)dataCell
                withIndexPath:(NSIndexPath *)indexPath
            isSettingOperate:(BOOL)isSettingOperate
{
    CQFilesLookBadgeDataModel *dataModel = [self.equalCellSizeCollectionViewDataSource dataModelAtIndexPath:indexPath];
    
    if (isSettingOperate) {
        [dataCell.iconImageView sd_setImageWithURL:[NSURL URLWithString:dataModel.imageUrl] placeholderImage:dataModel.imagePlaceholderImage];
        dataCell.titleNameLabel.text = dataModel.name;
        [dataCell setupBadgeCount:dataModel.badgeCount withMaxNumber:self.maxBadgeNumber];
    }
}


@end
