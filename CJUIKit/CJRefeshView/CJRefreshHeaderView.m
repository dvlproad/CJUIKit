//
//  CJRefreshHeaderView.m
//  CJRefreshView
//
//  Created by dvlproad on 15-2-22.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import "CJRefreshHeaderView.h"
#import "UIView+CJExtension.h"

@implementation CJRefreshHeaderView
{
    BOOL _hasLayoutedForManuallyRefreshing;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textForNormalState = @"下拉可以加载最新数据";
        self.stateIndicatorViewNormalTransformAngle = 0;
        self.stateIndicatorViewWillRefreshStateTransformAngle = M_PI;
        [self setRefreshState:CJRefreshViewStateNormal];
    }
    return self;
}

- (CGFloat)yOfCenterPoint
{
    //    if (self.isManuallyRefreshing && self.isEffectedByNavigationController && CJRefreshViewMethodIOS7) {
    //        return - (self.sd_height * 0.5 + self.originalEdgeInsets.top - SDKNavigationBarHeight);
    //    }
    return - (self.sd_height * 0.5);
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    self.scrollViewEdgeInsets = UIEdgeInsetsMake(self.frame.size.height, 0, 0, 0);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.center = CGPointMake(self.scrollView.sd_width * 0.5, [self yOfCenterPoint]);
    
    // 手动刷新
    if (self.isManuallyRefreshing && !_hasLayoutedForManuallyRefreshing && self.scrollView.contentInset.top > 0) {
        self.activityIndicatorView.hidden = NO;
        
        // 模拟下拉操作
        CGPoint temp = self.scrollView.contentOffset;
        temp.y -= self.sd_height * 2;
        self.scrollView.contentOffset = temp; // 触发准备刷新
        temp.y += self.sd_height;
        self.scrollView.contentOffset = temp; // 触发刷新
        
        _hasLayoutedForManuallyRefreshing = YES;
    } else {
        self.activityIndicatorView.hidden = !self.isManuallyRefreshing;
    }
}

- (void)autoRefreshWhenViewDidAppear
{
    self.isManuallyRefreshing = YES;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (![keyPath isEqualToString:CJRefreshViewObservingkeyPath] || self.refreshState == CJRefreshViewStateRefreshing) return;
    
    CGFloat y = [change[@"new"] CGPointValue].y;
    CGFloat criticalY = -self.sd_height - self.scrollView.contentInset.top;
    
    // 只有在 y<=0 以及 scrollview的高度不为0 时才判断
    if ((y > 0) || (self.scrollView.bounds.size.height == 0)) return;
    
    // 触发CJRefreshViewStateRefreshing状态
    if (y <= criticalY && (self.refreshState == CJRefreshViewStateWillRefresh) && !self.scrollView.isDragging) {
        [self setRefreshState:CJRefreshViewStateRefreshing];
        return;
    }
    
    // 触发CJRefreshViewStateWillRefresh状态
    if (y < criticalY && (CJRefreshViewStateNormal == self.refreshState)) {
        [self setRefreshState:CJRefreshViewStateWillRefresh];
        return;
    }
    
    if (y > criticalY && self.scrollView.isDragging && (CJRefreshViewStateNormal != self.refreshState)) {
        [self setRefreshState:CJRefreshViewStateNormal];
    }
}

@end
