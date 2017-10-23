//
//  CJHeadAndCellHorizontalLayout.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/10/8.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  自定义横向滑动的Layout，含Header(如MTU的美颜选项)
 */
@interface CJHeadAndCellHorizontalLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) CGFloat lineHeight;   // 线和文字所在LineCell的高度
@property (nonatomic, assign) CGFloat distanceItemAndLine; // Item和LineCell的距离，可正负

@end
