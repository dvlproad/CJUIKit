//
//  CvDemo_Complex.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 8/10/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CvDemo_Complex.h"

#import "CustomCollectionViewCell.h"
#import "cvSupplementaryHead.h"
#import "cvSupplementaryFoot.h"
#import "DemoInfo.h"

#define ItemSize                CGSizeMake(100, 100)
#define TOP_SECTION_INSET       0
#define MinimumLineSpacing      25
#define MinimumInteritemSpacing 10
#define HEIGHT_HEAD_REFERENCE   44
#define HEIGHT_FOOT_REFERENCE   10


@interface CvDemo_Complex ()

@end

@implementation CvDemo_Complex

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    lists = [[NSMutableArray alloc]init];
    [lists removeAllObjects];
    for (int i = 0; i < 24; i++) {
        DemoInfo *info = [[DemoInfo alloc]init];
        info.name = [NSString stringWithFormat:@"%d", i];
        info.price = [NSString stringWithFormat:@"%d元", 100*i];
        
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"icon" ofType:@"png"];
        info.imagePath = imagePath;
        [lists addObject:info];
    }
    [self.cv reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"CvDemo_Complex", nil);
    
    UINib *nib_cvCell = [UINib nibWithNibName:@"CustomCollectionViewCell" bundle:[NSBundle mainBundle]];
    UINib *nib_cvSupplementaryHead = [UINib nibWithNibName:@"cvSupplementaryHead" bundle:[NSBundle mainBundle]];
    UINib *nib_cvSupplementaryFoot = [UINib nibWithNibName:@"cvSupplementaryFoot" bundle:[NSBundle mainBundle]];
    [self.cv registerNib:nib_cvCell forCellWithReuseIdentifier:@"cell"]; //registerClass 无效
    [self.cv registerNib:nib_cvSupplementaryHead forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cvSupplementaryHead"];
    [self.cv registerNib:nib_cvSupplementaryFoot forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"cvSupplementaryFoot"];
    
    
    //注意：创建UICollectionView。需要使用UICollectionViewFlowLayout来创建，即需要设置flowLayout来创建，一般我们使用方法- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout;如果只用普通的init方法，是实现不了的
    UICollectionViewLayout *flowLayout = [self getFlowLayout];
    [self.cv setCollectionViewLayout:flowLayout];
    self.cv.alwaysBounceVertical = YES; //控制垂直方向遇到边框是否反弹
    
    self.cv.dataSource = self;
    self.cv.delegate = self;
}



#pragma mark - CVDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return [lists count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView  cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellIdentifier = @"cell";
    DemoInfo *info = [lists objectAtIndex:indexPath.row];
    
    CustomCollectionViewCell *cell = [collectionView  dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.imageV.image = [UIImage imageWithContentsOfFile:info.imagePath];
    cell.labName.text = info.name;
    cell.labPrice.text = info.price;
    
    return cell;
}




//*
- (UICollectionViewFlowLayout *)getFlowLayout{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    [flowLayout setItemSize:ItemSize];
    [flowLayout setMinimumLineSpacing:MinimumLineSpacing];
    [flowLayout setMinimumInteritemSpacing:MinimumInteritemSpacing];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];    //滚动方向
    [flowLayout setHeaderReferenceSize:CGSizeMake(0, HEIGHT_HEAD_REFERENCE)];//头部
    [flowLayout setFooterReferenceSize:CGSizeMake(0, HEIGHT_FOOT_REFERENCE)];
    [flowLayout setSectionInset:UIEdgeInsetsMake(TOP_SECTION_INSET, 0, 0, 0)];
    
    
    return flowLayout;
}


-(BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


//Item size(每个item的大小)
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return ItemSize;
}

//Line spacing（每行的间距）
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return MinimumLineSpacing;
}


//Inter cell spacing（每行内部cell item的间距）
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return MinimumInteritemSpacing;
}

//Header and footer size（页眉和页脚大小）
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(0, HEIGHT_HEAD_REFERENCE);
    }
    return CGSizeMake(0, 0);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(0, HEIGHT_FOOT_REFERENCE);
}


//Section Inset
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//*/





- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader && indexPath.section == 0) {
        static NSString *cellIdentifier = @"cvSupplementaryHead";
        cvSupplementaryHead *cvSupplementaryHead = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        cvSupplementaryHead.labTitle.text = @"这里暂时不写";
        
        return cvSupplementaryHead;
    }else{
        static NSString *cellIdentifier = @"cvSupplementaryFoot";
        cvSupplementaryFoot *cvSupplementaryFoot = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        return cvSupplementaryFoot;
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
