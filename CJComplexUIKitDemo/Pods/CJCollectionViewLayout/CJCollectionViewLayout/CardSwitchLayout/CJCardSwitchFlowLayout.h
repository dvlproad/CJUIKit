//
//  CJCardSwitchFlowLayout.h
//  TSImageFilterDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//
//  卡片切换布局

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJCardSwitchFlowLayout : UICollectionViewFlowLayout {
    
}
/**< 指定indexPath上的cell，当前的滑动进度的回调。使用场景：用于滑动结束后找到最靠近中心的左边cell，让其自动居中。其中参数isLeftOrCenter：是否已经滚动到左边(在中间也算)，currentLeftIsCloseToCenter：是否已经滚动到左边(在中间也算)，并且是否是最靠近中心的左边cell(此值只有当isLeftOrCenter为YES的时候才有效) */
@property (nullable, nonatomic, copy) void(^progressValueChangeBlock)(NSIndexPath *indexPath, CGFloat progress, BOOL isLeftOrCenter, BOOL currentLeftIsCloseToCenter);


/*
 *  初始化
 *
 *  @param centerItemSizeGetBlock   中心卡片相对collectionView视图的大小
 *
 *  @return 布局layout
 */
- (instancetype)initWithCenterItemSizeGetBlock:(CGSize(^ _Nonnull)(CGSize collectionViewSize))centerItemSizeGetBlock;

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
                            minimumLineSpacing:(CGFloat)minimumLineSpacing NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
