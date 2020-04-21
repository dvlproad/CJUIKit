//
//  CJRefreshJSONFooter.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/20.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface CJRefreshJSONFooter : MJRefreshAutoStateFooter

#pragma mark - 构造方法（新增）
+ (instancetype)footerWithIdleText:(NSString *)idleText
                       pullingText:(NSString *)pullingText
                    refreshingText:(NSString *)refreshingText
                    noMoreDataText:(NSString *)noMoreDataText
                   refreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;

+ (instancetype)footerWithIdleText:(NSString *)idleText
                       pullingText:(NSString *)pullingText
                    refreshingText:(NSString *)refreshingText
                    noMoreDataText:(NSString *)noMoreDataText
                  refreshingTarget:(id)target
                  refreshingAction:(SEL)action;


@end
