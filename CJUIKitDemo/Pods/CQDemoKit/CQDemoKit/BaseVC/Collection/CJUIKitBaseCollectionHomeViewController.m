//
//  CJUIKitBaseCollectionHomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 8/10/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJUIKitBaseCollectionHomeViewController.h"
#import "CJUIKitCollectionViewCell.h"
#import "CJUIKitCollectionViewHeader.h"
#import "UIImageView+CQTSBaseUtil.h"

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
    
    self.perMaxCount = 3;
//    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

#pragma mark - Setter
- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    _scrollDirection = scrollDirection;
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;//通过这种方式去获取layout，避免使用xib初始化的时候得不到
    flowLayout.scrollDirection = scrollDirection;
}

#pragma mark - setupViews
- (void)setupViews {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor clearColor];
    
    
    /* 设置Register的Cell或Nib */
    CJUIKitCollectionViewCell *registerCell = [[CJUIKitCollectionViewCell alloc] init];
    [collectionView registerClass:[registerCell class] forCellWithReuseIdentifier:@"cell"];
    [collectionView registerClass:[CJUIKitCollectionViewHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CJUIKitCollectionViewHeader"];
    
    /* 设置DataSource */
    collectionView.dataSource = self;
    
    /* 设置Delegate */
    collectionView.delegate = self;
    
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        if #available(iOS 11.0, *) {
//            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
//            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-10)
//        } else {
//            // Fallback on earlier versions
//            // topLayoutGuide\bottomLayoutGuide iOS11已经被弃用
//            make.top.equalTo(topLayoutGuide.snp.bottom).offset(10)
//            make.bottom.equalTo(bottomLayoutGuide.snp.top).offset(-10)
//        }
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(10);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-10);
        } else {
            // Fallback on earlier versions
            // topLayoutGuide\bottomLayoutGuide iOS11已经被弃用
            make.top.equalTo(self.mas_topLayoutGuideBottom).offset(10);
            make.bottom.equalTo(self.mas_bottomLayoutGuideTop).offset(-10);
        }
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.centerX.mas_equalTo(self.view);
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
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat collectionViewCellWidth = 0;
    CGFloat collectionViewCellHeight = 0;
    
    UICollectionViewFlowLayout *flowLayout = collectionViewLayout;
    BOOL isScrollHorizontal = flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal;
    if (isScrollHorizontal) {   // 按水平方向滚动时，按个数计算cell的高
        NSInteger perColumnMaxRowCount = self.perMaxCount;
        
        UIEdgeInsets sectionInset = [self collectionView:collectionView
                                                  layout:collectionViewLayout
                                  insetForSectionAtIndex:indexPath.section];;
        CGFloat rowSpacing = [self collectionView:collectionView
                                           layout:collectionViewLayout
         minimumInteritemSpacingForSectionAtIndex:indexPath.section];
        
        CGFloat height = CGRectGetHeight(collectionView.frame);
        CGFloat validHeight = height - sectionInset.top - sectionInset.bottom - rowSpacing*(perColumnMaxRowCount-1);
        collectionViewCellHeight = floorf(validHeight/perColumnMaxRowCount);
        collectionViewCellWidth = collectionViewCellHeight;
        
    } else {                    // 按竖直方向滚动时，按个数计算cell的宽
        NSInteger perRowMaxColumnCount = self.perMaxCount;
        
        UIEdgeInsets sectionInset = [self collectionView:collectionView
                                                  layout:collectionViewLayout
                                  insetForSectionAtIndex:indexPath.section];
        CGFloat columnSpacing = [self collectionView:collectionView
                                              layout:collectionViewLayout
            minimumInteritemSpacingForSectionAtIndex:indexPath.section];
        
        CGFloat width = CGRectGetWidth(collectionView.frame);
        CGFloat validWith = width - sectionInset.left - sectionInset.right - columnSpacing*(perRowMaxColumnCount-1);
        collectionViewCellWidth = floorf(validWith/perRowMaxColumnCount);
        collectionViewCellHeight = collectionViewCellWidth;
    }
    
    
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
    
    if (moduleModel.imageUrl.length > 0) {
        [cell.imageView cqdm_setImageWithUrl:moduleModel.imageUrl completed:nil];
    } else {
        UIImage *image = moduleModel.normalImage ? moduleModel.normalImage : [UIImage imageNamed:@"icon"];
        cell.imageView.image = image;
    }
    
    cell.textLabel.text = moduleModel.title;
    
    return cell;
}

- (void)execModuleModel:(CQDMModuleModel *)moduleModel {
    if (moduleModel.actionBlock) {
        moduleModel.actionBlock();
        
    } else if (moduleModel.selector) {
        [self performSelectorOnMainThread:moduleModel.selector withObject:nil waitUntilDone:NO];
        
    } else if (moduleModel.viewGetterHandle) {
        UIView *tsview = moduleModel.viewGetterHandle();
        
        UIViewController *viewController = [CQDMModuleModel viewControllWithTitle:moduleModel.title tsview:tsview];
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
        
    } else {
        UIViewController *viewController = nil;
        Class classEntry = moduleModel.classEntry;
        NSString *clsString = NSStringFromClass(moduleModel.classEntry);
        if ([clsString isEqualToString:NSStringFromClass([UIViewController class])]) {
            viewController = [[classEntry alloc] init];
            viewController.view.backgroundColor = [UIColor whiteColor];
            
        } else {
            if (moduleModel.isCreateByXib) {
                NSBundle *xibBundle = moduleModel.xibBundle;
                viewController = [[classEntry alloc] initWithNibName:clsString bundle:xibBundle];
            } else {
                viewController = [[classEntry alloc] init];
            }
        }
        
        viewController.title = NSLocalizedString(moduleModel.title, nil);
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CQDMSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:indexPath.section];
    
    CJUIKitCollectionViewHeader *reusableview = [[CJUIKitCollectionViewHeader alloc] init];
    if (kind == UICollectionElementKindSectionHeader) {
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CJUIKitCollectionViewHeader" forIndexPath:indexPath];
        reusableview.titleNameLabel.text = [NSString stringWithFormat:@"%zd.%@", indexPath.section, sectionDataModel.theme];
        dispatch_async(dispatch_get_main_queue(), ^{
            reusableview.layer.zPosition = -10;
        });
    }
    return reusableview;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    return CGSizeMake(screenWidth, 46.0f);
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
