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
@property (nonatomic, strong, readonly) UIScrollView *scrollView; /**< 当前视图被添加到的滚动视图 */
@property (nonatomic, assign, readonly) BOOL attachNavigationBar;  /**< 滚动视图是否会依附在导航栏上 */
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
    
    //事件监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenRotate) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)dealloc {
     [_scrollView removeObserver:self forKeyPath:@"contentOffset" context:nil];
}

- (void)pullScaleByScrollView:(UIScrollView *)scrollView withAttachNavigationBar:(BOOL)attachNavigationBar {
    //①scrollView
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
    
    
    //②attachNavigationBar
    _attachNavigationBar = attachNavigationBar;
    
    [self resetNavigationBarHeight];
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


/**
 *  屏幕旋转
 */
- (void)screenRotate {
    [self resetNavigationBarHeight];
}

/** 完整的描述请参见文件头部 */
- (void)resetNavigationBarHeight {
    if (!_attachNavigationBar) {
        _pullUpMinHeight = 0;
        return;
    }
    
    UIViewController *viewController = [self getBelongViewControllerForView:self];
    NSAssert(viewController != nil, @"请确保视图已经被添加到某个视图上");
    
    CGFloat navigationBarHeight = viewController.navigationController.navigationBar.bounds.size.height;
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat statusBarHeight = CGRectGetHeight(statusBarFrame);
    //CGFloat systemVersion = [UIDevice currentDevice].systemVersion.floatValue;
    
    _pullUpMinHeight = navigationBarHeight + statusBarHeight;
}

- (nullable UIViewController *)getBelongViewControllerForView:(UIView *)view {
    UIResponder *responder = view;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]]) {
            return (UIViewController *)responder;
        }
    return nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
