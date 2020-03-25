//
//  TSAlertManager.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSAlertManager : NSObject {
    
}
+ (TSAlertManager *)sharedInstance;

///显示和隐藏网络权限没打开的alert
- (void)showNetworkNoOpenAlert:(BOOL)show;

@end
