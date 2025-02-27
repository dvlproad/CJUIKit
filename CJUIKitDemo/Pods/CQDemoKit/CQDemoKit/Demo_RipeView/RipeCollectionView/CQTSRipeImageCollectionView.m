//
//  CQTSRipeImageCollectionView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 8/10/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CQTSRipeImageCollectionView.h"
#import "CQTSRipeImageCollectionViewCell.h"
#import "CQTSLocImagesUtil.h"
#import "CQTSNetImagesUtil.h"
#import "CQTSIconsUtil.h"

#import "CQTSRipeBaseCollectionViewDelegate.h"

#import "CQTSRipeSectionDataUtil.h"

@interface CQTSRipeImageCollectionView () <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource> {
    
}
@property (nonatomic, assign, readonly) CGFloat perMaxCount;   /**< 每行/每列个数 */

@property (nonatomic, strong, readonly) NSArray<NSNumber *> *sectionRowCounts;  /**< 每个section的rowCount个数 */
@property (nonatomic, assign, readonly) CQTSRipeImageSource ripeImageSource;   /**< 数据源(有网络图片、本地图片、网络icon) */
@property (nonatomic, strong, readonly) CQTSRipeBaseCollectionViewDelegate *ripeCollectionViewDelegate;   /**< collectionView的delegate */


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
        
        
        __weak typeof(self) weakSelf = self;
        _ripeCollectionViewDelegate = [[CQTSRipeBaseCollectionViewDelegate alloc] initWithPerMaxCount:perMaxCount didSelectItemHandle:^(UICollectionView * _Nonnull bCollectionView, NSIndexPath * _Nonnull indexPath) {
            
        }];
        self.delegate = self.ripeCollectionViewDelegate;
        
        
        self.dataSource = self;
        
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
    NSString *title = [NSString stringWithFormat:@"%zd-%zd", indexPath.section, indexPath.row];
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
