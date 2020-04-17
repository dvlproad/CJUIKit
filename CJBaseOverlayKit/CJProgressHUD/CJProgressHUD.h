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

@end
