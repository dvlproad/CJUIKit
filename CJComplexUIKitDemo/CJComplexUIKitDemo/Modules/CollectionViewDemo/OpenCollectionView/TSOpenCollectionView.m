//
//  TSOpenCollectionView.m
//  CJComplexUIKitDemo
//
//  Created by 李超前 on 2020/3/25.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "TSOpenCollectionView.h"
#import <CJComplexUIKit/CJHeadAndCellHorizontalLayout.h>
#import "Header.h"
#import "DetailCell.h"

@interface TSOpenCollectionView () <CJOpenCollectionViewDataSource> {
    
}

@end


@implementation TSOpenCollectionView

- (instancetype)init {
    UICollectionViewLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self = [super initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.backgroundColor = [UIColor redColor];
    
    /** 为collectionView初始化layout */
    CJHeadAndCellHorizontalLayout *layout = [[CJHeadAndCellHorizontalLayout alloc] init];
    layout.headerReferenceSize = CGSizeMake(110, 135);
    layout.itemSize = CGSizeMake(60, 60);
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    layout.lineHeight = 20;
    [self setCollectionViewLayout:layout];
    
    /** 为CJCollectionView注册CJCollectionViewHeaderFooterView(可选) */
    UINib *nib_header = [UINib nibWithNibName:@"Header" bundle:nil];
    [self registerNib:nib_header forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderIdentifier];
    //注意：注册的Header必须是CJCollectionViewHeaderFooterView的子类，且其属性中的Button不能为空
    
    /** 为CJCollectionView注册自定义的Cell */
    UINib *nib_detailCell = [UINib nibWithNibName:@"DetailCell" bundle:nil];
    [self registerNib:nib_detailCell forCellWithReuseIdentifier:DetailCellIdentifier];
    
    /** 设置数据源和委托 */
//    self.openDelegate = self;
    self.openDataSource = self;
    
    /** 设置某些属性(可选) */
    self.shouldContainLineCell = YES;
    self.shouldHideLineCellAccordingToHeader = YES;
    
    /** 设置对应indexPaht上Cell、Line、Header的属性值 */
    __weak typeof(self)weakSelf = self;
    [self configureCellBlock:^(id cell, NSIndexPath *indexPath) {
        CJSectionDataModel *secctionModel = [weakSelf.datas objectAtIndex:indexPath.section];
        TestDataModel *cellModel = (TestDataModel *)[secctionModel.values objectAtIndex:indexPath.item];
        
        DetailCell *m_cell = (DetailCell *)cell;
        m_cell.labDetail.text = cellModel.name;
        
    } configureLineBlock:^(CJLineCell *lineCell, NSIndexPath *indexPath) {
        CJSectionDataModel *secctionModel = [weakSelf.datas objectAtIndex:indexPath.section];
        lineCell.label.text = secctionModel.theme;
        lineCell.label.font = [UIFont systemFontOfSize:28];
        
    } configureHeaderBlock:^(CJCollectionViewHeaderFooterView *header, NSIndexPath *indexPath) {
        CJSectionDataModel *secctionModel = [weakSelf.datas objectAtIndex:indexPath.section];
        
        Header *m_header = (Header *)header;
        m_header.labTheme.text = secctionModel.theme;
    }];
}




#pragma mark - CJOpenCollectionViewDataSource
- (NSInteger)cjOpenCollectionView_numberOfSectionsInCollectionView:(CJOpenCollectionView *)collectionView {
    return [_datas count];
}

- (NSInteger)cjOpenCollectionView:(CJOpenCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    CJSectionDataModel *secctionModel = [_datas objectAtIndex:section];
    if (secctionModel.isSelected) {
        return secctionModel.values.count;
    }
    return 0;
}

/*
#pragma mark - CJOpenCollectionViewDelegate
- (void)cjOpenCollectionView:(CJOpenCollectionView *)collectionView didSelectHeaderInSection:(NSInteger)section {
    NSLog(@"Header %zd", section);
    CJSectionDataModel *secctionModel = [_datas objectAtIndex:section];
    secctionModel.selected = !secctionModel.isSelected;
}

- (void)cjOpenCollectionView:(CJOpenCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Cell:%zd, %zd", indexPath.section, indexPath.row);
}
*/

    

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
