//
//  CJIndicatorProgressHUDView.h
//  AppCommonUICollect
//
//  Created by ciyouzen on 2018/9/20.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJIndicatorProgressHUDView : UIView {
    
}

/**
 *  创建单例
 *
 *  @return 单例
 */
+ (CJIndicatorProgressHUDView *)sharedInstance;


#pragma mark - Event
- (void)reloadWithLoadingAndMessage:(NSString *)message;
- (void)reloadWithMessage:(NSString *)message image:(UIImage *)image;

@end
