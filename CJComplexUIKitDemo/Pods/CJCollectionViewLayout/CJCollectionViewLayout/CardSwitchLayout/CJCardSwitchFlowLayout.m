//
//  CJCardSwitchFlowLayout.m
//  TSImageFilterDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJCardSwitchFlowLayout.h"

@interface CJCardSwitchFlowLayout () {
    
}
@property (nonatomic, copy, readonly) CGSize(^centerItemSizeGetBlock)(CGSize collectionViewSize);   /**< 中心卡片相对collectionView视图的大小 */
@property (nonatomic, copy, readonly) CGFloat(^itemScaleGetBlock)(CGFloat bProgress);               /**< 当前item在自己当前progress（移动进度 -1~0~1）时候的缩放比 */

@end


@implementation CJCardSwitchFlowLayout

/*
 *  初始化
 *
 *  @param centerItemSizeGetBlock   中心卡片相对collectionView视图的大小
 *
 *  @return 布局layout
 */
- (instancetype)initWithCenterItemSizeGetBlock:(CGSize(^ _Nonnull)(CGSize collectionViewSize))centerItemSizeGetBlock {
    return [self initWithCenterItemSizeGetBlock:centerItemSizeGetBlock itemScaleGetBlock:nil minimumLineSpacing:0];
}

/*
 *  初始化
 *
 *  @param centerItemSizeGetBlock   中心卡片相对collectionView视图的大小
 *  @param itemScaleGetBlock        当前item在自己当前progress（移动进度 -1~0~1）时候的缩放比
 *  @param minimumLineSpacing       未进行任何缩放时候，item之间的间距
 *
 *  @return 布局layout
 */
- (instancetype)initWithCenterItemSizeGetBlock:(CGSize(^ _Nonnull)(CGSize collectionViewSize))centerItemSizeGetBlock
                             itemScaleGetBlock:(CGFloat(^ _Nullable)(CGFloat bProgress))itemScaleGetBlock
                            minimumLineSpacing:(CGFloat)minimumLineSpacing
{
    self = [super init];
    if (self) {
        _centerItemSizeGetBlock = centerItemSizeGetBlock;
        
        if (itemScaleGetBlock == nil) {
            itemScaleGetBlock = ^(CGFloat bProgress) {
                CGFloat scale = fabs(cos(fabs(bProgress) * M_PI/4));
                return scale;
            };
        }
        _itemScaleGetBlock = itemScaleGetBlock;
        
        self.minimumLineSpacing = minimumLineSpacing;
    }
    return self;
}

//初始化方法
- (void)prepareLayout {
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGSize collectionViewSize = self.collectionView.bounds.size;
    CGSize centerItemSize = self.centerItemSizeGetBlock(collectionViewSize);
    CGFloat itemWidth = centerItemSize.width;
    CGFloat itemHeight = centerItemSize.height;
    CGFloat insetX = (self.collectionView.bounds.size.width - itemWidth)/2.0f;   // 设置左右缩进
    CGFloat insetY = (self.collectionView.bounds.size.height - itemHeight)/2.0f;
    self.sectionInset = UIEdgeInsetsMake(insetY, insetX, insetY, insetX);
    self.itemSize = CGSizeMake(itemWidth, itemHeight);
}

//设置缩放动画
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    CGSize collectionViewSize = self.collectionView.bounds.size;
    CGSize centerItemSize = self.centerItemSizeGetBlock(collectionViewSize);
    CGFloat itemWidth = centerItemSize.width;
    
    //获取cell的布局
    NSArray *attributesArr = [super layoutAttributesForElementsInRect:rect];
    //屏幕中线
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width/2.0f;
    //最大移动距离，计算范围是移动出屏幕前的距离
    CGFloat maxApart = (self.collectionView.bounds.size.width + itemWidth)/2.0f;
    //刷新cell缩放
    NSInteger attributeCount = attributesArr.count;
    for (NSInteger index = 0; index < attributeCount; index++) {
        UICollectionViewLayoutAttributes *attributes = attributesArr[index];
        
        //获取本cell中心和屏幕中心的距离(正数：左侧；0:中心；负数：左侧)
        CGFloat apart = attributes.center.x - centerX;
        //移动进度 -1~0~1
        CGFloat progress = apart/maxApart;
        //在屏幕外的cell不处理
        if (fabs(progress) > 1) {continue;}
        //根据余弦函数，弧度在 -π/4 到 π/4,即 scale在 √2/2~1~√2/2 间变化
        CGFloat scale = self.itemScaleGetBlock(progress);
        //缩放大小
        attributes.transform = CGAffineTransformMakeScale(scale, scale);
        //更新中间位
        CGFloat halfItemWidth = itemWidth/2.0f;
//        if (index == 1) {
//            NSLog(@"index:%zd, progress:%.2f, apart:%.2f, halfItemWidth=%.2f", index, progress, apart, halfItemWidth);
//        }
        BOOL isLeftOrCenter = apart <= halfItemWidth; // 是否已经滚动到左边(在中间也算)
        
        BOOL currentLeftIsCloseToCenter = NO;   // 是否已经滚动到左边(在中间也算)，并且是否是最靠近中心的左边cell(此值只有当isLeftOrCenter为YES的时候才有效)
        if (isLeftOrCenter) { // 当前cell已经在左侧，判断下一个cell是否也是在左侧
            //获取下一个cell中心和屏幕中心的距离(正数：左侧；0:中心；负数：左侧)
            NSInteger nextIndex = index+1;
            BOOL existNext = nextIndex <= attributeCount-1;
            if (existNext) {
                UICollectionViewLayoutAttributes *nextAttributes = attributesArr[nextIndex];
                CGFloat nextAttributesApart = nextAttributes.center.x - centerX;
                BOOL nextIsRight = nextAttributesApart > halfItemWidth; // 是否下一个cell也已经滚动到左边(在中间也算)
                currentLeftIsCloseToCenter = nextIsRight;
            } else {
                currentLeftIsCloseToCenter = YES;
            }
        }
        if (currentLeftIsCloseToCenter == YES) {
            //NSLog(@"第%zd个cell是否是最靠近中心：%@(attributeCount=%zd)", index, currentLeftIsCloseToCenter? @"是":@"不是", attributeCount);
        }
        
        //if (attributes.indexPath.item == 1) { // 先单独测试一个
            CGFloat alpha = 1-fabs(progress);
            attributes.alpha = alpha;
            //NSLog(@"测试的这个cell此时的alpha = %.2f", alpha);
            // 不用再通过回调的progress值，再在外面通过cell.contentView.alpha设置透明度了（多此一举，还会引起初始cell未获取到而透明度设置不上去）
            //UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
            //cell.contentView.alpha = alpha; // 注：设置透明度要对cell.contentView设置，而不是cell，否则滑动会有异常
        //}
        !self.progressValueChangeBlock ?: self.progressValueChangeBlock(attributes.indexPath, progress, isLeftOrCenter, currentLeftIsCloseToCenter);
    }
    return attributesArr;
}


//是否实时刷新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return true;
}

@end
