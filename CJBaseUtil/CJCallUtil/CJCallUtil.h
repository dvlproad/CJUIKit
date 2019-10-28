//
//  CJCallUtil.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/23.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

///调用系统服务的类(包括拨打电话等)
@interface CJCallUtil : NSObject

/**
 *  显示拨打电话视图
 *
 *  @param phoneNum 要拨打的电话号码
 *  @param atView   在什么视图中展示
 */
+ (void)showCallViewWithPhone:(NSString *)phoneNum atView:(UIView *)atView;

/// 隐藏拨打电话视图
+ (void)hideCallView;

/**
 *  拨打电话
 *
 *  @param phone    要拨打的电话
 */
+ (void)callPhone:(NSString *)phone;

@end
