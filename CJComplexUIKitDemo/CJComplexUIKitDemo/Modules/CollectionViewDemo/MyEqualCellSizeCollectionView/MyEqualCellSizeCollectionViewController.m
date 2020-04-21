//
//  averageWidthCollectionViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 8/10/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "MyEqualCellSizeCollectionViewController.h"

#import <CJMenuListKit/CQFilesLookCollectionView.h>
#import <CJMenuListKit/UICollectionView+CJSelect.h>
#import <CQOverlayKit/CQToast.h>
#import "TSButtonFactory.h"


#import "TSListDataSourceUtil.h"

@interface MyEqualCellSizeCollectionViewController () {
    
}
@property (nonatomic, strong) CQFilesLookCollectionView *equalCellSizeCollectionView;
@property (nonatomic, assign, readonly) BOOL isChoosing;
@end

@implementation MyEqualCellSizeCollectionViewController

- (BOOL)automaticallyAdjustsScrollViewInsets {
    return NO;
}

- (void)__chooseBarAction:(UIBarButtonItem *)chooseBarButtonItem {
    _isChoosing = !self.isChoosing;
    
    if (_isChoosing) {
        chooseBarButtonItem.title = @"取消";
        self.equalCellSizeCollectionView.isChoosing = YES;
    } else {
        chooseBarButtonItem.title = @"选择";
        self.equalCellSizeCollectionView.isChoosing = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *chooseBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"选择" style:UIBarButtonItemStylePlain target:self action:@selector(__chooseBarAction:)];
    _isChoosing = NO;
    self.navigationItem.rightBarButtonItems = @[chooseBarButtonItem];
    
    UIButton *themeBGButton1 = [TSButtonFactory themeBGButton];
    [themeBGButton1 setTitle:@"CJExtralItemSettingNone" forState:UIControlStateNormal];
    [themeBGButton1 addTarget:self action:@selector(extralItemSettingNone:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:themeBGButton1];
    [themeBGButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(120);
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *themeBGButton2 = [TSButtonFactory themeBGButton];
    [themeBGButton2 setTitle:@"CJExtralItemSettingLeading" forState:UIControlStateNormal];
    [themeBGButton2 addTarget:self action:@selector(extralItemSettingLeading:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:themeBGButton2];
    [themeBGButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(themeBGButton1.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(themeBGButton1);
        make.centerX.mas_equalTo(themeBGButton1);
        make.height.mas_equalTo(themeBGButton1);
    }];

    UIButton *themeBGButton3 = [TSButtonFactory themeBGButton];
    [themeBGButton3 setTitle:@"CJExtralItemSettingTailing" forState:UIControlStateNormal];
    [themeBGButton3 addTarget:self action:@selector(extralItemSettingTailing:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:themeBGButton3];
    [themeBGButton3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(themeBGButton2.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(themeBGButton1);
        make.centerX.mas_equalTo(themeBGButton1);
        make.height.mas_equalTo(themeBGButton1);
    }];
    
    CQFilesLookCollectionView *collectionView = [[CQFilesLookCollectionView alloc] init];
    collectionView.backgroundColor = [UIColor lightGrayColor];
    collectionView.cjScrollDirection = UICollectionViewScrollDirectionVertical;
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(themeBGButton3.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(260);
    }];
    self.equalCellSizeCollectionView = collectionView;
    [self.equalCellSizeCollectionView updateExtralItemSetting:CJExtralItemSettingTailing];
    self.equalCellSizeCollectionView.cjScrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.equalCellSizeCollectionView.allowsMultipleSelection = YES; //是否打开多选
    
//    self.equalCellSizeCollectionView.dataCellActionType = DataCellActionTypeSelect;
    self.equalCellSizeCollectionView.alwaysAloneIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];//用于测试"我与其他不共存"
    
    // 反选 VS 全选
    UIView *selectButtonsView = [[UIView alloc] init];
    [self.view addSubview:selectButtonsView];
    [selectButtonsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(collectionView.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    UIButton *invertselectButton = [TSButtonFactory themeBGButton];
    [invertselectButton setTitle:@"反选" forState:UIControlStateNormal];
    [invertselectButton addTarget:self action:@selector(invertselect:) forControlEvents:UIControlEventTouchUpInside];

    UIButton *selectAllButton = [TSButtonFactory themeBGButton];
    [selectAllButton setTitle:@"全选" forState:UIControlStateNormal];
    [selectAllButton addTarget:self action:@selector(selectAll:) forControlEvents:UIControlEventTouchUpInside];
    NSArray *selectButtons = @[invertselectButton, selectAllButton];
    for (UIButton *button in selectButtons) {
        [selectButtonsView addSubview:button];
    }
    [selectButtons mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:0 tailSpacing:0];
    [selectButtons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(selectButtonsView);
    }];
    
    // reload 保存已选中 VS 放弃已选中
    UIView *reloadButtonsView = [[UIView alloc] init];
    [self.view addSubview:reloadButtonsView];
    [reloadButtonsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(selectButtonsView.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(2*44);
    }];
    UIButton *reloadKeepSelectedButton = [TSButtonFactory themeBGButton];
    [reloadKeepSelectedButton setTitle:@"reloadData并保存已选中cell的选中状态" forState:UIControlStateNormal];
    [reloadKeepSelectedButton addTarget:self action:@selector(reloadCollectionViewWithKeepSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *reloadGiveupSelectedButton = [TSButtonFactory themeBGButton];
    [reloadGiveupSelectedButton setTitle:@"reloadData并放弃已选中cell的选中状态" forState:UIControlStateNormal];
    [reloadGiveupSelectedButton addTarget:self action:@selector(reloadCollectionViewWithGiveupSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *reloadButtons = @[reloadKeepSelectedButton, reloadGiveupSelectedButton];
    for (UIButton *button in reloadButtons) {
        [reloadButtonsView addSubview:button];
    }
    [reloadButtons mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:10 leadSpacing:0 tailSpacing:0];
    [reloadButtons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(reloadButtonsView);
    }];
    
    
    
    UIButton *changeScrollDirectionButton = [TSButtonFactory themeBGButton];
    [changeScrollDirectionButton setTitle:@"切为水平滚动" forState:UIControlStateNormal];
    [changeScrollDirectionButton setTitle:@"切为竖直滚动" forState:UIControlStateSelected];
    if (self.equalCellSizeCollectionView.cjScrollDirection == UICollectionViewScrollDirectionHorizontal) {
        changeScrollDirectionButton.selected = YES;
    } else {
        changeScrollDirectionButton.selected = NO;
    }
    [changeScrollDirectionButton addTarget:self action:@selector(changeScrollDirectionToHorizontal:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeScrollDirectionButton];
    [changeScrollDirectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(reloadButtonsView.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(themeBGButton1);
        make.centerX.mas_equalTo(themeBGButton1);
        make.height.mas_equalTo(themeBGButton1);
    }];
    
    
    UIButton *printSelectedItemsButton = [TSButtonFactory themeBGButton];
    [printSelectedItemsButton setTitle:@"打印当前的selectedItemsButton" forState:UIControlStateNormal];
    [printSelectedItemsButton addTarget:self action:@selector(printIndexPathsForSelectedItems:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:printSelectedItemsButton];
    [printSelectedItemsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(changeScrollDirectionButton.mas_bottom).mas_offset(30);
        make.left.mas_equalTo(themeBGButton1);
        make.centerX.mas_equalTo(themeBGButton1);
        make.height.mas_equalTo(themeBGButton1);
    }];
        
    
    self.equalCellSizeCollectionView.dataModels = [TSListDataSourceUtil __getTestDataModels];
    [self.equalCellSizeCollectionView reloadData];
}


#pragma mark - SettingEvent
- (void)extralItemSettingNone:(id)sender {
    [self.equalCellSizeCollectionView updateExtralItemSetting:CJExtralItemSettingNone];
    [self.equalCellSizeCollectionView reloadData];
}

- (void)extralItemSettingLeading:(id)sender {
    [self.equalCellSizeCollectionView updateExtralItemSetting: CJExtralItemSettingLeading];
    [self.equalCellSizeCollectionView reloadData];
}

- (void)extralItemSettingTailing:(id)sender {
    [self.equalCellSizeCollectionView updateExtralItemSetting: CJExtralItemSettingTailing];
    [self.equalCellSizeCollectionView reloadData];
}

#pragma mark - ReloadEvent
///打印当前的indexPathsForSelectedItems
- (void)printIndexPathsForSelectedItems:(id)sender {
    NSArray *indexPathsForSelectedItems = [self.equalCellSizeCollectionView indexPathsForSelectedItems];
    NSLog(@"indexPathsForSelectedItems = %@", indexPathsForSelectedItems);
    //总结：即使选中的item,被移动到屏幕外，indexPathsForSelectedItems也是不会变的；但是reloadData的话，就会导致所有的indexPathsForSelectedItems为空
}

///reload (测试cell的selected状态)
- (void)reloadCollectionViewWithKeepSelected:(id)sender {
    [self.equalCellSizeCollectionView my_reloadDataWithKeepSelectedState:YES];
}

- (void)reloadCollectionViewWithGiveupSelected:(id)sender {
    [self.equalCellSizeCollectionView my_reloadDataWithKeepSelectedState:NO];
}

- (void)changeScrollDirectionToHorizontal:(UIButton *)button {
    button.selected = !button.selected;
    if (button.selected) {
        self.equalCellSizeCollectionView.cjScrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.equalCellSizeCollectionView.pagingEnabled = YES;
    } else {
        self.equalCellSizeCollectionView.cjScrollDirection = UICollectionViewScrollDirectionVertical;
        self.equalCellSizeCollectionView.pagingEnabled = NO;
    }
    
}

#pragma mark - SelectEvent
///测试"全选"功能
- (void)selectAll:(UIButton *)button {
    button.selected = !button.isSelected;
    if (button.selected) { //进行全选
        [self.equalCellSizeCollectionView my_selectAllAndReloadData];
    } else {
        [self.equalCellSizeCollectionView reloadData];
    }
}

///测试"反选"功能
- (void)invertselect:(UIButton *)button {
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
