//
//  OpenCollectionViewController.m
//  CJCollectionViewDemo
//
//  Created by ciyouzen on 16/3/10.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "OpenCollectionViewController.h"

#import "Header.h"
#import "DetailCell.h"

#import "TestDataUtil.h"

@interface OpenCollectionViewController ()<CJOpenCollectionViewDataSource, CJOpenCollectionViewDelegate>

@end

@implementation OpenCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = NSLocalizedString(@"OpenCollectionViewController", nil);
    self.automaticallyAdjustsScrollViewInsets = NO; //if the collectionView is the first view, should add this line
    
    _datas = [TestDataUtil getTestSectionDataModels];
    
    
    /** 为collectionView初始化layout */
    CJHeadAndCellHorizontalLayout *layout = [[CJHeadAndCellHorizontalLayout alloc] init];
    layout.headerReferenceSize = CGSizeMake(110, 135);
    layout.itemSize = CGSizeMake(60, 60);
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    layout.lineHeight = 20;
    [_collectionView setCollectionViewLayout:layout];
    
    /** 为CJCollectionView注册CJCollectionViewHeaderFooterView(可选) */
    UINib *nib_header = [UINib nibWithNibName:@"Header" bundle:nil];
    [_collectionView registerNib:nib_header forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderIdentifier];
    //注意：注册的Header必须是CJCollectionViewHeaderFooterView的子类，且其属性中的Button不能为空
    
    /** 为CJCollectionView注册自定义的Cell */
    UINib *nib_detailCell = [UINib nibWithNibName:@"DetailCell" bundle:nil];
    [_collectionView registerNib:nib_detailCell forCellWithReuseIdentifier:DetailCellIdentifier];
    
    /** 设置数据源和委托 */
    _collectionView.openDelegate = self;
    _collectionView.openDataSource = self;
    
    /** 设置某些属性(可选) */
    _collectionView.shouldContainLineCell = YES;
    _collectionView.shouldHideLineCellAccordingToHeader = YES;
    
    /** 设置对应indexPaht上Cell、Line、Header的属性值 */
    [_collectionView configureCellBlock:^(id cell, NSIndexPath *indexPath) {
        MySectionModel *secctionModel = [_datas objectAtIndex:indexPath.section];
        TestDataModel *cellModel = (TestDataModel *)[secctionModel.values objectAtIndex:indexPath.item];
        
        DetailCell *m_cell = (DetailCell *)cell;
        m_cell.labDetail.text = cellModel.name;
        
    } configureLineBlock:^(CJLineCell *lineCell, NSIndexPath *indexPath) {
        MySectionModel *secctionModel = [_datas objectAtIndex:indexPath.section];
        lineCell.label.text = secctionModel.theme;
        lineCell.label.font = [UIFont systemFontOfSize:28];
        
    } configureHeaderBlock:^(CJCollectionViewHeaderFooterView *header, NSIndexPath *indexPath) {
        MySectionModel *secctionModel = [_datas objectAtIndex:indexPath.section];
        
        Header *m_header = (Header *)header;
        m_header.labTheme.text = secctionModel.theme;
    }];
}




#pragma mark - CJOpenCollectionViewDataSource
- (NSInteger)cjOpenCollectionView_numberOfSectionsInCollectionView:(CJOpenCollectionView *)collectionView {
    return [_datas count];
}

- (NSInteger)cjOpenCollectionView:(CJOpenCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    MySectionModel *secctionModel = [_datas objectAtIndex:section];
    if (secctionModel.isSelected) {
        return secctionModel.values.count;
    }
    return 0;
}


#pragma mark - CJOpenCollectionViewDelegate
- (void)cjOpenCollectionView:(CJOpenCollectionView *)collectionView didSelectHeaderInSection:(NSInteger)section {
    NSLog(@"Header %ld", section);
    MySectionModel *secctionModel = [_datas objectAtIndex:section];
    secctionModel.selected = !secctionModel.isSelected;
}

- (void)cjOpenCollectionView:(CJOpenCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Cell:%ld, %ld", indexPath.section, indexPath.row);
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
