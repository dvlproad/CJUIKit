//
//  CQTSRipeButtonCollectionView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 8/10/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CQTSRipeButtonCollectionView.h"
#import "CQTSLocImagesUtil.h"
#import "CQTSRipeBaseCollectionViewDelegate.h"
#import "CQTSRipeBaseCollectionViewDataSource.h"

#import "CQTSRipeButtonCollectionViewCell.h"
#import "CQTSRipeSectionDataUtil.h"

@interface CQTSRipeButtonCollectionView () {
    
}
@property (nonatomic, strong) NSMutableArray<NSString *> *buttonTitles;
@property (nullable, nonatomic, copy, readonly) void(^didSelectItemAtIndexHandle)(NSInteger index); /**< 点击item的回调 */

@property (nonatomic, strong, readonly) CQTSRipeBaseCollectionViewDelegate *ripeCollectionViewDelegate;   /**< collectionView的delegate */
@property (nonatomic, strong, readonly) CQTSRipeBaseCollectionViewDataSource *ripeCollectionViewDataSource;   /**< collectionView的dataSource */

@end


@implementation CQTSRipeButtonCollectionView

#pragma mark - Init
/*
 *  初始化 单行或单列的CollectionView
 *
 *  @param buttonTitles                 按钮的标题数组
 *  @param perMaxCount                  当滚动方向为①水平时,每列显示几个；②竖直时,每行显示几个；
 *  @param widthHeightRatio             宽高比（一般为1.0）
 *  @param scrollDirection              集合视图的滚动方向
 *  @param didSelectItemAtIndexHandle   点击item的回调
 *
 *  @return CollectionView
 */
- (instancetype)initWithTitles:(NSArray<NSString *> *)buttonTitles
                   perMaxCount:(NSInteger)perMaxCount
              widthHeightRatio:(CGFloat)widthHeightRatio
               scrollDirection:(UICollectionViewScrollDirection)scrollDirection
    didSelectItemAtIndexHandle:(void(^)(NSInteger index))didSelectItemAtIndexHandle
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = scrollDirection;
    self = [super initWithFrame:CGRectZero collectionViewLayout:layout];
    if (self) {
        __weak typeof(self) weakSelf = self;
        _ripeCollectionViewDelegate = [[CQTSRipeBaseCollectionViewDelegate alloc] initWithPerMaxCount:perMaxCount widthHeightRatio:widthHeightRatio didSelectItemHandle:^(UICollectionView * _Nonnull bCollectionView, NSIndexPath * _Nonnull bIndexPath) {
            !didSelectItemAtIndexHandle ?: didSelectItemAtIndexHandle(bIndexPath.item);
        }];
        self.delegate = self.ripeCollectionViewDelegate;
        
        NSMutableArray<CQDMSectionDataModel *> *sectionDataModels = [CQTSRipeSectionDataUtil sectionModelsWithTitles:buttonTitles];
        _ripeCollectionViewDataSource = [[CQTSRipeBaseCollectionViewDataSource alloc] initWithSectionDataModels:sectionDataModels registerHandler:^{
            [weakSelf registerClass:[CQTSRipeButtonCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
            
        } cellForItemAtIndexPath:^UICollectionViewCell * _Nonnull(UICollectionView * _Nonnull bCollectionView, NSIndexPath * _Nonnull bIndexPath, CQTSLocImageDataModel * _Nonnull dataModel) {
            CQTSRipeButtonCollectionViewCell *cell = [bCollectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:bIndexPath];
            
            NSString *title = buttonTitles[bIndexPath.item];
            cell.text = title;
            //cell.text = [NSString stringWithFormat:@"%zd", bIndexPath.item];
            
            !weakSelf.cellConfigBlock ?: weakSelf.cellConfigBlock(cell);
            
            return cell;
        }];
        self.dataSource = self.ripeCollectionViewDataSource;
        
    }
    return self;
}


@end
