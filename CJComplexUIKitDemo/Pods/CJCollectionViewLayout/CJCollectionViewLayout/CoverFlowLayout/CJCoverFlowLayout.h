//
//  CJCoverFlowLayout.h
//  TSImageFilterDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//
//  封面浏览效果的布局

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJCoverFlowLayout : UICollectionViewFlowLayout {
    
}
@property (nonatomic, assign) BOOL shouldAutoCenter;    /**< 视图滚动停止后是否自动居中 */
//@property (nonatomic, assign) BOOL onlyOneItemPerDrag;  /**< 是否每次拖动最多只滚动一个cell */


#pragma mark - Init
/*
 *  初始化会自动缩放和改变透明度的封面浏览效果布局
 *
 *  @param centerItemSizeGetBlock   中心卡片相对collectionView视图的大小
 *
 *  @return 布局layout
 */
- (instancetype)initWithCenterItemSizeGetBlock:(CGSize(^ _Nonnull)(CGSize collectionViewSize))centerItemSizeGetBlock;

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
               configAttributesAtProgressBlock:(void(^ _Nullable)(UICollectionViewLayoutAttributes *attributes, CGFloat progress))configAttributesAtProgressBlock NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;



#pragma mark - Other Helper Method
/// 获取哪个cell离屏幕中心最近，即当前屏幕中心滚动停止后要显示的cell
- (NSIndexPath *)indexPathForCloseToCenterItem;

@end

NS_ASSUME_NONNULL_END
