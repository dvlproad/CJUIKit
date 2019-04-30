//
//  DemoProgressHUD.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/20.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  加载进度视图
//  如果只使用 [DemoProgressHUD show]; 的时候，需考虑的情况有：
//  ①、不能会出现某个时刻会出现多个HUD，这个因为是单例，所以不会有这种情况；
//  ②、某个需加载很久的页面，在进入后，提前退出，需准时关闭该动画，不能还在显示；
//  ③、层次并列的A、B、C页面都需要HUD的时候，从A进入B，再回到A的时候，A的关闭是根据自身的，而不能因为在B中HUD的关闭，A就给关闭掉了；

#import <UIKit/UIKit.h>

@interface DemoProgressHUD : UIView {
    
}
/// 在superView上显示HUD
- (void)showInView:(UIView *)superView withShowBackground:(BOOL)showBackground;

/**
 *  隐藏HUD(若非强制隐藏，则需要显示次数与隐藏次数一致时候才隐藏)
 *
 *  @param force 是否强制隐藏
 *
 *  return 执行完后是否就成功隐藏了
 */
- (BOOL)dismissWithForce:(BOOL)force;

+ (void)show;

+ (void)dismiss;


@end
