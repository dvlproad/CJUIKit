//
//  LEWorkHomeViewController.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/5/20.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "LEWorkHomeViewController.h"
#import <CJBaseUIKit/UIColor+CJHex.h>
#import <SDWebImage/UIImageView+WebCache.h>

#import "LEMenuCollectionViewCell.h"

#import "LEBannerCollectionViewCell.h"
#import "LECollectionHeader.h"

#import "LECollectionViewFlowLayout.h"

#import "TestDataUtil.h"

@interface LEWorkHomeViewController () <UICollectionViewDelegate, UICollectionViewDataSource, LECollectionViewDelegateFlowLayout> {
    
}
@property (nonatomic, strong) LECollectionViewFlowLayout *layout;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation LEWorkHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工作";
    
    [self setupViews];
    
    NSMutableArray *sectionDataModels = [TestDataUtil getTestSectionDataModels];
    self.menuSectionDataModels = sectionDataModels;
    
    [self.collectionView reloadData];
}

- (void)setupViews {
    [self.view addSubview: self.collectionView];
    //注册cell
    [self.collectionView registerClass:[LEBannerCollectionViewCell class] forCellWithReuseIdentifier:@"LEBannerCollectionViewCell"];
    [self.collectionView registerClass:[LECollectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LECollectionHeader"];

    CGFloat UI_NAVIGATION_STATUS_BAR_HEIGHT = 120;
    CGFloat Bottom_Tabbar_Size_Height = 64;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(UI_NAVIGATION_STATUS_BAR_HEIGHT);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-Bottom_Tabbar_Size_Height);
    }];
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
        static NSString * cellName = @"LEBannerCollectionViewCell";
        LEBannerCollectionViewCell *cell = (LEBannerCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellName forIndexPath:indexPath];
        LEADPosModelList *list = [[LEADPosModelList alloc] init];
        [cell setValueCellWithModel:list];
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
        TestDataModel *dataModel = dataModels[indexPath.row];
        
        [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3407848463,1025443640&fm=26&gp=0.jpg"] placeholderImage:[UIImage imageNamed:@"replenish_icon"]];
        cell.titleNameLabel.text = @"健康证";
        [cell displayMessageWithCount:66];
        
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
        
    } else {
        CJSectionDataModel *sectionDataModel = [self.menuSectionDataModels objectAtIndex:indexPath.section-1];
        NSMutableArray *dataModels = sectionDataModel.values;
        TestDataModel *dataModel = dataModels[indexPath.row];
        NSLog(@"首页点击菜单，启动 URL: %@", dataModel.imagePath);
//        [self.viewModel clickBottomItem:menu]; //TODO:
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
        CGFloat height = LEWorkFunctionItemCellHeight;
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
- (LECollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout  = [[LECollectionViewFlowLayout alloc] init];
        [_layout setScrollDirection:UICollectionViewScrollDirectionVertical];//设置对齐方式
    }
    return _layout;
}

@synthesize collectionView = _collectionView;
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.backgroundColor = CJColorFromHexString(@"#F4F4F4");
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

@end
