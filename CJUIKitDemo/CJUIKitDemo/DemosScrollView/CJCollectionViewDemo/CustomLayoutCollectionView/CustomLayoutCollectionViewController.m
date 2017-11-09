//
//  CustomLayoutCollectionViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/4/24.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CustomLayoutCollectionViewController.h"

#import "CJCellHorizontalLayout.h"
#import "CJCircleLayout.h"

#import "TestDataUtil.h"
#import "CJFullBottomCollectionViewCell.h"

@interface CustomLayoutCollectionViewController () {
    
}

@end



@implementation CustomLayoutCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.datas = [TestDataUtil getTestDataModels];
    
    [self setupUICollectionViewFlowLayout:nil]; //设置布局方式
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[CJFullBottomCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:self.collectionView];
}

- (BOOL)automaticallyAdjustsScrollViewInsets {
    return NO;
}


- (IBAction)setupUICollectionViewFlowLayout:(id)sender {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(70, 85);
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 2;
    
    [self.collectionView setCollectionViewLayout:flowLayout];
}

- (IBAction)setupCJCellHorizontalLayout:(id)sender {
    CJCellHorizontalLayout *cellHorizontalLayout = [[CJCellHorizontalLayout alloc] init];
    cellHorizontalLayout.itemSize = CGSizeMake(70, 85);
    cellHorizontalLayout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
    cellHorizontalLayout.minimumLineSpacing = 1;
    cellHorizontalLayout.minimumInteritemSpacing = 1;
    
    [self.collectionView setCollectionViewLayout:cellHorizontalLayout];
}

- (IBAction)setupCJCircleLayout:(id)sender {
    CJCircleLayout *circleLayout = [[CJCircleLayout alloc] init];
    circleLayout.center = self.collectionView.center;
    circleLayout.radius = 10;
    circleLayout.cellCount = 13;
    
    [self.collectionView setCollectionViewLayout:circleLayout];
}

#pragma mark - UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TestDataModel *dataModel = [self.datas objectAtIndex:indexPath.item];
    
    CJFullBottomCollectionViewCell *cell = (CJFullBottomCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.cjImageView.image = [UIImage imageNamed:dataModel.imagePath];
    cell.cjTextLabel.text = dataModel.name;
    
    return cell;
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
