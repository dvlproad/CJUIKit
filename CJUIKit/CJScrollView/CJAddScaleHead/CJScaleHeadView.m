//
//  CJScaleHeadView.m
//  CJUIKitDemo
//
//  Created by 李超前 on 2017/5/16.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJScaleHeadView.h"

static NSString *const CorePullScaleContentOffset = @"contentOffset";

@interface CJScaleHeadView () {

}
@property (nonatomic, assign) CGFloat originY;       /**< 初始Y */

@end


@implementation CJScaleHeadView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self commonInit];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}


- (void)commonInit {
    self.clipsToBounds = YES;   //剪切多余部分
}

- (void)dealloc {
     [_scrollView removeObserver:self forKeyPath:@"contentOffset" context:nil];
}

- (void)setScrollView:(UIScrollView *)scrollView {
    if (_scrollView) {
        [_scrollView removeObserver:self forKeyPath:@"contentOffset" context:nil];
    }
    
    _scrollView = scrollView;
    
    scrollView.alwaysBounceVertical = YES;     //并设置UIScrollView永远支持垂直弹簧效果
    [scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil]; //观察者是self
    
    
    CGFloat scaleHeadViewHeight = CGRectGetHeight(self.frame);
    
    //设置contentInset
    UIEdgeInsets contentInset = scrollView.contentInset;
    contentInset.top += scaleHeadViewHeight;
    scrollView.contentInset = contentInset;
    
    //设置contentOffset
    CGPoint contentOffset = scrollView.contentOffset;
    contentOffset.y -= scaleHeadViewHeight;
    scrollView.contentOffset = contentOffset;
    
    self.originHeight = scaleHeadViewHeight;
    self.originY = -self.originHeight;
    NSLog(@"originHeight = %1.f, originY = %.1f", self.originHeight, self.originY);
}

#pragma mark - 监听属性变化
//监听UIScrollView的contentOffset属性，根据contentOffset来调整headView的frame大小
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([@"contentOffset" isEqualToString:keyPath]) {
        [self adjustViewToScrollViewContentOffset];
    }
}

/**
 *  根据UIScrollView的contentOffset调整headView的frame大小
 */
- (void)adjustViewToScrollViewContentOffset {
    CGFloat offsetY = _scrollView.contentOffset.y + _scrollView.contentInset.top;
    //NSLog(@"offsetY = %.1f, insetTop = %.1f", offsetY, _scrollView.contentInset.top);
    
    CGRect frame = self.frame;
    if (self.superview == self.scrollView) { //如果self是被添加到scrollView上，则还需改变y
        frame.origin.y = self.originY + offsetY;
    }
    
    CGFloat height = self.originHeight - offsetY;
    if (height < self.pullUpMinHeight) {
        height = self.pullUpMinHeight;
    }
    frame.size.height = height;
    
    frame.size.width = CGRectGetWidth(self.scrollView.frame);
    self.frame = frame;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
