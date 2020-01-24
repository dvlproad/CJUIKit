//
//  CJRefreshHeader.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2019/3/15.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CJRefreshHeader.h"
#import <Lottie/Lottie.h>
#import "CJRefreshAnimateManager.h"

static const CGFloat loadingViewY = 20;
static const CGFloat loadingViewWidth = 32;
static const CGFloat loadingViewHeight = 32;
//static NSString * const lotPullingFileName = @"loading_01";
//static NSString * const lotRefreshingFileName = @"loading_02";

@interface CJRefreshHeader() {
    
}
@property (nonatomic, strong) LOTAnimationView *lotAnimationView;
@property (nonatomic, weak) UILabel *stateLabel;

@property (nonatomic, copy) NSString *animationNamed;

@end

@implementation CJRefreshHeader

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 20+50+20;
    
    // 添加动画
//    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CommonUIBundle" ofType:@"bundle"];
//    NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
//    //NSBundle *resourceBundle2 = [NSBundle bundleForClass:[CQProgressHUD class]]; //错误的取值，取不全
//    _lotAnimationView = [LOTAnimationView animationNamed:@"loading_test" inBundle:resourceBundle];
    NSString *headerAnimationNamed = [CJRefreshAnimateManager sharedInstance].animationNamed;
    if (headerAnimationNamed.length == 0) {
        NSAssert(NO, @"Error: 请在app启动时候调用[CJRefreshAnimateManager sharedInstance].animationNamed = 来设置全局的RefreshHeader动画");
    }
    _lotAnimationView = [LOTAnimationView animationNamed:headerAnimationNamed];
    _lotAnimationView.loopAnimation = YES;
    _lotAnimationView.backgroundColor = [UIColor clearColor];
    [self addSubview:_lotAnimationView];
    
    // 添加label
    UILabel *stateLabel = [[UILabel alloc] init];
    stateLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    stateLabel.font = [UIFont boldSystemFontOfSize:10];
    stateLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:stateLabel];
    self.stateLabel = stateLabel;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];

    CGFloat loadingY = loadingViewY;
    CGFloat loadingWidth = loadingViewWidth;
    CGFloat loadingHeight = loadingViewHeight;
    CGFloat loadingX = (self.bounds.size.width-loadingViewWidth)/2;
    self.lotAnimationView.frame = CGRectMake(loadingX, loadingY, loadingWidth, loadingHeight);
    
    CGFloat stateLabelY = loadingY + loadingHeight + 4;
    CGFloat stateLabelX = 30;
    CGFloat stateLabelWidth = self.bounds.size.width-2*stateLabelX;
    CGFloat stateLabelHeight = 14;
    self.stateLabel.frame = CGRectMake(stateLabelX, stateLabelY, stateLabelWidth, stateLabelHeight);
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;

    switch (state) {
        case MJRefreshStateIdle:
            [self.lotAnimationView stop];
            self.stateLabel.text = @"下拉刷新";
            break;
        case MJRefreshStatePulling:
            [self.lotAnimationView stop];
            self.stateLabel.text = @"松开刷新";
            break;
        case MJRefreshStateRefreshing:
            [self.lotAnimationView play];
            self.stateLabel.text = @"加载数据中";
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
//- (void)setPullingPercent:(CGFloat)pullingPercent
//{
//    [super setPullingPercent:pullingPercent];
//    
//    CGFloat alpha = 0.5 + (0.5*pullingPercent)/1;
//    self.lotAnimationView.alpha = alpha;
//    self.stateLabel.alpha = alpha;
//    
//    if (self.state == MJRefreshStateIdle) {
//        self.lotAnimationView.animationProgress = pullingPercent;
//    }
//}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

@end
