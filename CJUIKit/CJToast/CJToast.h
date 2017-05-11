//
//  CJToast.h
//  CJUIKitDemo
//
//  Created by 李超前 on 2017/5/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>

//提示语的实现是通过给MBProgressHUD写一个类目方法。

@interface CJToast : NSObject

+ (void)showMessage:(NSString*)message;
+ (void)showMessage:(NSString *)message inView:(UIView *)view;


@end
