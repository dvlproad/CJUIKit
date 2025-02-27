//
//  CQTSRipeImageCollectionView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 8/10/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CQTSRipeImageCollectionView.h"
#import "CQTSRipeImageCollectionViewCell.h"
#import <CQDemoKit/CQTSLocImagesUtil.h>
#import <CQDemoKit/CQTSNetImagesUtil.h>
#import "CQTSIconsUtil.h"

@interface CQTSRipeImageCollectionView () <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource> {
    
}
@property (nonatomic, assign, readonly) CGFloat perMaxCount;   /**< 每行/每列个数 */

@property (nonatomic, strong, readonly) NSArray<NSNumber *> *sectionRowCounts;  /**< 每个section的rowCount个数 */
@property (nonatomic, assign, readonly) CQTSRipeImageSource ripeImageSource;   /**< 数据源(有网络图片、本地图片、网络icon) */

@end


@implementation CQTSRipeImageCollectionView

#pragma mark - Init
/*
 *  初始化 CollectionView
 *
 *  @param scrollDirection      集合视图的滚动方向
 *  @param perMaxCount          当滚动方向为①水平时,每列显示几个；②竖直时,每行显示几个；
 *
 *  @return CollectionView
 */
- (instancetype)initWithScrollDirection:(UICollectionViewScrollDirection)scrollDirection
                            perMaxCount:(NSInteger)perMaxCount
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = scrollDirection;
    self = [super initWithFrame:CGRectZero collectionViewLayout:layout];
    if (self) {
        _perMaxCount = perMaxCount;
        
        [self registerClass:[CQTSRipeImageCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

#pragma mark - Setup
/*
 *  只设置数据源
 *
 *  @param sectionRowCounts     每个section的rowCount个数(数组有多少个就多少个section，数组里的元素值为该section的row行数)
 *  @param ripeImageSource      数据源(有网络图片、本地图片、网络icon)
 */
- (void)setupSectionRowCounts:(NSArray<NSNumber *> *)sectionRowCounts
              ripeImageSource:(CQTSRipeImageSource)ripeImageSource
{
    _sectionRowCounts = sectionRowCounts;
    _ripeImageSource = ripeImageSource;
}



#pragma mark - UICollectionViewDelegateFlowLayout
// 此部分已在父类中实现
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat collectionViewCellWidth = 0;
    CGFloat collectionViewCellHeight = 0;
    
    UICollectionViewFlowLayout *flowLayout = collectionViewLayout;
    BOOL isScrollHorizontal = flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal;
    if (isScrollHorizontal) {   // 按水平方向滚动时，按个数计算cell的高
        NSInteger perColumnMaxRowCount = self.perMaxCount;
        
        UIEdgeInsets sectionInset = [self collectionView:collectionView
                                                  layout:collectionViewLayout
                                  insetForSectionAtIndex:indexPath.section];;
        CGFloat rowSpacing = [self collectionView:collectionView
                                           layout:collectionViewLayout
         minimumInteritemSpacingForSectionAtIndex:indexPath.section];
        
        CGFloat height = CGRectGetHeight(collectionView.frame);
        CGFloat validHeight = height - sectionInset.top - sectionInset.bottom - rowSpacing*(perColumnMaxRowCount-1);
        collectionViewCellHeight = floorf(validHeight/perColumnMaxRowCount);
        collectionViewCellWidth = collectionViewCellHeight;
        
    } else {                    // 按竖直方向滚动时，按个数计算cell的宽
        NSInteger perRowMaxColumnCount = self.perMaxCount;
        
        UIEdgeInsets sectionInset = [self collectionView:collectionView
                                                  layout:collectionViewLayout
                                  insetForSectionAtIndex:indexPath.section];
        CGFloat columnSpacing = [self collectionView:collectionView
                                              layout:collectionViewLayout
            minimumInteritemSpacingForSectionAtIndex:indexPath.section];
        
        CGFloat width = CGRectGetWidth(collectionView.frame);
        CGFloat validWith = width - sectionInset.left - sectionInset.right - columnSpacing*(perRowMaxColumnCount-1);
        collectionViewCellWidth = floorf(validWith/perRowMaxColumnCount);
        collectionViewCellHeight = collectionViewCellWidth;
    }
    
    
    return CGSizeMake(collectionViewCellWidth, collectionViewCellHeight);
}

#pragma mark - UICollectionViewDelegate
////“点到”item时候执行的时间(allowsMultipleSelection为默认的NO的时候，只有选中，而为YES的时候有选中和取消选中两种操作)
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sectionRowCounts.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSNumber *nRowCount = [self.sectionRowCounts objectAtIndex:section];
    NSInteger iRowCount = [nRowCount integerValue];
    
    return iRowCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CQTSRipeImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    // title
    NSString *title = [NSString stringWithFormat:@"%zd", indexPath.row];
    [cell setupText:title];
    
    // image
    if (self.ripeImageSource == CQTSRipeImageSourceImageNetwork) {      // 网络图片
        NSString *imageUrl = [CQTSNetImagesUtil cjts_imageUrlAtIndex:indexPath.item];
        [cell setupImageWithImageUrl:imageUrl];
    } else if (self.ripeImageSource == CQTSRipeImageSourceImageLocal) { // 本地图片
        UIImage *image = [CQTSLocImagesUtil cjts_localImageAtIndex:indexPath.item];
        [cell setupImageWithImage:image];
    } else if (self.ripeImageSource == CQTSRipeImageSourceIconNetwork) { // 网络icon
        NSString *imageUrl = [CQTSIconsUtil cjts_iconUrlAtIndex:indexPath.item];
        [cell setupImageWithImageUrl:imageUrl];
    } else {
        NSString *imageUrl = [CQTSNetImagesUtil cjts_imageUrlAtIndex:indexPath.item];
        [cell setupImageWithImageUrl:imageUrl];
    }
    
    // badge
    NSInteger badgeCount = indexPath.item;
    [cell setupBadgeCount:badgeCount withMaxNumber:9];
    
    !self.cellConfigBlock ?: self.cellConfigBlock(cell);
    
    return cell;
}


@end
