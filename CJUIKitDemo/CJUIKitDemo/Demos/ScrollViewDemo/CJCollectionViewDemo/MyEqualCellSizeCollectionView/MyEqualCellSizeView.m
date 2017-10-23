//
//  MyEqualCellSizeView.m
//  CJUIKitDemo
//
//  Created by lichaoqian on 2017/9/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "MyEqualCellSizeView.h"
#import "CJFullBottomCollectionViewCell.h"

@interface MyEqualCellSizeView () <UICollectionViewDataSource>

@end


@implementation MyEqualCellSizeView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self commonInit];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}


- (void)commonInit {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    label.text = @"测试";
    [self addSubview:label];
    
    self.equalCellSizeCollectionView = [[MyEqualCellSizeCollectionView alloc] init];
    self.equalCellSizeCollectionView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.equalCellSizeCollectionView];
    [self.equalCellSizeCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(20);
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
    
    [self setupEuqalCellSizeCollectionView];
}


- (void)setupEuqalCellSizeCollectionView {
    NSArray *array = @[@"1", @"2", @"3", @"4", @"5",
                       @"6", @"7", @"8", @"9", @"10",
                       @"11", @"12", @"13", @"14", @"15",
                       @"16", @"17", @"18", @"19", @"20",
                       @"21", @"22", @"23", @"24", @"25",
                       ];
    self.dataModels = [NSMutableArray arrayWithArray:array];
    
    MyEqualCellSizeSetting *equalCellSizeSetting = [[MyEqualCellSizeSetting alloc] init];
    equalCellSizeSetting.minimumInteritemSpacing = 20;
    equalCellSizeSetting.minimumLineSpacing = 20;
    equalCellSizeSetting.sectionInset = UIEdgeInsetsMake(10, 37, 10, 37);
    
    //以下值必须二选一设置（默认cellWidthFromFixedWidth设置后，另外一个自动失效）
    equalCellSizeSetting.cellWidthFromPerRowMaxShowCount = 2;
    //equalCellSizeSetting.cellWidthFromFixedWidth = 50;

    //以下值，可选设置
    equalCellSizeSetting.cellHeightFromFixedHeight = 30;
    //equalCellSizeSetting.maxDataModelShowCount = 5;
    //equalCellSizeSetting.extralItemSetting = CJExtralItemSettingLeading;
    
    self.equalCellSizeCollectionView.equalCellSizeSetting = equalCellSizeSetting;
    
    //以下值，可选设置
    //self.equalCellSizeCollectionView.maxDataModelShowCount = 5;
    
    //self.equalCellSizeCollectionView.allowsMultipleSelection = YES; //是否打开多选
    
    CJFullBottomCollectionViewCell *registerCell = [[CJFullBottomCollectionViewCell alloc] init];
    [self.equalCellSizeCollectionView registerClass:[registerCell class] forCellWithReuseIdentifier:@"cell"];
    [self.equalCellSizeCollectionView registerClass:[registerCell class] forCellWithReuseIdentifier:@"addCell"];
    
    /* 设置DataSource */
    self.equalCellSizeCollectionView.dataSource = self;
    
    /* 设置Delegate */
    __weak typeof(self)weakSelf = self;
    self.equalCellSizeCollectionView.didTapItemBlock = ^(UICollectionView *collectionView, NSIndexPath *indexPath, BOOL isDeselect) {
        MyEqualCellSizeSetting *equalCellSizeSetting = weakSelf.equalCellSizeCollectionView.equalCellSizeSetting;
        BOOL isExtralItem = [equalCellSizeSetting isExtraItemIndexPath:indexPath dataModels:weakSelf.dataModels];
        
        if (isExtralItem) {
            NSLog(@"点击额外的item");
            
        } else {
            NSLog(@"当前点击的Item为数据源中的第%ld个", indexPath.item);
            
            CJFullBottomCollectionViewCell *cell = (CJFullBottomCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
            [weakSelf operateCell:cell withDataModelIndexPath:indexPath isSettingOperate:NO];
        }
    };
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger cellCount = [self.equalCellSizeCollectionView.equalCellSizeSetting getCellCountByDataModels:self.dataModels];
    return cellCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyEqualCellSizeSetting *equalCellSizeSetting = self.equalCellSizeCollectionView.equalCellSizeSetting;
    BOOL isExtralItem = [equalCellSizeSetting isExtraItemIndexPath:indexPath dataModels:self.dataModels];
    
    if (!isExtralItem) {
        CJFullBottomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        [self operateCell:cell withDataModelIndexPath:indexPath isSettingOperate:YES];
        
        return cell;
        
    } else {
        CJFullBottomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"addCell" forIndexPath:indexPath];
        cell.cjImageView.image = [UIImage imageNamed:@"cjCollectionViewCellAdd"];
        [cell.cjDeleteButton setImage:nil forState:UIControlStateNormal];
        
        return cell;
    }
}


/**
 *  设置或者更新Cell
 *
 *  @param cell             要设置或者更新的Cell
 *  @param indexPath        用于获取数据的indexPath(此值一般情况下与cell的indexPath相等)
 *  @param isSettingOperate 是否是设置，如果否则为更新
 */
- (void)operateCell:(CJFullBottomCollectionViewCell *)cell withDataModelIndexPath:(NSIndexPath *)indexPath isSettingOperate:(BOOL)isSettingOperate {
    
    NSString *dataModle = [self.equalCellSizeCollectionView.equalCellSizeSetting getDataModelAtIndexPath:indexPath dataModels:self.dataModels];
    if (isSettingOperate) {
        cell.cjTextLabel.text = dataModle;
    }
    
    cell.cjImageView.image = [UIImage imageNamed:@"icon"];
    if (cell.selected) {
        cell.cjImageView.image = [UIImage imageNamed:@"cjCollectionViewCellAdd"];
        cell.backgroundColor = [UIColor blueColor];
    } else {
        cell.cjImageView.image = [UIImage imageNamed:@"icon"];
        cell.backgroundColor = [UIColor whiteColor];
    }
}


@end
