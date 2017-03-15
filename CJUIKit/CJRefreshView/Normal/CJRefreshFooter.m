//
//  CJRefreshFooter.m
//  CJRefreshBaseView
//
//  Created by dvlproad on 15-2-22.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import "CJRefreshFooter.h"
#import "UIView+CJExtension.h"

@implementation CJRefreshFooter
{
    CGFloat _originalScrollViewContentHeight;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textForNormalState = @"上拉可以加载最新数据";
        self.stateIndicatorViewNormalTransformAngle = M_PI;
        self.stateIndicatorViewWillRefreshStateTransformAngle = 0;
        [self setRefreshState:CJRefreshBaseViewStateNormal];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.activityIndicatorView.hidden = YES;
    _originalScrollViewContentHeight = self.scrollView.contentSize.height;
    self.center = CGPointMake(self.scrollView.sd_width * 0.5, self.scrollView.contentSize.height + self.sd_height * 0.5); // + self.scrollView.contentInset.bottom
    
    self.hidden = [self shouldHide];
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    self.scrollViewEdgeInsets = UIEdgeInsetsMake(0, 0, self.sd_height, 0);
}

- (BOOL)shouldHide
{
    if (self.isEffectedByNavigationController) {
        return (self.scrollView.bounds.size.height - SDKNavigationBarHeight > self.sd_y); //  + self.scrollView.contentInset.bottom
    }
    return (self.scrollView.bounds.size.height> self.sd_y); // + self.scrollView.contentInset.bottom
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (![keyPath isEqualToString:CJRefreshBaseViewObservingkeyPath] || self.refreshState == CJRefreshBaseViewStateRefreshing) return;
    
    CGFloat y = [change[@"new"] CGPointValue].y;
    CGFloat criticalY = self.scrollView.contentSize.height - self.scrollView.sd_height + self.sd_height + self.scrollView.contentInset.bottom;
    
    // 如果scrollView内容有增减，重新调整refreshFooter位置
    if (self.scrollView.contentSize.height != _originalScrollViewContentHeight) {
        [self layoutSubviews];
    }
    
    // 只有在 y>0 以及 scrollview的高度不为0 时才判断
    if ((y <= 0) || (self.scrollView.bounds.size.height == 0)) return;
    
    // 触发CJRefreshBaseViewStateRefreshing状态
    if (y <= criticalY && (self.refreshState == CJRefreshBaseViewStateWillRefresh) && !self.scrollView.isDragging) {
        [self setRefreshState:CJRefreshBaseViewStateRefreshing];
        return;
    }
    
    // 触发CJRefreshBaseViewStateWillRefresh状态
    if (y > criticalY && (CJRefreshBaseViewStateNormal == self.refreshState)) {
        if (self.hidden) return;
        [self setRefreshState:CJRefreshBaseViewStateWillRefresh];
        return;
    }
    
    if (y <= criticalY && self.scrollView.isDragging && (CJRefreshBaseViewStateNormal != self.refreshState)) {
        [self setRefreshState:CJRefreshBaseViewStateNormal];
    }
    

}

@end
