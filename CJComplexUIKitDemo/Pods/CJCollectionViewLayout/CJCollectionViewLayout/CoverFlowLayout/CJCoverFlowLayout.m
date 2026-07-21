//
//  CJCoverFlowLayout.m
//  TSImageFilterDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJCoverFlowLayout.h"

@interface CJCoverFlowLayout () {
    
}
@property (nonatomic, copy, readonly) CGSize(^centerItemSizeGetBlock)(CGSize collectionViewSize);   /**< 中心卡片相对collectionView视图的大小 */
/**< 定制attributes这个布局的cell在视图上不同位置的样式（如设置缩放、透明度等）。其中参数progress：cell的中心在集合视图上的移动进度，值范围为-1~0~1(0的时候代表此cell的中心和视图中心重合) */
@property (nullable, nonatomic, copy, readonly) void(^configAttributesAtProgressBlock)(UICollectionViewLayoutAttributes *attributes, CGFloat progress);

@end


@implementation CJCoverFlowLayout

#pragma mark - Init
/*
 *  初始化会自动缩放和改变透明度的封面浏览效果布局
 *
 *  @param centerItemSizeGetBlock   中心卡片相对collectionView视图的大小
 *
 *  @return 布局layout
 */
- (instancetype)initWithCenterItemSizeGetBlock:(CGSize(^ _Nonnull)(CGSize collectionViewSize))centerItemSizeGetBlock
{
    return [self initWithCenterItemSizeGetBlock:centerItemSizeGetBlock minimumLineSpacing:0 configAttributesAtProgressBlock:^(UICollectionViewLayoutAttributes *attributes, CGFloat progress) {
        
        // 缩放大小
        CGFloat scale = fabs(cos(fabs(progress) * M_PI/4));//根据余弦函数，弧度在 -π/4 到 π/4,即 scale在 √2/2~1~√2/2 间变化
        attributes.transform = CGAffineTransformMakeScale(scale, scale);

        // 透明度
        //if (attributes.indexPath.item == 1) { // 先单独测试一个
        CGFloat alpha = 1-fabs(progress);
        attributes.alpha = alpha;
        //NSLog(@"测试的这个cell此时的alpha = %.2f", alpha);
        // 不用再通过回调的progress值，再在外面通过cell.contentView.alpha设置透明度了（多此一举，还会引起初始cell未获取到而透明度设置不上去）
        //UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
        //cell.contentView.alpha = alpha; // 注：设置透明度要对cell.contentView设置，而不是cell，否则滑动会有异常
        //}
    }];
}

/*
 *  初始化
 *
 *  @param centerItemSizeGetBlock           中心卡片相对collectionView视图的大小
 *  @param minimumLineSpacing               未进行任何缩放时候，item之间的间距
 *  @param configAttributesAtProgressBlock  定制attributes这个布局的cell在视图上不同位置的样式（如设置缩放、透明度等）。其中参数progress：cell的中心在集合视图上的移动进度，值范围为-1~0~1(0的时候代表此cell的中心和视图中心重合)
 *
 *  @return 布局layout
 */
- (instancetype)initWithCenterItemSizeGetBlock:(CGSize(^ _Nonnull)(CGSize collectionViewSize))centerItemSizeGetBlock
                            minimumLineSpacing:(CGFloat)minimumLineSpacing
               configAttributesAtProgressBlock:(void(^ _Nullable)(UICollectionViewLayoutAttributes *attributes, CGFloat progress))configAttributesAtProgressBlock
{
    self = [super init];
    if (self) {
        _centerItemSizeGetBlock = centerItemSizeGetBlock;
        _configAttributesAtProgressBlock = configAttributesAtProgressBlock;
        
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
    self.itemSize = centerItemSize;
    
    CGFloat itemWidth = centerItemSize.width;
    CGFloat index0OriginXBegin = collectionViewSize.width/2 - itemWidth/2;   // index0开始计算originX的起点,作为左右缩进
    CGFloat itemHeight = centerItemSize.height;
    CGFloat insetY = collectionViewSize.height/2 - itemHeight/2;
    self.sectionInset = UIEdgeInsetsMake(insetY, index0OriginXBegin, insetY, index0OriginXBegin);
    
}

#pragma mark - 滑动过程中会调用到的方法
/// 滑动过程中会调用到的方法（使用场景：可以用来设置各个cell的透明度）
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    CGSize collectionViewSize = self.collectionView.bounds.size;
    CGSize centerItemSize = self.centerItemSizeGetBlock(collectionViewSize);
    CGFloat itemWidth = centerItemSize.width;
    
    //获取cell的布局
    NSArray *attributesArr = [super layoutAttributesForElementsInRect:rect];
    //屏幕中线
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width/2.0f;
    //最大移动距离，计算范围是移动出屏幕前的距离(若超出此区域，则在此回调方法rect里不会返回)
    CGFloat maxApart = (self.collectionView.bounds.size.width + itemWidth)/2.0f;
    //定制不同时刻的cell(缩放、透明度)
    NSInteger attributeCount = attributesArr.count;
    for (NSInteger index = 0; index < attributeCount; index++) {
        UICollectionViewLayoutAttributes *attributes = attributesArr[index];
        
        //获取本cell中心和屏幕中心的距离(正数：左侧；0:中心；负数：左侧)
        CGFloat apart = attributes.center.x - centerX;
        //移动进度 -1~0~1(0的时候代表此cell的中心和视图中心重合)
        CGFloat progress = apart/maxApart;
        if (fabs(progress) > 1) {   //在屏幕外的cell不处理
            continue;
        }
        
        !self.configAttributesAtProgressBlock ?: self.configAttributesAtProgressBlock(attributes, progress);
    }
    return attributesArr;
}


//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//}


