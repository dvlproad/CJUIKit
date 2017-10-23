//
//  CJOpenCollectionView.m
//  CJOpenCollectionViewDemo
//
//  Created by ciyouzen on 16/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJOpenCollectionView.h"


static NSString *const HeaderIdentifierDefault = @"HeaderDefault";


@interface CJOpenCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>{
    BOOL _isRegisterHead;
    
    CJOpenCollectionViewReusableViewConfigureBlock _configureHeaderBlock;
    CJOpenCollectionViewDetailCellConfigureBlock _configureCellBlock;
    CJOpenCollectionViewLineCellConfigureBlock _configureLineCellBlock;
}


@end



@implementation CJOpenCollectionView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self commonInit];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self commonInit];
    }
    return self;
}


/**
 *  collectionView默认的初始化函数
 */
- (void)commonInit {
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    
    [self registerClass:[CJLineCell class] forCellWithReuseIdentifier:LineCellIdentifier];//lineCell布局定制不开放，只开放lineCell属性设置
    
    _isRegisterHead = NO;
    [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderIdentifierDefault];
    
    self.dataSource = self;
    self.delegate = self;
}


/** 完整的描述请参见文件头部 */
- (void)configureCellBlock:(CJOpenCollectionViewDetailCellConfigureBlock)aCellBlock configureLineBlock:(CJOpenCollectionViewLineCellConfigureBlock)aLineBlock configureHeaderBlock:(CJOpenCollectionViewReusableViewConfigureBlock)aHeaderBlock {
    _configureCellBlock = aCellBlock;
    _configureLineCellBlock = aLineBlock;
    _configureHeaderBlock = aHeaderBlock;
}


- (void)registerClass:(Class)viewClass forSupplementaryViewOfKind:(NSString *)elementKind withReuseIdentifier:(NSString *)identifier{
    [super registerClass:viewClass forSupplementaryViewOfKind:elementKind withReuseIdentifier:identifier];
    if ([identifier isEqualToString:HeaderIdentifier]) {
        _isRegisterHead = YES;
    }
}

- (void)registerNib:(UINib *)nib forSupplementaryViewOfKind:(NSString *)kind withReuseIdentifier:(NSString *)identifier{
    [super registerNib:nib forSupplementaryViewOfKind:kind withReuseIdentifier:identifier];
    if ([identifier isEqualToString:HeaderIdentifier]) {
        _isRegisterHead = YES;
    }
}




- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.openDataSource cjOpenCollectionView_numberOfSectionsInCollectionView:self];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger detailCellCountShow = [self.openDataSource cjOpenCollectionView:self numberOfItemsInSection:section];
    if (detailCellCountShow > 0) {
        NSInteger allCellCountShow = self.shouldContainLineCell ? (detailCellCountShow+1) :detailCellCountShow;
        return allCellCountShow;
    }
    
    return 0;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader)
    {
        if (_isRegisterHead) {
            CJCollectionViewHeaderFooterView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderIdentifier forIndexPath:indexPath];
            header.belongToSection = indexPath.section;
            
            __weak typeof(self)weakSelf = self;
            [header setTapHandle:^(NSInteger section) {
                __strong __typeof(weakSelf)strongSelf = weakSelf;
                if (strongSelf) {
                    [strongSelf tapHeaderAtSection:section];
                }
            }];
            if (_configureHeaderBlock) {
                _configureHeaderBlock(header, indexPath);
            }
            reusableview = header;
        }else{
            CJCollectionViewHeaderFooterView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderIdentifierDefault forIndexPath:indexPath];
            reusableview = header;
        }
    }
    
    return reusableview;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger itemCount = [collectionView numberOfItemsInSection:indexPath.section];
    if (self.shouldContainLineCell && itemCount > 1 && indexPath.item == itemCount-1) {//LineCell
        CJLineCell *cell = (CJLineCell *)[collectionView dequeueReusableCellWithReuseIdentifier:LineCellIdentifier forIndexPath:indexPath];
        if (self.shouldHideLineCellAccordingToHeader) {
            cell.label.hidden = YES;
            cell.line.hidden = YES;
        }
        
        if (_configureLineCellBlock) {
            _configureLineCellBlock(cell, indexPath);
        }
        return cell;
    }else{ //DetailCell
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DetailCellIdentifier forIndexPath:indexPath];
        if (_configureCellBlock) {
            _configureCellBlock(cell, indexPath);
        }
        return cell;
    }
}


/**
 *  点击了第几个Header
 *
 *  @param section section
 */
