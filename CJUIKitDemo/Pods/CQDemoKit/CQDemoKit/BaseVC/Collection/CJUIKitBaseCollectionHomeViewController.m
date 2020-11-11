//
//  CJUIKitBaseCollectionHomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 8/10/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJUIKitBaseCollectionHomeViewController.h"
#import "CJUIKitCollectionViewCell.h"

@interface CJUIKitBaseCollectionHomeViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource> {
    
}

@end

@implementation CJUIKitBaseCollectionHomeViewController

- (BOOL)automaticallyAdjustsScrollViewInsets {
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = NSLocalizedString(@"XXX首页", nil); //知识点:使得tabBar中的title可以和显示在顶部的title保持各自
    
    [self setupViews];
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    self.sectionDataModels = sectionDataModels;
}

- (void)setupViews {
    UICollectionViewLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor clearColor];
    
    
    /* 设置Register的Cell或Nib */
    CJUIKitCollectionViewCell *registerCell = [[CJUIKitCollectionViewCell alloc] init];
    [collectionView registerClass:[registerCell class] forCellWithReuseIdentifier:@"cell"];
    
    /* 设置DataSource */
    collectionView.dataSource = self;
    
    /* 设置Delegate */
    collectionView.delegate = self;
    
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.collectionView = collectionView;
}


#pragma mark - UICollectionViewDelegateFlowLayout
// 此部分已在父类中实现
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat collectionViewCellWidth = 0;
    if (0) {
        
    } else {
        NSInteger cellWidthFromPerRowMaxShowCount = 3;
        
        UIEdgeInsets sectionInset = [self collectionView:collectionView
                                                  layout:collectionViewLayout
                                  insetForSectionAtIndex:indexPath.section];
        CGFloat minimumInteritemSpacing = [self collectionView:collectionView
                                                        layout:collectionViewLayout
                      minimumInteritemSpacingForSectionAtIndex:indexPath.section];
        
        CGFloat width = CGRectGetWidth(collectionView.frame);
        CGFloat validWith = width - sectionInset.left - sectionInset.right - minimumInteritemSpacing*(cellWidthFromPerRowMaxShowCount-1);
        collectionViewCellWidth = floorf(validWith/cellWidthFromPerRowMaxShowCount);
    }
    
    CGFloat collectionViewCellHeight = collectionViewCellWidth;
    
    return CGSizeMake(collectionViewCellWidth, collectionViewCellHeight);
}

#pragma mark - UICollectionViewDelegate
////“点到”item时候执行的时间(allowsMultipleSelection为默认的NO的时候，只有选中，而为YES的时候有选中和取消选中两种操作)
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CQDMSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:indexPath.section];
    NSArray *dataModels = sectionDataModel.values;
    CQDMModuleModel *moduleModel = [dataModels objectAtIndex:indexPath.row];

    [self execModuleModel:moduleModel];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sectionDataModels.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    CQDMSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:section];
    NSArray *dataModels = sectionDataModel.values;
    
    return dataModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CQDMSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:indexPath.section];
    NSArray *dataModels = sectionDataModel.values;
    CQDMModuleModel *moduleModel = [dataModels objectAtIndex:indexPath.row];
    
    CJUIKitCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    UIImage *image = moduleModel.normalImage ? moduleModel.normalImage : [UIImage imageNamed:@"icon"];
    cell.imageView.image = image;
    
    cell.textLabel.text = moduleModel.title;
    
    return cell;
}

- (void)execModuleModel:(CQDMModuleModel *)moduleModel {
    if (moduleModel.actionBlock) {
        moduleModel.actionBlock();
        
    } else if (moduleModel.selector) {
        [self performSelectorOnMainThread:moduleModel.selector withObject:nil waitUntilDone:NO];
        
    } else {
        UIViewController *viewController = nil;
        Class classEntry = moduleModel.classEntry;
        NSString *clsString = NSStringFromClass(moduleModel.classEntry);
        if ([clsString isEqualToString:NSStringFromClass([UIViewController class])]) {
            viewController = [[classEntry alloc] init];
            viewController.view.backgroundColor = [UIColor whiteColor];
            
        } else {
            if (moduleModel.isCreateByXib) {
                viewController = [[classEntry alloc] initWithNibName:clsString bundle:nil];
            } else {
                viewController = [[classEntry alloc] init];
            }
        }
        
        viewController.title = NSLocalizedString(moduleModel.title, nil);
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
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
