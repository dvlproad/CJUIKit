//
//  CQAlertManager.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQAlertManager : NSObject {
    
}
+ (CQAlertManager *)sharedInstance;


///显示拨打电话的弹窗
- (void)showPhoneAlertWithPhone:(NSString *)phone;

///显示和隐藏网络权限没打开的alert
- (void)showNetworkNoOpenAlert:(BOOL)show;

///显示和隐藏定位权限没打开的alert
- (void)showLocationNoOpenAlert:(BOOL)show;

///显示和隐藏定位权限异常的alert
- (void)showLocationAbnormalAlert:(BOOL)show;

@end

NS_ASSUME_NONNULL_END
