//
//  averageWidthCollectionViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 8/10/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "LookBadgeCollectionViewController.h"

#import <CJMenuListKit/CQFilesLookBadgeCollectionView.h>

#import "TSToast.h"

#import "TSListDataSourceUtil.h"

@interface LookBadgeCollectionViewController () {
    
}
@property (nonatomic, strong) CQFilesLookBadgeCollectionView *equalCellSizeCollectionView;

@end

@implementation LookBadgeCollectionViewController

- (BOOL)automaticallyAdjustsScrollViewInsets {
    return NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CQFilesLookBadgeCollectionView *collectionView = [[CQFilesLookBadgeCollectionView alloc] initWithDidTapShowingItemBlock:^(UICollectionView *collectionView, NSIndexPath *indexPath, CQFilesLookBadgeDataModel *dataModel) {
        NSString *message = [NSString stringWithFormat:@"点击了【%@】", dataModel.name];
        [TSToast showMessage:message];
    }];
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(120);
        make.left.mas_equalTo(self.view).mas_offset(15);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(260);
    }];
    self.equalCellSizeCollectionView = collectionView;
    
    
    self.equalCellSizeCollectionView.dataModels = [TSListDataSourceUtil __getTestLookBadgeDataModels];
    [self.equalCellSizeCollectionView reloadData];
    
    CGFloat collectionViewHeight = [collectionView heightByScreenMarginLeft:15 screenMarginRight:15];
    [collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(collectionViewHeight);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
