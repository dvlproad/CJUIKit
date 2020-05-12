//
//  LuckinMenuCollectionView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "LuckinMenuCollectionView.h"
#import "CJCellHorizontalLayout.h"
#import "CQFilesLookBadgeCollectionViewCell.h"
#import "MyEqualCellSizeCollectionViewDataSource.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface LuckinMenuCollectionView () <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate> {
    
}
@property (nonatomic, copy, readonly) void (^didTapShowingItemBlock)(UICollectionView *collectionView, NSIndexPath *indexPath, LuckinMenuDataModel *dataModel); /**< 点击item的事件 */
@property (nonatomic, strong) MyEqualCellSizeCollectionViewDataSource *equalCellSizeCollectionViewDataSource;

@end


@implementation LuckinMenuCollectionView

/// 初始化方法
- (instancetype)initWithDidTapShowingItemBlock:(void(^)(UICollectionView *collectionView, NSIndexPath *indexPath, LuckinMenuDataModel *dataModel))didTapShowingItemBlock {
    UICollectionViewLayout *layout = [self __horizontalLayout];
    self = [super initWithFrame:CGRectZero collectionViewLayout:layout];
    if (self) {
        _didTapShowingItemBlock = didTapShowingItemBlock;
        _maxBadgeNumber = 9;
        
        [self setupConfigure];
        
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

/// 水平滚动的collectionView布局
- (UICollectionViewLayout *)__horizontalLayout {
    CJCellHorizontalLayout *cellHorizontalLayout = [[CJCellHorizontalLayout alloc] init];
    cellHorizontalLayout.cellWidthFromPerRowMaxShowCount = 4;
    cellHorizontalLayout.widthHeightRatio = 1/1.0;
    
    cellHorizontalLayout.sectionInset = UIEdgeInsetsMake(15, 10, 15, 10);
    cellHorizontalLayout.minimumLineSpacing = 15-4;
    cellHorizontalLayout.minimumInteritemSpacing = 10;
    
    return cellHorizontalLayout;
}


- (void)setupConfigure {
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = 6;
    
    
    /* 设置Register的Cell或Nib */
    CQFilesLookBadgeCollectionViewCell *registerCell = [[CQFilesLookBadgeCollectionViewCell alloc] init];
    [self registerClass:[registerCell class] forCellWithReuseIdentifier:@"cell"];
    
    __weak typeof(self)weakSelf = self;
    
    /* 创建DataSource */
    MyEqualCellSizeCollectionViewDataSource *equalCellSizeCollectionViewDataSource = [[MyEqualCellSizeCollectionViewDataSource alloc] initWithDataSourceSettingModel:nil cellForItemAtIndexPathBlock:^UICollectionViewCell *(UICollectionView *collectionView, NSIndexPath *indexPath, BOOL isExtralItem) {
        if (!isExtralItem) {
            CQFilesLookBadgeCollectionViewCell *dataCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
            //dataCell.backgroundColor = [UIColor redColor];
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
    
    
    /* 设置DataSource和Delegate */
    //self.dataSource = self;
    self.delegate = self;
    self.dataSource = self.equalCellSizeCollectionViewDataSource;
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
    
    CJCellHorizontalLayout *layout = (CJCellHorizontalLayout *)self.collectionViewLayout;
    CGFloat height = [CJCellHorizontalLayout heightForAllCellCount:allCellCount maxRowCount:2 byCollectionViewWidth:collectionViewWidth withCollectionViewLayout:layout];
    
    return height;
}

#pragma mark - Setter
- (void)setDataModels:(NSMutableArray<CQFilesLookBadgeDataModel *> *)dataModels {
    _dataModels = dataModels;
    self.equalCellSizeCollectionViewDataSource.dataModels = dataModels;
}



//#pragma mark - UICollectionViewDelegate
////“点到”item时候执行的时间(allowsMultipleSelection为默认的NO的时候，只有选中，而为YES的时候有选中和取消选中两种操作)
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"当前点击的Item为数据源中的第%zd个", indexPath.item);
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    CQFilesLookBadgeDataModel *dataModel = [self.equalCellSizeCollectionViewDataSource dataModelAtIndexPath:indexPath];
    if (self.didTapShowingItemBlock) {
        self.didTapShowingItemBlock(collectionView, indexPath, dataModel);
    }
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
