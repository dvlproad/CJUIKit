//
//  CQHUDUtil.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/20.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CQHUDUtil.h"

@interface CQHUDUtil () {
    
}

@end


@implementation CQHUDUtil

#pragma mark - 使用时候调用
+ (void)showProgressHUD {
    // 加载时候不能进行其他操作，故设showBackground为YES
    [[self sharedProgressHUD] showInView:nil withShowBackground:YES];
}

+ (void)dismissProgressHUD {
    [[self sharedProgressHUD] dismissWithForce:YES];
}


+ (CJProgressHUD *)sharedProgressHUD {
    static CJProgressHUD *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[CJProgressHUD alloc] init];
    });
    return _sharedInstance;
}


#pragma mark - 获取与全局动画一致的ProgressHUD对象
/**
 *  获取与全局动画一致的新的的ProgressHUD对象
 */
+ (CJProgressHUD *)defaultProgressHUD {
    return [[CJProgressHUD alloc] init];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
