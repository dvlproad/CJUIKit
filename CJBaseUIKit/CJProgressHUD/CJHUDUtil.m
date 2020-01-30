//
//  CJHUDUtil.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/20.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJHUDUtil.h"

@interface CJHUDUtil () {
    
}

@end


@implementation CJHUDUtil

#pragma mark - 全局设置(APP启动时候调用)
+ (void)updateAnimationNamed:(NSString *)animationNamed {
    CJProgressHUD *progressHUD = [CJProgressHUD sharedInstance];
    [progressHUD updateAnimationNamed:animationNamed];
}

#pragma mark - 获取与全局动画一致的ProgressHUD
/**
 *  获取与全局动画一致的默认的ProgressHUD
 */
+ (CJProgressHUD *)defaultProgressHUD {
    return [CJProgressHUD defaultProgressHUD];
}


#pragma mark - 使用时候调用
+ (void)show {
    // Partner 需要 showBackground
    [[CJProgressHUD sharedInstance] showInView:nil withShowBackground:YES];
}

+ (void)dismiss {
    [[CJProgressHUD sharedInstance] dismissWithForce:YES];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
