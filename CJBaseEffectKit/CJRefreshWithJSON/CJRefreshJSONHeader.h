//
//  CJRefreshJSONHeader.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/3/15.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface CJRefreshJSONHeader : MJRefreshHeader {
    
}

#pragma mark - 构造方法（新增）
+ (instancetype)headerWithAnimationNamed:(NSString *)animationNamed
                         animationBundle:(NSBundle *)animationBundle
                                idleText:(NSString *)idleText
                             pullingText:(NSString *)pullingText
                          refreshingText:(NSString *)refreshingText
                         refreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;

+ (instancetype)headerWithAnimationNamed:(NSString *)animationNamed
                         animationBundle:(NSBundle *)animationBundle
                                idleText:(NSString *)idleText
                             pullingText:(NSString *)pullingText
                          refreshingText:(NSString *)refreshingText
                        refreshingTarget:(id)target
                        refreshingAction:(SEL)action;

@end
