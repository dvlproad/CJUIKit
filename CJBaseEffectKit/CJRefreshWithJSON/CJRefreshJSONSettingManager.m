//
//  CJRefreshJSONSettingManager.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/3/15.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CJRefreshJSONSettingManager.h"

@interface CJRefreshJSONSettingManager() {
    
}

@end



@implementation CJRefreshJSONSettingManager

+ (CJRefreshJSONSettingManager *)sharedInstance {
    static CJRefreshJSONSettingManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _headerIdleText = @"下拉刷新";
        _headerPullingText = @"松开刷新";
        _headerRefreshingText = @"加载数据中";

        _footerIdleText = @"上拉加载更多";
        _footerPullingText = @"释放加载";
        _footerRefreshingText = @"加载中...";
        _footerNoMoreDataText = @"没有更多数据了...";
    }
    return self;
}

#pragma mark - HEADER
- (void)configHeaderAnimationWithAnimationNamed:(NSString *)animationNamed {
    _animationNamed = animationNamed;
}

- (void)updateHeaderStateTextWithIdleText:(NSString *)idleText
                              pullingText:(NSString *)pullingText
                           refreshingText:(NSString *)refreshingText
{
    _headerIdleText = idleText;
    _headerPullingText = pullingText;
    _headerRefreshingText = refreshingText;
}


#pragma mark - FOOTER
- (void)updateFooterStateTextWithIdleText:(NSString *)idleText
                              pullingText:(NSString *)pullingText
                           refreshingText:(NSString *)refreshingText
                           noMoreDataText:(NSString *)noMoreDataText
{
    _footerIdleText = idleText;
    _footerPullingText = pullingText;
    _footerRefreshingText = refreshingText;
    _footerNoMoreDataText = noMoreDataText;
}


@end
