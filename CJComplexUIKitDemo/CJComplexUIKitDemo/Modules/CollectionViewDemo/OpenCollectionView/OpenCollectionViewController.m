//
//  OpenCollectionViewController.m
//  CJCollectionViewDemo
//
//  Created by ciyouzen on 16/3/10.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "OpenCollectionViewController.h"

#import "TestDataUtil.h"

@interface OpenCollectionViewController () <CJOpenCollectionViewDelegate>

@end

@implementation OpenCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = NSLocalizedString(@"OpenCollectionViewController", nil);
    self.automaticallyAdjustsScrollViewInsets = NO; //if the collectionView is the first view, should add this line

    TSOpenCollectionView *collectionView = [[TSOpenCollectionView alloc] init];
    /** 设置数据源和委托 */
   collectionView.openDelegate = self;
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(20);
        make.bottom.mas_equalTo(self.view).mas_offset(-75);
        make.height.mas_equalTo(135);
    }];
    _collectionView = collectionView;
    
    _datas = [TestDataUtil getTestSectionDataModels];
    _collectionView.datas = _datas;
}

#pragma mark - CJOpenCollectionViewDelegate
- (void)cjOpenCollectionView:(CJOpenCollectionView *)collectionView didSelectHeaderInSection:(NSInteger)section {
    NSLog(@"Header %zd", section);
    CJSectionDataModel *secctionModel = [_datas objectAtIndex:section];
    secctionModel.selected = !secctionModel.isSelected;
}

- (void)cjOpenCollectionView:(CJOpenCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Cell:%zd, %zd", indexPath.section, indexPath.row);
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
