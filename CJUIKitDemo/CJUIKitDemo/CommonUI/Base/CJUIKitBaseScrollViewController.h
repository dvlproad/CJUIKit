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

- (void)updateScrollHeightWithLastBottomView:(UIView *)lastBottomView bottom:(CGFloat)bottom;

@end
