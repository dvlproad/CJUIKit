//
//  LEWorkHomeViewController.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/5/20.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "LEWorkHomeViewController.h"

#import "TestDataUtil.h"

#import "LECollectionView.h"

@interface LEWorkHomeViewController () <UICollectionViewDelegate> {
    
}
@property (nonatomic, strong) LECollectionView *collectionView;

@end

@implementation LEWorkHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工作";
    
    [self setupViews];
    
    NSMutableArray *sectionDataModels = [TestDataUtil getTestSectionDataModels];
    self.collectionView.menuSectionDataModels = sectionDataModels;
    
    [self.collectionView reloadData];
}

- (void)setupViews {
    [self.view addSubview: self.collectionView];

    CGFloat UI_NAVIGATION_STATUS_BAR_HEIGHT = 120;
    CGFloat Bottom_Tabbar_Size_Height = 64;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(UI_NAVIGATION_STATUS_BAR_HEIGHT);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-Bottom_Tabbar_Size_Height);
    }];
}



#pragma mark - lazy init
@synthesize collectionView = _collectionView;
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[LECollectionView alloc] init];
    }
    return _collectionView;
}

@end
