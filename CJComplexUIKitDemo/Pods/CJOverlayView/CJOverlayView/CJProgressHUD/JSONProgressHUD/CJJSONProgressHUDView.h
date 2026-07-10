//
//  CJJSONProgressHUDView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/20.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  加载进度视图

#import <UIKit/UIKit.h>
#import <CQBridgeSTOLottie/LOTAnimationView.h>
#import <Lottie/Lottie-Swift.h>

@interface CJJSONProgressHUDView : UIView {
    
}
@property (nonatomic, strong) LOTAnimationView *lotAnimationView;


/*
*  初始化加载HUD
*
*  @param animationNamed    动画对应的json文件名
*  @param animationBundle   动画对应的json文件所在的bundle(如果是在MainBundle中，则可直接设为nil)
*
*  @return 加载HUD
*/
- (instancetype)initWithAnimationNamed:(NSString *)animationNamed
                              inBundle:(NSBundle *)animationBundle NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;


@end
