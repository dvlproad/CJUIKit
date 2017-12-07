//
//  MyEqualCellSizeCollectionView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/4/10.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "MyEqualCellSizeCollectionView.h"

@interface MyEqualCellSizeCollectionView () <UICollectionViewDelegateFlowLayout> {
    
}

@end



@implementation MyEqualCellSizeCollectionView

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
    UICollectionViewLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (layout == nil) {
        layout = [[UICollectionViewFlowLayout alloc] init];
    }
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit {
//    self.allowsMultipleSelection = YES;
    
    //self.backgroundColor = [UIColor clearColor];
    
    self.delegate = self;//UICollectionViewDelegateFlowLayout需实现UICollectionViewDelegate
    
    //为了解决MyEqualCellSizeCollectionView在某个自定义类里面使用，而不是在viewController中使用，而导致的无法实时准确的获取到CGRectGetWidth(self.frame)，从而来计算出准确的宽，所以我们应该采用实现协议的方法，而不是下面的这一行代码
    //放在这里设置flowLayout,会由于CGRectGetWidth(self.frame);初始太大而导致计算错误，所以请在调用此类的外面再设置
    //UICollectionViewFlowLayout *defaultFlowLayout = equalCellSizeSetting..xx..
    //[self setCollectionViewLayout:defaultFlowLayout animated:NO completion:nil];
}


- (MyEqualCellSizeSetting *)equalCellSizeSetting {
    if (_equalCellSizeSetting == nil) { //如果没设置会采用默认布局
        MyEqualCellSizeSetting *equalCellSizeSetting = [[MyEqualCellSizeSetting alloc] init];
        //flowLayout.headerReferenceSize = CGSizeMake(110, 135);
        equalCellSizeSetting.minimumInteritemSpacing = 10;
        equalCellSizeSetting.minimumLineSpacing = 15;
        equalCellSizeSetting.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        //以下值必须二选一设置（默认cellWidthFromFixedWidth设置后，另外一个自动失效）
        equalCellSizeSetting.cellWidthFromPerRowMaxShowCount = 4;
        //equalCellSizeSetting.cellWidthFromFixedWidth = 50;
        
        //以下值，可选设置
        //equalCellSizeSetting.cellHeightFromFixedHeight = 30;
        //equalCellSizeSetting.cellHeightFromPerColumnMaxShowCount = 1;
        
        //equalCellSizeSetting.maxDataModelShowCount = 5;
        //equalCellSizeSetting.extralItemSetting = CJExtralItemSettingLeading;
        
        _equalCellSizeSetting = equalCellSizeSetting;
    }
    return _equalCellSizeSetting;
}

/* 完整的描述请参见文件头部 */
- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    _scrollDirection = scrollDirection;
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionViewLayout;//通过这种方式去获取layout，避免使用xib初始化的时候得不到
    flowLayout.scrollDirection = scrollDirection;
}

//*
#pragma mark - UICollectionViewDelegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
//    return UIEdgeInsetsMake(10, 10, 10, 10);
    UIEdgeInsets sectionInset = self.equalCellSizeSetting.sectionInset;
    return sectionInset;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
//    return 15;
    CGFloat minimumLineSpacing = self.equalCellSizeSetting.minimumLineSpacing;
    return minimumLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
//    return 10;
    CGFloat minimumInteritemSpacing = self.equalCellSizeSetting.minimumInteritemSpacing;
    return minimumInteritemSpacing;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyEqualCellSizeSetting *equalCellSizeSetting = self.equalCellSizeSetting;
    
    CGFloat collectionViewCellWidth = 0;
    if (equalCellSizeSetting.cellWidthFromFixedWidth) {
        collectionViewCellWidth = equalCellSizeSetting.cellWidthFromFixedWidth;
        
    } else {
        NSInteger cellWidthFromPerRowMaxShowCount = equalCellSizeSetting.cellWidthFromPerRowMaxShowCount;
        
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
    
    CGFloat collectionViewCellHeight = 0;
    if (equalCellSizeSetting.cellHeightFromFixedHeight) {
        collectionViewCellHeight = equalCellSizeSetting.cellHeightFromFixedHeight;
    } else if (equalCellSizeSetting.cellHeightFromPerColumnMaxShowCount) {
        NSInteger cellHeightFromPerColumnMaxShowCount = equalCellSizeSetting.cellHeightFromPerColumnMaxShowCount;
        
        UIEdgeInsets sectionInset = [self collectionView:collectionView
                                                  layout:collectionViewLayout
                                  insetForSectionAtIndex:indexPath.section];
        CGFloat minimumLineSpacing = [self collectionView:collectionView
                                                   layout:collectionViewLayout
                      minimumLineSpacingForSectionAtIndex:indexPath.section];
        
        CGFloat height = CGRectGetHeight(collectionView.frame);
        CGFloat validHeight = height - sectionInset.top - sectionInset.bottom - minimumLineSpacing*(cellHeightFromPerColumnMaxShowCount-1);
        collectionViewCellHeight = floorf(validHeight/cellHeightFromPerColumnMaxShowCount);
    } else {
        collectionViewCellHeight = collectionViewCellWidth;
    }
    
    return CGSizeMake(collectionViewCellWidth, collectionViewCellHeight);
}
//*/

