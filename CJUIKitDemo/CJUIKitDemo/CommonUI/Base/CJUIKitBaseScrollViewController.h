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

/// 更新containerView与lastBottomView的底部间隔，未调用时containerView的高为比scrollView多1像素
- (void)updateScrollHeightWithLastBottomView:(UIView *)lastBottomView bottom:(CGFloat)bottom;

@end
