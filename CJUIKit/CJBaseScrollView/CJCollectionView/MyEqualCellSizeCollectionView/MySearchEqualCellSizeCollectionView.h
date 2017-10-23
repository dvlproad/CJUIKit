//
//  MySearchEqualCellSizeCollectionView.h
//  AllScrollViewDemo
//
//  Created by ciyouzen on 2016/4/10.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyEqualCellSizeCollectionView.h"

#import <CJBaseUtil/CJSectionDataModel.h> //在CJSearchUtil中


typedef UICollectionViewCell* (^CJConfigureCollectionViewCellBlock)(UICollectionView *collectionView, NSIndexPath *indexPath);

/**
 *  一个集成了搜索功能的EqualCellSizeCollectionView
 */
@interface MySearchEqualCellSizeCollectionView : MyEqualCellSizeCollectionView {
    
}
//必须设置的值
@property (nonatomic, copy) CJConfigureCollectionViewCellBlock configureCellBlock;

@property (nonatomic, strong) NSMutableArray<CJSectionDataModel *> *originSectionDataModels;        /**< 原始数据源 */
@property (nonatomic, strong) NSMutableArray<CJSectionDataModel *> *resultSectionDataModels;        /**< 搜索结果数组 */

//@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, assign, readonly) BOOL isSearching;
@property (nonatomic, copy) NSMutableArray<CJSectionDataModel *> * (^searchOperationBlock)(NSString *searchText); /**< 搜索方法 */

@property (nonatomic, strong) NSOperationQueue *searchOperationQueue;

//可选设置
@property (nonatomic, copy) void (^searchBarBecomeFirstResponderBlock)(void);
@property (nonatomic, copy) void (^searchBarResignFirstResponderBlock)(void);
@property (nonatomic, copy) void (^searchBarSelectedScopeButtonIndexDidChangeBlock)(NSInteger selectedScope);
@property (nonatomic, copy) void (^searchResultShowBlock)(void);

/**
 *  获取indexPath位置的dataModel(从数据源中获取每个indexPath要用什么dataModel来赋值)
 *
 *  @param indexPath                    indexPath
 *
 *  @return indexPath位置的dataModel
 */
- (id)getDataModelAtIndexPath:(NSIndexPath *)indexPath;


@end
