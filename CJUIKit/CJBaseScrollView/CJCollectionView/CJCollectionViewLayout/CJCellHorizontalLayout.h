//
//  CJCellHorizontalLayout.h
//  AllScrollViewDemo
//
//  Created by ciyouzen on 16-5-30.
//  Copyright (c) 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  在水平滑动下，可以让cell按行排列的布局(常用来实现QQ表情键盘或者微信表情键盘等)
 */
@interface CJCellHorizontalLayout : UICollectionViewLayout

@property (nonatomic, assign) CGFloat minimumLineSpacing;       /**< 行间距 */
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;  /**< item间距 */
@property (nonatomic, assign) CGSize itemSize;                  /**< item大小 */
@property (nonatomic, assign) UIEdgeInsets sectionInset;        /**< sectionInset */

- (instancetype)init;

@end
