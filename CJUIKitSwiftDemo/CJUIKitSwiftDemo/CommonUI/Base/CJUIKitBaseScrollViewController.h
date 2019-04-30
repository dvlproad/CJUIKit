//
//  CJUIKitBaseScrollViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "CJUIKitBaseViewController.h"

@interface CJUIKitBaseScrollViewController : CJUIKitBaseViewController {
    
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *containerView;

/**
 *  更新ScrollView的高
 *  @brief  ①如果没有lastBottomView来确认scrollView的高，那么高为根据父视图设置；
 ②如果有lastBottomView，则通过设置scrollView的containerView与lastBottomView的底部间隔来更新ScrollView的高
 *
 *  @param bottomInterval bottomInterval
 *  @param lastBottomView lastBottomView(可为nil)
 */
- (void)updateScrollHeightWithBottomInterval:(CGFloat)bottomInterval
                   accordingToLastBottomView:(UIView *)lastBottomView;

@end
