//
//  CJProgressHUD.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/20.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  加载进度视图

#import <UIKit/UIKit.h>
#import <Lottie/Lottie.h>

@interface CJProgressHUD : UIView {
    
}
@property (nonatomic, strong) LOTAnimationView *lotAnimationView;


- (instancetype)initWithAnimationNamed:(NSString *)animationNamed NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

/**
*  显示HUD
*
*  @param superView                要添加到的视图
*  @param showBackground    YES:加载过程无法进行其他操作，NO:加载过程可进行其他操作
*/
- (void)showInView:(UIView *)superView withShowBackground:(BOOL)showBackground;

/**
 *  隐藏HUD(若非强制隐藏，则需要显示次数与隐藏次数一致时候才隐藏)
 *
 *  @param force 是否强制隐藏
 *
 *  return 执行完后是否就成功隐藏了
 */
- (BOOL)dismissWithForce:(BOOL)force;


@end