//#pragma mark - UICollectionViewDelegate
////“点到”item时候执行的时间(allowsMultipleSelection为默认的NO的时候，只有选中，而为YES的时候有选中和取消选中两种操作)
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didTapItemBlock) {
        self.didTapItemBlock(self, indexPath, NO);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didTapItemBlock) {
        self.didTapItemBlock(self, indexPath, YES);
    }
}


#pragma mark - Other
/** 完整的描述请参见文件头部 */
+ (CGFloat)heightForDataModels:(NSArray *)dataModels
         byCollectionViewWidth:(CGFloat)collectionViewWidth
       withEqualCellSizeSetting:(MyEqualCellSizeSetting *)equalCellSizeSetting
{
    CGFloat minimumLineSpacing = equalCellSizeSetting.minimumLineSpacing;
    CGFloat minimumInteritemSpacing = equalCellSizeSetting.minimumInteritemSpacing;
    UIEdgeInsets sectionInset = equalCellSizeSetting.sectionInset;
    
    
    //计算cell的宽度
    CGFloat collectionViewCellWidth = 0;
    NSInteger perRowMaxShowCount = 0;
    if (equalCellSizeSetting.cellWidthFromFixedWidth) {
        collectionViewCellWidth = equalCellSizeSetting.cellWidthFromFixedWidth;
        
        //sectionInset.left + x*width + (x-1)*minimumInteritemSpacing + sectionInset.right <= collectionViewWidth;
        //x*cellWidth + (x-1)*minimumInteritemSpacing <= collectionViewWidth - sectionInset.left - sectionInset.right;
        //x*(cellWidth+minimumInteritemSpacing) <= collectionViewWidth - sectionInset.left - sectionInset.right + minimumInteritemSpacing;
        CGFloat validWidth = collectionViewWidth - sectionInset.left - sectionInset.right;
        perRowMaxShowCount = (validWidth+minimumInteritemSpacing)/(collectionViewCellWidth+minimumInteritemSpacing);
        
    } else {
        perRowMaxShowCount = equalCellSizeSetting.cellWidthFromPerRowMaxShowCount;
        NSAssert(perRowMaxShowCount != 0, @"perRowMaxShowCount不能为0");
        
        CGFloat validWidth = collectionViewWidth - sectionInset.left - sectionInset.right;
        CGFloat cellsWidth = validWidth - minimumInteritemSpacing*(perRowMaxShowCount-1);
        collectionViewCellWidth = floorf(cellsWidth/perRowMaxShowCount);
    }
    
    
    /* 获取cell的高度 */
    CGFloat collectionViewCellHeight = equalCellSizeSetting.cellHeightFromFixedHeight;
    if (collectionViewCellHeight <= 0) { //如果cell的高度未设置，我们默认使其等于cell的宽度
        collectionViewCellHeight = collectionViewCellWidth;
    }
    
    
    NSInteger dataModelCount = dataModels.count;

    CGFloat height = 0;
    NSInteger currentRowCount = 0;
    NSInteger allCellCount = 0;
    if (equalCellSizeSetting.extralItemSetting == CJExtralItemSettingLeading ||
        equalCellSizeSetting.extralItemSetting == CJExtralItemSettingTailing) {
        
        NSInteger maxDataModelShowCount = equalCellSizeSetting.maxDataModelShowCount;
        if (dataModelCount < maxDataModelShowCount) {
            allCellCount = dataModelCount + 1;
        } else {
            allCellCount = dataModelCount;
        }
        
    } else {
        allCellCount = dataModelCount;
    }
    
    if (allCellCount == 0) {
        currentRowCount = 0;
        height += currentRowCount * collectionViewCellHeight;
    } else {
        currentRowCount = (allCellCount-1)/perRowMaxShowCount + 1;
        height += currentRowCount * collectionViewCellHeight + (currentRowCount - 1)*minimumLineSpacing;
    }
    height += sectionInset.top + sectionInset.bottom;
    
    return height;
}

@end
