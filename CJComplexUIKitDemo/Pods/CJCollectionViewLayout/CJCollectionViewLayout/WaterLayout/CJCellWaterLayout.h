//
//  CJCellWaterLayout.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 16-5-30.
//  Copyright (c) 2016年 dvlproad. All rights reserved.
//
//  系统布局是将 item 两端对齐，间距根据剩余的宽度自己缩放。UICollectionViewFlowLayout对象的minimumInteritemSpacing说的很清楚，我们设置的是最小间距。但是 UI 小姐姐希望间距相等，这个时候系统的布局就实现不了了。

#import <UIKit/UIKit.h>

/**
 *  在水平滑动下，可以让cell按行排列的布局(常用来实现QQ表情键盘或者微信表情键盘等)
 */
@interface CJCellWaterLayout : UICollectionViewFlowLayout

@end
