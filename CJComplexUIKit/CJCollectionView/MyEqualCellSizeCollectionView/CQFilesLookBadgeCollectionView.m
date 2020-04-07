//
//  CQFilesLookBadgeCollectionView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CQFilesLookBadgeCollectionView.h"
//#import "CQFilesLookBadgeCollectionViewCell.h"
#import "CQHomeMenuCollectionViewCell.h"

#import "MyEqualCellSizeCollectionViewDelegate.h"
#import "MyEqualCellSizeCollectionViewDataSource.h"

#import <SDWebImage/UIImageView+WebCache.h>


@interface CQFilesLookBadgeCollectionView () <UICollectionViewDataSource> {
    
}
@property (nonatomic, strong) MyEqualCellSizeCollectionViewDelegate *equalCellSizeCollectionViewDelegate;
@property (nonatomic, strong) MyEqualCellSizeCollectionViewDataSource *equalCellSizeCollectionViewDataSource;

@end


@implementation CQFilesLookBadgeCollectionView


- (void)commonInit {
    [super commonInit];
    
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = 6;
    
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
    //equalCellSizeSetting.maxDataModelShowCount = 5;
    //equalCellSizeSetting.extralItemSetting = CJExtralItemSettingTailing;
    
    
    //以下值，可选设置
    //self.allowsMultipleSelection = YES; //是否打开多选
    
    /* 设置Register的Cell或Nib */
    CQHomeMenuCollectionViewCell *registerCell = [[CQHomeMenuCollectionViewCell alloc] init];
    [self registerClass:[registerCell class] forCellWithReuseIdentifier:@"cell"];
    
    __weak typeof(self)weakSelf = self;
    
    /* 创建DataSource */
    MyEqualCellSizeCollectionViewDataSource *equalCellSizeCollectionViewDataSource = [[MyEqualCellSizeCollectionViewDataSource alloc] initWithEqualCellSizeSetting:equalCellSizeSetting cellForItemAtIndexPathBlock:^UICollectionViewCell *(UICollectionView *collectionView, NSIndexPath *indexPath, BOOL isExtralItem) {
        if (!isExtralItem) {
            CQHomeMenuCollectionViewCell *dataCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
            dataCell.backgroundColor = [UIColor redColor];
            NSLog(@"dataCell.selected = %@", dataCell.selected ? @"YES" : @"NO");
            [weakSelf __operateDataCell:dataCell withIndexPath:indexPath isSettingOperate:YES];

            return dataCell;
        } else {
            CQHomeMenuCollectionViewCell *extralCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"addCell" forIndexPath:indexPath];
            extralCell.iconImageView.image = [UIImage imageNamed:@"cjCollectionViewCellAdd"];
            
            return extralCell;
        }
    }];
    self.equalCellSizeCollectionViewDataSource = equalCellSizeCollectionViewDataSource;
    
    /* 创建Delegate (UICollectionViewDelegateFlowLayout也需实现UICollectionViewDelegate) */
    MyEqualCellSizeCollectionViewDelegate *delegate = [[MyEqualCellSizeCollectionViewDelegate alloc] initWithEqualCellSizeSetting:equalCellSizeSetting didTapItemBlock:^(UICollectionView *collectionView, NSIndexPath *indexPath, BOOL isDeselect, MyEqualCellSizeSetting *equalCellSizeSetting) {
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
        
        BOOL isExtralItem = [weakSelf.equalCellSizeCollectionViewDataSource isExtraItemIndexPath:indexPath];
        
        if (isExtralItem) {
            NSLog(@"点击额外的item");
            
        } else {
            NSLog(@"当前点击的Item为数据源中的第%zd个", indexPath.item);
        }
    }];
    self.equalCellSizeCollectionViewDelegate = delegate;
    
    /* 设置DataSource和Delegate */
    //self.dataSource = self;
    //self.delegate = self;
    self.dataSource = self.equalCellSizeCollectionViewDataSource;
    self.delegate = self.equalCellSizeCollectionViewDelegate;
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
    CGFloat height = [MyEqualCellSizeCollectionViewDelegate heightForAllCellCount:allCellCount byCollectionViewWidth:collectionViewWidth withEqualCellSizeSetting:equalCellSizeSetting];
    return height;
}

#pragma mark - Setter
- (void)setDataModels:(NSMutableArray<CJHomeMenuDataModel *> *)dataModels {
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
- (void)__operateDataCell:(CQHomeMenuCollectionViewCell *)dataCell
                withIndexPath:(NSIndexPath *)indexPath
            isSettingOperate:(BOOL)isSettingOperate
{
    CJHomeMenuDataModel *dataModel = [self.equalCellSizeCollectionViewDataSource dataModelAtIndexPath:indexPath];
    
    if (isSettingOperate) {
        [dataCell.iconImageView sd_setImageWithURL:[NSURL URLWithString:dataModel.imageUrl] placeholderImage:dataModel.imagePlaceholderImage];
        dataCell.titleNameLabel.text = dataModel.name;
        dataCell.badgeCount = dataModel.badgeCount;
    }
}


@end
