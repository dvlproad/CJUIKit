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
@property (nonatomic, strong) UIScrollView *scrollView; /**< 当前视图被添加到的滚动视图 */
@property (nonatomic, assign) CGFloat originHeight;  /**< 初始高度 */
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

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    [self.superview removeObserver:self forKeyPath:@"contentOffset" context:nil];
    
    if (newSuperview && [newSuperview isKindOfClass:[UIScrollView class]]) {
        [newSuperview addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];

        _scrollView = (UIScrollView *)newSuperview; //记录UIScrollView
        _scrollView.alwaysBounceVertical = YES;     //并设置UIScrollView永远支持垂直弹簧效果
    }
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
 *  调用该方法，使得本view可以自适应ScrollView（常用在scrollView的frame大小变化的时候）
 *
 *  @param distanceToTop    scrollView显示区域到顶部的距离
 */
- (void)adjustViewToScrollViewWhenViewDidLayoutSubviews:(CGFloat)distanceToTop {
    self.originHeight = CGRectGetHeight(self.frame);
    self.originY = -self.originHeight + distanceToTop;
    
    CGRect frame = self.frame;
    frame.origin.y = self.originY;
    frame.size.width = CGRectGetWidth(_scrollView.frame);
    self.frame = frame;
}

/**
 *  根据UIScrollView的contentOffset调整headView的frame大小
 */
- (void)adjustViewToScrollViewContentOffset {
    CGFloat offsetY = _scrollView.contentOffset.y + self.originHeight;
    if(offsetY < 0 ) {
        CGFloat pullDownHeight = -offsetY;
        NSLog(@"pullDownHeight = %.1f", pullDownHeight);
        
        CGRect frame = self.frame;
        frame.origin.y = self.originY - pullDownHeight ; //本view在scrollView中的位置要上移
        frame.size.height = self.originHeight + pullDownHeight;//本view在scrollView中的高度要增加
        frame.size.width = CGRectGetWidth(_scrollView.frame);
        self.frame = frame;
    } else {
        CGFloat pullUpHeight = offsetY;
        NSLog(@"pullUpHeight = %.1f", pullUpHeight);
        
        if (pullUpHeight <= 136) {
            
        } else {
            pullUpHeight = 136;
        }
        
        CGRect frame = self.frame;
        frame.origin.y = self.originY + pullUpHeight ;
        frame.size.height = self.originHeight - pullUpHeight;
        frame.size.width = CGRectGetWidth(_scrollView.frame);
        self.frame = frame;
        
//        [self adjustViewToScrollViewWhenViewDidLayoutSubviews:64];
    }
    NSLog(@"%@", NSStringFromCGRect(self.frame));
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
