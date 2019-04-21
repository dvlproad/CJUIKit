//
//  DataEmptyViewFactory.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "DataEmptyViewFactory.h"
#import "AppInfoManager.h"

@implementation DataEmptyViewFactory

/**
 *  网络空视图
 *
 *  @param successReloadBlock 网络有效时候的reload操作
 *
 *  @return 空视图
 */
+ (CJDataEmptyView *)networkEmptyViewWithSuccess:(void(^)(void))successReloadBlock {
    CJDataEmptyView *emptyView = [[CJDataEmptyView alloc] init];
    emptyView.image = [UIImage imageNamed:@"currency_icon_network"];
    emptyView.title = NSLocalizedString(@"数据加载失败，请重新加载...", nil);
    emptyView.buttonTitle = NSLocalizedString(@"刷新", nil);
    emptyView.reloadBlock = ^(CJDataEmptyView *m_emptyView) {
        BOOL networkEnable = [AppInfoManager sharedInstance].networkEnable;
        if (!networkEnable) {
            [SVProgressHUD show];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                sleep(1);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    
                    NSString *failureMessage = NSLocalizedString(@"请检查您的手机是否联网", nil);
                    m_emptyView.message = failureMessage;
                    m_emptyView.hidden = NO;
                });
            });
            return;
        }
        
        !successReloadBlock ?: successReloadBlock();
    };
    
    return emptyView;
}

@end
