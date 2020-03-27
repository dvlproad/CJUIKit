//
//  LEWorkHomeViewController.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/5/20.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "LEWorkHomeViewController.h"
#import <CJComplexUIKit/CJHomeCollectionView.h>
#import <CJComplexUIKit/CJHomeCollectionView+Move.h>

@interface LEWorkHomeViewController () <UICollectionViewDelegate> {
    
}
@property (nonatomic, strong) CJHomeCollectionView *collectionView;
@property (nonatomic, strong) NSArray<CJSectionDataModel *> *menuSectionDataModels;

@end

@implementation LEWorkHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工作";
    
    [self setupViews];
    
    NSMutableArray<CJHomeAdDataModel *> *adDataModels = [[NSMutableArray alloc] init];
    CJHomeAdDataModel *adDataModel = [[CJHomeAdDataModel alloc] init];
    adDataModel.imageName = @"bg.jpg";
    [adDataModels addObject:adDataModel];
    self.collectionView.adDataModels = adDataModels;
    
    NSMutableArray *menuSectionDataModels = [self getTestMenuSectionDataModels];
    self.menuSectionDataModels = menuSectionDataModels;
    self.collectionView.menuSectionDataModels = menuSectionDataModels;
    
    [self.collectionView reloadData];
}

- (void)setupViews {
    [self.view addSubview: self.collectionView];
    [self.collectionView configClickHomeAdHandle:nil clickHomeMenuHandle:^(NSIndexPath * _Nonnull menuIndexPath) {
        CJSectionDataModel *sectionDataModel = self.menuSectionDataModels[menuIndexPath.section];
        CJHomeMenuDataModel *homeMenuDataModel = sectionDataModel.values[menuIndexPath.row];
//        NSLog(@"首页点击菜单，启动 URL: %@", menu.url);
    }];
    [self.collectionView addGestureRecognizerWithContainShakeGR:YES];
    self.collectionView.cjCheckCellMoveEnableBlock = ^BOOL(NSInteger fromSection, NSInteger toSection) {
        BOOL moveEnable = fromSection == toSection;
        if (!moveEnable) {
            //NSString *message = @"只能在同一功能里移动";
            NSString *message = [NSString stringWithFormat:@"不能从%zd区移动到%zd区", fromSection, toSection];
            
            UIView *view = [[UIApplication sharedApplication].delegate window];
            [CJToast showMessage:message inView:view withLabelTextColor:[UIColor whiteColor] bezelViewColor:[UIColor blackColor] hideAfterDelay:2.f];
        }
        return moveEnable;
    };
    
    CGFloat UI_NAVIGATION_STATUS_BAR_HEIGHT = 120;
    CGFloat Bottom_Tabbar_Size_Height = 64;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(UI_NAVIGATION_STATUS_BAR_HEIGHT);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-Bottom_Tabbar_Size_Height);
    }];

}

- (NSMutableArray<CJSectionDataModel *> *)getTestMenuSectionDataModels {
    NSString *testImageUrl = @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3407848463,1025443640&fm=26&gp=0.jpg";
    
    CJSectionDataModel *secctionModel1 = [[CJSectionDataModel alloc] init];
    secctionModel1.theme = @"A区";
    secctionModel1.values = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < 5; i++) {
        CJHomeMenuDataModel *cellModel = [[CJHomeMenuDataModel alloc]init];
        cellModel.name = [NSString stringWithFormat:@"%ld", 10+i];
        cellModel.imageUrl = testImageUrl;
        cellModel.badgeCount = 10+i;
        [secctionModel1.values addObject:cellModel];
    }
    secctionModel1.selected = YES;
    
    
    CJSectionDataModel *secctionModel2 = [[CJSectionDataModel alloc]init];
    secctionModel2.theme = @"B区";
    secctionModel2.values = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < 3; i++) {
        CJHomeMenuDataModel *cellModel = [[CJHomeMenuDataModel alloc]init];
        cellModel.name = [NSString stringWithFormat:@"%ld", 20+i];
        cellModel.imageUrl = testImageUrl;
        cellModel.badgeCount = 20+i;
        [secctionModel2.values addObject:cellModel];
    }
    secctionModel2.selected = YES;
    
    CJSectionDataModel *secctionModel3 = [[CJSectionDataModel alloc]init];
    secctionModel3.theme = @"C区";
    secctionModel3.values = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < 4; i++) {
        CJHomeMenuDataModel *cellModel = [[CJHomeMenuDataModel alloc]init];
        cellModel.name = [NSString stringWithFormat:@"%ld", 30+i];
        cellModel.imageUrl = testImageUrl;
        cellModel.badgeCount = 30+i;
        [secctionModel3.values addObject:cellModel];
    }
    secctionModel3.selected = YES;
    
    NSMutableArray *secctionModels = [NSMutableArray arrayWithArray:@[secctionModel1, secctionModel2, secctionModel3]];
    return secctionModels;
}



#pragma mark - lazy init
@synthesize collectionView = _collectionView;
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[CJHomeCollectionView alloc] init];
    }
    return _collectionView;
}

@end
