//
//  CJScaleHeadView.h
//  CJUIKitDemo
//
//  Created by 李超前 on 2017/5/16.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJScaleHeadView : UIView

/**
 *  调用该方法，使得本view可以自适应ScrollView（常用在scrollView的frame大小变化的时候）
 *
 *  @param distanceToTop    scrollView显示区域到顶部的距离
 */
- (void)adjustViewToScrollViewWhenViewDidLayoutSubviews:(CGFloat)distanceToTop;

@end
