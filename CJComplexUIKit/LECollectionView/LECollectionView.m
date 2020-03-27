//
//  LECollectionView.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2020/3/26.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "LECollectionView.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import "LEMenuCollectionViewCell.h"

#import "CJHomeAdCollectionViewCell.h"
#import "LECollectionHeader.h"

#import "CJCollectionViewFlowLayout.h"

@interface LECollectionView () <UICollectionViewDelegate, UICollectionViewDataSource, CJCollectionViewDelegateFlowLayout> {
    
}
@property (nonatomic, strong) CJCollectionViewFlowLayout *layout;

@property (nonatomic, copy) void(^_Nullable clickHomeAdHandle)(NSInteger adIndex);
@property (nonatomic, copy) void(^_Nullable clickHomeMenuHandle)(NSIndexPath *menuIndexPath);

@end


@implementation LECollectionView

- (instancetype)init {
    self = [super initWithFrame:CGRectZero collectionViewLayout:self.layout];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0]; //#f4f4f4;
        
        //注册cell
        [self registerClass:[CJHomeAdCollectionViewCell class] forCellWithReuseIdentifier:@"CJHomeAdCollectionViewCell"];
        [self registerClass:[LECollectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LECollectionHeader"];
        
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (void)configClickHomeAdHandle:(void(^ _Nullable)(NSInteger adIndex))clickHomeAdHandle
            clickHomeMenuHandle:(void(^ _Nullable)(NSIndexPath *menuIndexPath))clickHomeMenuHandle
{
    _clickHomeAdHandle = clickHomeAdHandle;
    _clickHomeMenuHandle = clickHomeMenuHandle;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSInteger menuSectionCount = 0;
//    if (self.menuList.count > 0) {
        NSArray *sectionDataModels = self.menuSectionDataModels;
        menuSectionCount = sectionDataModels.count;
//    }
    return 1 + menuSectionCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (0 == section) {
        return 1;
    }
    else {
        NSArray *sectionDataModels = self.menuSectionDataModels;
        CJSectionDataModel *sectionDataModel = [sectionDataModels objectAtIndex:section-1];
        NSMutableArray *dataModels = sectionDataModel.values;
        
        return dataModels.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (0 == indexPath.section) {
        static NSString * cellName = @"CJHomeAdCollectionViewCell";
        CJHomeAdCollectionViewCell *cell = (CJHomeAdCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellName forIndexPath:indexPath];
        cell.adDataModels = self.adDataModels;
        
        return cell;
    }
    else {
        NSString *cellName = [NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];
        //注册cell
        [collectionView registerClass:[LEMenuCollectionViewCell class] forCellWithReuseIdentifier:cellName];
        
        //static NSString * cellName = @"LEMenuCollectionViewCell";
        LEMenuCollectionViewCell *cell =
            (LEMenuCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellName forIndexPath:indexPath];
        
        NSArray *sectionDataModels = self.menuSectionDataModels;
        CJSectionDataModel *sectionDataModel = [sectionDataModels objectAtIndex:indexPath.section-1];
        NSMutableArray *dataModels = sectionDataModel.values;
        CJHomeMenuDataModel *dataModel = dataModels[indexPath.row];
        
        [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:dataModel.imageUrl] placeholderImage:dataModel.imagePlaceholderImage];
        cell.titleNameLabel.text = dataModel.name;
        [cell displayMessageWithCount:dataModel.badgeCount];
        
        return cell;
    }
    
}

#pragma mark - UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    //
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //点击事件
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (0 == indexPath.section) {
        NSInteger adIndex = 0;
        if (self.clickHomeAdHandle) {
            self.clickHomeAdHandle(adIndex);
        }
    } else {
        NSIndexPath *menuIndexPath = [NSIndexPath indexPathForItem:indexPath.item inSection:indexPath.section-1];
        if (self.clickHomeMenuHandle) {
            self.clickHomeMenuHandle(menuIndexPath);
        }
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != 0){
        LECollectionHeader *reusableview = [[LECollectionHeader alloc] init];
        if (kind == UICollectionElementKindSectionHeader) {
            reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"LECollectionHeader" forIndexPath:indexPath];
            
            CJSectionDataModel *sectionDataModel = [self.menuSectionDataModels objectAtIndex:indexPath.section-1];
            
            reusableview.titleNameLabel.text = sectionDataModel.theme;
            dispatch_async(dispatch_get_main_queue(), ^{
                reusableview.layer.zPosition = -10;
            });
        }
        return reusableview;
    }
    else {
        return nil;
    }
}



#pragma mark - UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView
                 layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    if (section != 0) {
        return CGSizeMake(screenWidth, 46.0f);
    }
    else {
        return CGSizeMake(0, 0);
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView
                 layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    if (0 == indexPath.section) {
        return CGSizeMake(screenWidth, 218);
    }
    else {
        CGFloat width = (screenWidth) / 4;
        CGFloat height = 87;
        return CGSizeMake(width, height);
    }
    
}

//item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//设置UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (0 == section) {
        return UIEdgeInsetsMake(0, 0, 10, 0);
    }
    else {
       return UIEdgeInsetsMake(0, 0, 10, 0);
    }
}

- (UIColor *)collectionView:(UICollectionView *)collectionView
                     layout:(UICollectionViewLayout *)collectionViewLayout backgroundColorForSection:(NSInteger)section {
    return [UIColor whiteColor];
}



#pragma mark - lazy init
@synthesize layout = _layout;
- (CJCollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout  = [[CJCollectionViewFlowLayout alloc] init];
        [_layout setScrollDirection:UICollectionViewScrollDirectionVertical];//设置对齐方式
    }
    return _layout;
}

@end
