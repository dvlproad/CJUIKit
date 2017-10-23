//
//  CJOpenCollectionView.h
//  CJOpenCollectionViewDemo
//
//  Created by ciyouzen on 16/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CJCollectionViewHeaderFooterView.h"
#import "CJLineCell.h"

static NSString *const HeaderIdentifier = @"Header";
static NSString *const DetailCellIdentifier = @"DetailCell";
static NSString *const LineCellIdentifier = @"LineCell";


@class CJLineCell;
@class CJCollectionViewHeaderFooterView;
typedef void (^CJOpenCollectionViewDetailCellConfigureBlock)(id cell, NSIndexPath *indexPath);
typedef void (^CJOpenCollectionViewLineCellConfigureBlock)(CJLineCell *lineCell, NSIndexPath *indexPath);
typedef void (^CJOpenCollectionViewReusableViewConfigureBlock)(CJCollectionViewHeaderFooterView *header, NSIndexPath *indexPath);



@class CJOpenCollectionView;
@protocol CJOpenCollectionViewDelegate <NSObject>

/**
 *  点击Header事件
 *
 *  @param collectionView The collection view object that is notifying you of the selection change.
 *  @param section        The section of the reusableView that was selected.
 */
- (void)cjOpenCollectionView:(CJOpenCollectionView *)collectionView didSelectHeaderInSection:(NSInteger)section;

/**
 *  点击Item事件
 *
 *  @param collectionView The collection view object that is notifying you of the selection change.
 *  @param indexPath      The index path of the cell that was selected.
 */
- (void)cjOpenCollectionView:(CJOpenCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;


@end




@protocol CJOpenCollectionViewDataSource <NSObject>
@required
/**
 *  指定section的个数
 *
 *  @param collectionView The collection view requesting this information.
 *
 *  @return The number of sections in collectionView.
 */
- (NSInteger)cjOpenCollectionView_numberOfSectionsInCollectionView:(CJOpenCollectionView *)collectionView;

/**
 *  指定section下对应的item的个数
 *
 *  @param collectionView The collection view requesting this information.
 *  @param section        An index number identifying a section in collectionView. This index value is 0-based.
 *
 *  @return The number of rows in section.
 */
- (NSInteger)cjOpenCollectionView:(CJOpenCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;

@end




/**
 *  自定义的CJOpenCollectionView类
 */
@interface CJOpenCollectionView : UICollectionView

@property (nonatomic, assign) id <CJOpenCollectionViewDataSource> openDataSource;
@property (nonatomic, assign) id <CJOpenCollectionViewDelegate> openDelegate;

@property (nonatomic, assign) BOOL shouldContainLineCell;  //是否包含LineCell
@property (nonatomic, assign) BOOL shouldHideLineCellAccordingToHeader; //是否根据Header隐藏LineCell

/**
 *  对Item、Line、Header进行定制的block
 *
 *  @param aCellBlock   对Item进行定制的block
 *  @param aLineBlock   对Line进行定制的block
 *  @param aHeaderBlock 对Header进行定制的block
 */
- (void)configureCellBlock:(CJOpenCollectionViewDetailCellConfigureBlock)aCellBlock
        configureLineBlock:(CJOpenCollectionViewLineCellConfigureBlock)aLineBlock
      configureHeaderBlock:(CJOpenCollectionViewReusableViewConfigureBlock)aHeaderBlock;

@end
