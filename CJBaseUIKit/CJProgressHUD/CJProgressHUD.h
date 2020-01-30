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
@property (nonatomic, copy, readonly) NSString *animationNamed;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

+ (CJProgressHUD *)sharedInstance;

/**
 *  设置全局ProgressHUD的json文件名
 *
 *  @param animationNamed animationNamed
 */
- (void)updateAnimationNamed:(NSString *)animationNamed;


#pragma mark - 获取与全局动画一致的ProgressHUD
/**
 *  获取与全局动画一致的默认的ProgressHUD
 */
+ (CJProgressHUD *)defaultProgressHUD;





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
