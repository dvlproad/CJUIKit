//
//  CustomLayoutCollectionViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/4/24.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CustomLayoutCollectionViewController.h"
#import <Masonry/Masonry.h>

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
    self.dataModels = [TestDataUtil getTestDataModels];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(120);
        make.left.mas_equalTo(self.view).mas_offset(15);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(380);
    }];
    self.collectionView = collectionView;
    
    [self setupCJCellHorizontalLayout:nil]; //设置布局方式
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
    //以下值必须二选一设置（默认cellWidthFromFixedWidth设置后，另外一个自动失效）
    cellHorizontalLayout.cellWidthFromPerRowMaxShowCount = 4;
//    cellHorizontalLayout.cellWidthFromFixedWidth = 70;
    
    //以下值，可选设置
//    cellHorizontalLayout.cellHeightFromFixedHeight = 85;
    //cellHorizontalLayout.cellHeightFromPerColumnMaxShowCount = 4;
    
    cellHorizontalLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    cellHorizontalLayout.minimumLineSpacing = 15;
    cellHorizontalLayout.minimumInteritemSpacing = 10;
    
    [self.collectionView setCollectionViewLayout:cellHorizontalLayout];
    
    // 获取cell的高度(如果有需要的话)
    CGFloat collectionViewHeight = [self heightByScreenMarginLeft:15 screenMarginRight:15];
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(collectionViewHeight);
    }];
}


#pragma mark - Getter
/*
*  获取collectionView的高度
*
*  @param marginLeft         collectionView与屏幕的左边距
*  @param marginRight        collectionView与屏幕的右边距
*
*  @return
*/
- (CGFloat)heightByScreenMarginLeft:(CGFloat)marginLeft
                  screenMarginRight:(CGFloat)marginRight
{
    CGFloat screenWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    CGFloat collectionViewWidth = screenWidth-marginLeft-marginRight;

    NSInteger allCellCount = self.dataModels.count;

//    MyEqualCellSizeSetting *equalCellSizeSetting = self.equalCellSizeCollectionViewDelegate.equalCellSizeSetting;
//    CGFloat height = [MyEqualCellSizeCollectionViewNormalDelegate heightForAllCellCount:allCellCount byCollectionViewWidth:collectionViewWidth withEqualCellSizeSetting:equalCellSizeSetting];

    CJCellHorizontalLayout *layout = (CJCellHorizontalLayout *)self.collectionView.collectionViewLayout;
    CGFloat height = [CJCellHorizontalLayout heightForAllCellCount:allCellCount maxRowCount:2 byCollectionViewWidth:collectionViewWidth withCollectionViewLayout:layout];

    return height;
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
    return self.dataModels.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TestDataModel *dataModel = [self.dataModels objectAtIndex:indexPath.item];
    
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
