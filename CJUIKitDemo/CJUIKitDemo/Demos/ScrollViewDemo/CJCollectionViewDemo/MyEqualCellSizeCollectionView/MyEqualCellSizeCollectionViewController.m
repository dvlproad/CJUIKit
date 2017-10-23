//
//  averageWidthCollectionViewController.m
//  AllScrollViewDemo
//
//  Created by ciyouzen on 8/10/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "MyEqualCellSizeCollectionViewController.h"
#import "CJFullBottomCollectionViewCell.h"

#import "DemoInfo.h"

@interface MyEqualCellSizeCollectionViewController () <UICollectionViewDataSource> {
    
}
@property (nonatomic, strong) NSIndexPath *alwaysAloneIndexPath;/**< 与其他不共存的indexPath */

@end

@implementation MyEqualCellSizeCollectionViewController

- (BOOL)automaticallyAdjustsScrollViewInsets {
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupEuqalCellSizeCollectionView];
        
    self.alwaysAloneIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];//用于测试"我与其他不共存"
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
    equalCellSizeSetting.cellWidthFromPerRowMaxShowCount = 4;
    //equalCellSizeSetting.cellWidthFromFixedWidth = 50;
    
    //以下值，可选设置
    //equalCellSizeSetting.cellHeightFromFixedHeight = 30;
    //equalCellSizeSetting.maxDataModelShowCount = 5;
    equalCellSizeSetting.extralItemSetting = CJExtralItemSettingTailing;
    self.equalCellSizeCollectionView.equalCellSizeSetting = equalCellSizeSetting;
    self.equalCellSizeCollectionView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.equalCellSizeCollectionView.allowsMultipleSelection = YES; //是否打开多选
    
    
    /* 设置Register的Cell或Nib */
    CJFullBottomCollectionViewCell *registerCell = [[CJFullBottomCollectionViewCell alloc] init];
    [self.equalCellSizeCollectionView registerClass:[registerCell class] forCellWithReuseIdentifier:@"cell"];
    [self.equalCellSizeCollectionView registerClass:[registerCell class] forCellWithReuseIdentifier:@"addCell"];
    
    /* 设置DataSource */
    self.equalCellSizeCollectionView.dataSource = self;
    
    /* 设置Delegate */
    __weak typeof(self)weakSelf = self;
    self.equalCellSizeCollectionView.didTapItemBlock = ^(UICollectionView *collectionView, NSIndexPath *indexPath, BOOL isDeselect) {
        MyEqualCellSizeSetting *equalCellSizeSetting = weakSelf.equalCellSizeCollectionView.equalCellSizeSetting;
        BOOL isExtralItem = [equalCellSizeSetting isExtraItemIndexPath:indexPath dataModels:self.dataModels];
        
        if (isExtralItem) {
            NSLog(@"点击额外的item");
            
        } else {
            NSLog(@"当前点击的Item为数据源中的第%ld个", indexPath.item);
            
            /* 测试“我与其他不共存功能” */
            if ([indexPath isEqual:self.alwaysAloneIndexPath]) {
                [self.equalCellSizeCollectionView my_deselectOtherExceptIndexPath:indexPath];
                
            } else {
                if ([weakSelf.equalCellSizeCollectionView.indexPathsForVisibleItems containsObject:weakSelf.alwaysAloneIndexPath]) {//选择其他cell时候，如果独立的cell是选中的，则应去除独立cell的选中状态
                    [self.equalCellSizeCollectionView reloadItemsAtIndexPaths:@[weakSelf.alwaysAloneIndexPath]];
                }
                
                //对当前的cell进行改变，不要为了更新一个cell的状态，而去调用reload方法，那样消耗太大，即
                //方法①：可取且最优的方法如下
                CJFullBottomCollectionViewCell *cell = (CJFullBottomCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
                [weakSelf operateCell:cell withDataModelIndexPath:indexPath isSettingOperate:NO];
                //方法②：可用有效，但不可取的方法如下
                //[self.equalCellSizeCollectionView reloadDataWithKeepSelectedState:YES];
                
            }
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
        
        NSLog(@"cell.selected = %@", cell.selected ? @"YES" : @"NO");
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






#pragma mark - SettingEvent
- (IBAction)extralItemSettingNone:(id)sender {
    self.equalCellSizeCollectionView.equalCellSizeSetting.extralItemSetting = CJExtralItemSettingNone;
    [self.equalCellSizeCollectionView reloadData];
}

- (IBAction)extralItemSettingLeading:(id)sender {
    self.equalCellSizeCollectionView.equalCellSizeSetting.extralItemSetting = CJExtralItemSettingLeading;
    [self.equalCellSizeCollectionView reloadData];
}

- (IBAction)extralItemSettingTailing:(id)sender {
    self.equalCellSizeCollectionView.equalCellSizeSetting.extralItemSetting = CJExtralItemSettingTailing;
    [self.equalCellSizeCollectionView reloadData];
}

#pragma mark - ReloadEvent
///打印当前的indexPathsForSelectedItems
- (IBAction)printIndexPathsForSelectedItems:(id)sender {
    NSArray *indexPathsForSelectedItems = [self.equalCellSizeCollectionView indexPathsForSelectedItems];
    NSLog(@"indexPathsForSelectedItems = %@", indexPathsForSelectedItems);
    //总结：即使选中的item,被移动到屏幕外，indexPathsForSelectedItems也是不会变的；但是reloadData的话，就会导致所有的indexPathsForSelectedItems为空
}

///reload (测试cell的selected状态)
- (IBAction)reloadCollectionView:(id)sender {
    [self.equalCellSizeCollectionView my_reloadDataWithKeepSelectedState:YES];
}

- (IBAction)changeScrollDirectionToHorizontal:(UIButton *)button {
    button.selected = !button.selected;
    if (button.selected) {
        self.equalCellSizeCollectionView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    } else {
        self.equalCellSizeCollectionView.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    
}

#pragma mark - SelectEvent
///测试"全选"功能
- (IBAction)selectAll:(UIButton *)button {
    button.selected = !button.isSelected;
    if (button.selected) { //进行全选
        [self.equalCellSizeCollectionView my_selectAllAndReloadData];
    } else {
        [self.equalCellSizeCollectionView reloadData];
    }
}

///测试"反选"功能
- (IBAction)invertselect:(UIButton *)button {
    NSArray *indexPaths = [self.equalCellSizeCollectionView indexPathsForSelectedItems];
    [self.equalCellSizeCollectionView my_invertselectIndexPaths:indexPaths];
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
