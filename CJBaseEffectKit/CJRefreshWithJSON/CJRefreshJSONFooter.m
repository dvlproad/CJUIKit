//
//  CJRefreshJSONFooter.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/20.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJRefreshJSONFooter.h"
#import "UIColor+CJHex.h"

#import "CJRefreshJSONSettingManager.h"

@interface CJRefreshJSONFooter() {
    
}
@property (nonatomic, copy) NSString *idleText;       /** 普通闲置状态：@"上拉加载更多" */
@property (nonatomic, copy) NSString *pullingText;    /** 松开就可以进行刷新的状态：@"释放加载" */
@property (nonatomic, copy) NSString *refreshingText; /** 正在刷新中的状态：@"加载中..." */
@property (nonatomic, copy) NSString *noMoreDataText; /** 所有数据加载完毕，没有更多的数据了：@"没有更多数据了..." */

@end




@implementation CJRefreshJSONFooter

#pragma mark - 构造方法（原本重写）
+ (instancetype)footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock
{
    return [self footerWithIdleText:[CJRefreshJSONSettingManager sharedInstance].footerIdleText
                        pullingText:[CJRefreshJSONSettingManager sharedInstance].footerPullingText
                     refreshingText:[CJRefreshJSONSettingManager sharedInstance].footerRefreshingText
                     noMoreDataText:[CJRefreshJSONSettingManager sharedInstance].footerNoMoreDataText
                    refreshingBlock:refreshingBlock];
}

+ (instancetype)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    return [self footerWithIdleText:[CJRefreshJSONSettingManager sharedInstance].footerIdleText
                        pullingText:[CJRefreshJSONSettingManager sharedInstance].footerPullingText
                     refreshingText:[CJRefreshJSONSettingManager sharedInstance].footerRefreshingText
                     noMoreDataText:[CJRefreshJSONSettingManager sharedInstance].footerNoMoreDataText
                   refreshingTarget:target
                   refreshingAction:action];
}

#pragma mark - 构造方法（新增）
+ (instancetype)footerWithIdleText:(NSString *)idleText
                       pullingText:(NSString *)pullingText
                    refreshingText:(NSString *)refreshingText
                    noMoreDataText:(NSString *)noMoreDataText
                   refreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock
{
    CJRefreshJSONFooter *cmp = [[self alloc] init];
    cmp.idleText = idleText;
    cmp.pullingText = pullingText;
    cmp.refreshingText = refreshingText;
    cmp.noMoreDataText = noMoreDataText;
    cmp.refreshingBlock = refreshingBlock;
    
    return cmp;
}


+ (instancetype)footerWithIdleText:(NSString *)idleText
                       pullingText:(NSString *)pullingText
                    refreshingText:(NSString *)refreshingText
                    noMoreDataText:(NSString *)noMoreDataText
                  refreshingTarget:(id)target
                  refreshingAction:(SEL)action
{
    CJRefreshJSONFooter *cmp = [[self alloc] init];
    cmp.idleText = idleText;
    cmp.pullingText = pullingText;
    cmp.refreshingText = refreshingText;
    cmp.noMoreDataText = noMoreDataText;
    [cmp setRefreshingTarget:target refreshingAction:action];
    return cmp;
}




- (instancetype)init {
    self = [super init];
    if (self) {
        _idleText = @"上拉加载更多";
        _pullingText = @"释放加载";
        _refreshingText = @"加载中...";
        _noMoreDataText = @"没有更多数据了...";
    }
    return self;
}


#pragma mark - 重写父类的方法
- (void)prepare
{
    [super prepare];
    self.stateLabel.font = [UIFont systemFontOfSize:15.0f];
    self.stateLabel.textColor = CJColorFromHexString(@"#999999");
    
//    [self setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
//    [self setTitle:@"释放加载" forState:MJRefreshStatePulling];
//    [self setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
//    [self setTitle:@"没有更多数据了..." forState:MJRefreshStateNoMoreData];
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;

    switch (state) {
        case MJRefreshStateIdle:
        {
            self.stateLabel.text = self.idleText;
            break;
        }
        case MJRefreshStatePulling:
        {
            self.stateLabel.text = self.pullingText;
            break;
        }
        case MJRefreshStateRefreshing:
        {
            self.stateLabel.text = self.refreshingText;
            break;
        }
        case MJRefreshStateNoMoreData:
        {
            self.stateLabel.text = self.noMoreDataText;
            break;
        }
        default:
            break;
    }
}

@end