//是否实时刷新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return true;
}

#pragma mark - 滑动停止时候会调用到的方法
#pragma mark 获取哪个cell离屏幕中心最近，即当前屏幕中心滚动停止后要显示的cell的index的方法1
/*
 *  重写滚动停下时的位置，让其自动居中
 *
 *  @param proposedContentOffset    将要停止的点
 *  @param velocity                 滚动速度
 *
 *  @return 最终滚动停止的点
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    if (self.shouldAutoCenter == NO) {
        return [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
    }
    
    CGFloat targetContentOffsetMaxX = [self collectionViewContentSize].width - self.collectionView.bounds.size.width; // 水平最大停到的位置
    if (proposedContentOffset.x <= 0 || proposedContentOffset.x >= targetContentOffsetMaxX) {
        return proposedContentOffset;
    }
    
    
    // 获取当前显示区域这个范围的布局数组
    CGRect visibelRect = CGRectMake(proposedContentOffset.x, proposedContentOffset.y, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height); // 当前显示的区域
    NSArray<UICollectionViewLayoutAttributes *> *attributes = [self layoutAttributesForElementsInRect:visibelRect];
    
    // 遍历数组计算找出所有cell中离中心最小的cell
    CGFloat minDistanceToCenter = MAXFLOAT; // 初始化所有cell中离中心最小的距离
    NSInteger minDistanceToCenterCellIndex = -1;
    CGFloat currentCenterOffsetX = proposedContentOffset.x + self.collectionView.bounds.size.width/2; // 当前集合视图的中心点位置
    for (NSInteger i = 0; i < attributes.count; i++) {
        // 查找方法：如果当前cell离中心的距离，比之前的更小，则新cell比旧cell离中心更近
        UICollectionViewLayoutAttributes *attribute = attributes[i];
        CGFloat currentCellDistanceToCenter = attribute.center.x - currentCenterOffsetX;
        if (fabsf(currentCellDistanceToCenter) < fabsf(minDistanceToCenter)) {
            minDistanceToCenter = currentCellDistanceToCenter;
            minDistanceToCenterCellIndex = i;
        }
    }
    NSLog(@"滚动停下时,所有cell中index=%ld的cell的中心离集合视图的中心距离最小,且最小距离为minDistanceToCenter = %.2f", minDistanceToCenterCellIndex, minDistanceToCenter);
    
    CGPoint targetContentOffset = CGPointMake(proposedContentOffset.x + minDistanceToCenter, proposedContentOffset.y);
    return targetContentOffset;
}

#pragma mark - Other Helper Method
#pragma mark 获取哪个cell离屏幕中心最近，即当前屏幕中心滚动停止后要显示的cell的index的方法2
/*
 *  获取哪个cell离屏幕中心最近，即当前屏幕中心滚动停止后要显示的cell的index（使用场景：目前仅使用于滑动UIScrollViewDelegate结束后中心需要自动滚动到某个位置）
 *
 *  @brief  scrollViewDidEndDragging:拖动结束时候调用
 *  @brief  scrollViewDidEndDecelerating:减速停止时候调用(scrollViewDidEndDragging后如果还有滚动，也会在滚动结束后调用到此方法)
 *
 *  @return 获取哪个cell离屏幕中心最近，即当前屏幕中心滚动停止后要显示的cell的index
 */
- (NSIndexPath *)indexPathForCloseToCenterItem {
    UICollectionView *collectionView = self.collectionView;
    CGFloat centerContentOffsetX = collectionView.contentOffset.x + CGRectGetWidth(collectionView.frame)/2;
    CGFloat centerContentOffsetY = collectionView.contentOffset.y + CGRectGetHeight(collectionView.frame)/2;
    CGPoint point = CGPointMake(centerContentOffsetX, centerContentOffsetY);
    
    NSIndexPath *indexPathAtCenter = [self indexPathForItemAtPoint:point];
    return indexPathAtCenter;
}

/*
 *  获取某个点上显示的是哪个位置的cell
 *
 *  @param atPoint      要计算的点
 *
 *  @return 该点显示的位置
 */
- (NSIndexPath *)indexPathForItemAtPoint:(CGPoint)atPoint {
    //return [self.collectionView indexPathForItemAtPoint:atPoint];
    
    // [UIScrollView的delegate方法妙用之让UICollectionView滑动到某个你想要的位置](https://www.cnblogs.com/Phelthas/p/4584645.html)
    // 在scrollViewDidEndDecelerating或其他delegate方法里，通过当前 contentOffset 计算最近的整数页及其对应的 contentOffset，然后通过动画移动到这个位置。但是这个做法有问题，就是动画不连贯，完全没有“刚好停到那里”的感觉。
    
    UICollectionView *collectionView = self.collectionView;
    UICollectionViewFlowLayout *flowLayout = collectionView.collectionViewLayout;
    
    CGFloat itemSizeWidth = flowLayout.itemSize.width;
    CGFloat itemSpace = flowLayout.minimumLineSpacing; // 水平滚动时候的item列间距
    CGFloat pageWidth = itemSizeWidth+itemSpace;
    
    CGFloat index0OriginXBegin = flowLayout.sectionInset.left; // index0开始计算originX的起点
    // 算式：
    // CGFloat targetIndexOriginX = index0OriginXBegin + indexAtPoint * pageWidth;
    // targetIndexOriginX >= point.x;
    // 计算得到如下：
    NSInteger indexAtPoint = (atPoint.x - index0OriginXBegin) / pageWidth;
    //NSLog(@"当前中间应该显示的item的index为%ld", indexAtPoint);
    
    NSIndexPath *indexPathAtPoint = [NSIndexPath indexPathForItem:indexAtPoint inSection:0];
    return indexPathAtPoint;
}

@end