- (void)tapHeaderAtSection:(NSInteger)section {
    /* 1、获取执行点击操作前和执行店家操作后cell的数量 */
    NSInteger beforeActionCellCount = [self.openDataSource cjOpenCollectionView:self numberOfItemsInSection:section];
    if (self.openDelegate && [self.openDelegate respondsToSelector:@selector(cjOpenCollectionView:didSelectHeaderInSection:)]) {
        [self.openDelegate cjOpenCollectionView:self didSelectHeaderInSection:section];
    }
    NSInteger afterActionCellCount = [self.openDataSource cjOpenCollectionView:self numberOfItemsInSection:section];
    //NSLog(@"before_after: %ld change to %ld", beforeActionCellCount, afterActionCellCount);
    
    //注意：下面的展开和收缩，使用的方法是插入和删除方法，而不是reload方法的目的是？
    /* 2、如果①点击前是0、点击后不是0，则代表展开，即应该新增插入那些cell，
            如果②点击前是0、点击后不是0，则代表展开，即应该删除那些cell，
            如果③是其他情况，则直接reloadSections*/
    if (beforeActionCellCount == 0 && afterActionCellCount != 0) {
        NSInteger allAfterActionCellCount = self.shouldContainLineCell ?
        (afterActionCellCount+ 1) : afterActionCellCount;
        NSMutableArray *indexPaths = [[NSMutableArray alloc]init];
        for (NSInteger item = 0 ; item < allAfterActionCellCount; item++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            [indexPaths addObject:indexPath];
        }
        
        [self performBatchUpdates:^{
            [self insertItemsAtIndexPaths:indexPaths];
        } completion:nil];
        
    }else if (beforeActionCellCount != 0 && afterActionCellCount == 0) {
        NSInteger allBeforeActionCellCount = self.shouldContainLineCell ?
        (beforeActionCellCount + 1) : beforeActionCellCount;
        NSMutableArray *indexPaths = [[NSMutableArray alloc]init];
        for (NSInteger item = 0 ; item < allBeforeActionCellCount; item++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            [indexPaths addObject:indexPath];
        }
        
        [self performBatchUpdates:^{
            [self deleteItemsAtIndexPaths:indexPaths];
        } completion:nil];
        
    }else{
        [self reloadSections:[NSIndexSet indexSetWithIndex:section]];
        
    }
    
    [self scrollViewDidScroll:self];//增加一行滚动操作,防止文字没滚回来
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.openDelegate && [self.openDelegate respondsToSelector:@selector(cjOpenCollectionView:didSelectItemAtIndexPath:)]) {
        [self.openDelegate cjOpenCollectionView:self didSelectItemAtIndexPath:indexPath];
    }
}


/**
 *  处理collectionView移动及移动过程中文字位置及是否隐藏的事件
 *
 *  @param scrollView The scrollView requesting this information.
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.shouldContainLineCell) {
        
        [self moveCategoryTextInIndexPathsVisible:[(UICollectionView *)scrollView indexPathsForVisibleItems]];/** 文字的移动 */
        
        if (self.shouldHideLineCellAccordingToHeader) {
            [self hideCategoryTextInIndexPathsVisible:[(UICollectionView *)scrollView indexPathsForVisibleItems]]; /** 文字的隐藏 */
        }
    }
}


/**
 *  处理文字的移动
 *
 *  @param indexPathsVisible The indexPathsVisible requesting this information.
 */
- (void)moveCategoryTextInIndexPathsVisible:(NSArray <NSIndexPath *>*)indexPathsVisible {
    NSMutableArray *visibleSectionArray = [NSMutableArray arrayWithCapacity:0];
    for (NSIndexPath *indexPath in indexPathsVisible) {
        if (![visibleSectionArray containsObject:[NSNumber numberWithInteger:indexPath.section]]) {
            [visibleSectionArray addObject:[NSNumber numberWithInteger:indexPath.section]];
        }
    }
    
    for (NSNumber *numVisibleSection in visibleSectionArray) {
        NSInteger section = [numVisibleSection integerValue];
        NSInteger itemCount = [self numberOfItemsInSection:section];
        if (itemCount > 0) { //if itemCount > 0, mean this section is unfold
            CJLineCell *lineCell = (CJLineCell *)[self cellForItemAtIndexPath:[NSIndexPath indexPathForItem:itemCount-1 inSection:section]];
            
            /** 滑动的距离到达了文字的位置 */
            if (self.contentOffset.x > lineCell.frame.origin.x + lineCell.frame.size.width/2 - lineCell.label.frame.size.width/2) {
                CGRect frame = lineCell.label.frame;
                frame.origin.x = self.contentOffset.x-lineCell.frame.origin.x;
                lineCell.label.frame = frame;
                
                /** 甚至把文字顶到尾部的时候 */
                CGFloat distance = 10;
                CGFloat width = CGRectGetWidth(lineCell.frame) - distance;
                if(self.contentOffset.x > lineCell.frame.origin.x + width - lineCell.label.frame.size.width) {
                    CGRect frame = lineCell.label.frame;
                    frame.origin.x = width - lineCell.label.frame.size.width;
                    lineCell.label.frame = frame;
                }
            }else{/** 滑动的距离未到达了文字的位置 */
                CGRect frame = lineCell.label.frame;
                frame.origin.x = lineCell.frame.size.width/2-lineCell.label.frame.size.width/2;
                lineCell.label.frame = frame;
            }
        }
    }
}


/**
 *  处理文字的隐藏
 *
 *  @param indexPathsVisible The indexPathsVisible requesting this information.
 */
- (void)hideCategoryTextInIndexPathsVisible:(NSArray <NSIndexPath *>*)indexPathsVisible {
    NSMutableArray *visibleSectionArray = [NSMutableArray arrayWithCapacity:0];
    for (NSIndexPath *indexPath in indexPathsVisible) {
        if (![visibleSectionArray containsObject:[NSNumber numberWithInteger:indexPath.section]]) {
            [visibleSectionArray addObject:[NSNumber numberWithInteger:indexPath.section]];
        }
    }
    
    for (NSNumber *numVisibleSection in visibleSectionArray) {
        NSInteger section = [numVisibleSection integerValue];
        NSInteger itemCount = [self numberOfItemsInSection:section];
        if (itemCount > 0) { //if itemCount > 0, mean this section is unfold
            CJCollectionViewHeaderFooterView *header = (CJCollectionViewHeaderFooterView *)[self supplementaryViewForElementKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
            
            
            CJLineCell *lineCell = (CJLineCell *)[self cellForItemAtIndexPath:[NSIndexPath indexPathForItem:itemCount-1 inSection:section]];
            if (self.contentOffset.x > header.center.x) {
                lineCell.label.hidden = NO;
                lineCell.line.hidden = NO;
            }else{
                lineCell.label.hidden = YES;
                lineCell.line.hidden = YES;
            }
        }
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
