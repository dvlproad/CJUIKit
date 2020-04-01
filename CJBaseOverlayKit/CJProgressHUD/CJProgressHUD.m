//
//  CJProgressHUD.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/20.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJProgressHUD.h"
#import <Masonry/Masonry.h>

@interface CJProgressHUD () {
    
}
@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, assign, readonly) NSInteger callShowMethodCount;
@property (nonatomic, assign, readonly) NSInteger callDismissMethodCount;

@end


@implementation CJProgressHUD


- (instancetype)initWithAnimationNamed:(NSString *)animationNamed {
    self = [super initWithFrame:CGRectZero];
    if(self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
        
        if (animationNamed == nil) {
            NSAssert(NO, @"Error: 请调[[CJHUDSettingManager sharedInstance] configHUDAnimationWithAnimationNamed: 来设置全局的ProgressHUD动画");
        }
        
        CGFloat lotAnimationViewHeight = 40;
        
        _lotAnimationView = [LOTAnimationView animationNamed:animationNamed];
        //[_lotAnimationView setAnimationNamed:animationNamed];
        _lotAnimationView.loopAnimation = YES;
        [self addSubview:_lotAnimationView];
        [_lotAnimationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.width.mas_equalTo(lotAnimationViewHeight);
            make.height.mas_equalTo(lotAnimationViewHeight);
        }];
        
        CGFloat width = [[UIScreen mainScreen] bounds].size.width;
        CGFloat height = [[UIScreen mainScreen] bounds].size.height;
        CGFloat x = (width - lotAnimationViewHeight)/2;
        CGFloat y = (height- lotAnimationViewHeight)/2;
        self.frame = CGRectMake(x, y, lotAnimationViewHeight, lotAnimationViewHeight);
    }
    return self;
}

/**
*  显示HUD
*
*  @param superView                要添加到的视图
*  @param showBackground    YES:加载过程无法进行其他操作，NO:加载过程可进行其他操作
*/
- (void)showInView:(UIView *)superView withShowBackground:(BOOL)showBackground {
    _callShowMethodCount++;
    if (superView == nil) {
        superView = [UIApplication sharedApplication].keyWindow;
    }
    
    if (showBackground) {
        CGFloat superViewWidth = CGRectGetWidth(superView.frame);
        CGFloat superViewHeight = CGRectGetHeight(superView.frame);
        
        if(self.bgView == nil){
            self.bgView = [[UIView alloc] init];
            self.bgView.backgroundColor = [UIColor clearColor];
        }
        self.bgView.frame = CGRectMake(0.0f, 0.0f, superViewWidth,  superViewHeight);
        [superView addSubview:self.bgView];
    }
    
    [superView addSubview:self];
    [self.lotAnimationView play];
}

/**
 *  隐藏HUD(若非强制隐藏，则需要显示次数与隐藏次数一致时候才隐藏)
 *
 *  @param force 是否强制隐藏
 *
 *  return 执行完后是否就成功隐藏了
 */
- (BOOL)dismissWithForce:(BOOL)force {
    _callDismissMethodCount++;
    
    BOOL shouldDismiss = YES;
    if (!force && _callDismissMethodCount < _callShowMethodCount) {
        shouldDismiss = NO;
    }
    
    if (shouldDismiss) {
        _callDismissMethodCount = 0;
        _callDismissMethodCount = 0;
        [self.lotAnimationView stop];
        [self removeFromSuperview];
        if (self.bgView) {
            [self.bgView removeFromSuperview];
        }
    }
    
    return shouldDismiss;
}


//+ (CJProgressHUD *)HUDForView:(UIView *)view {
//    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
//    for (UIView *subview in subviewsEnum) {
//        if ([subview isKindOfClass:self]) {
//            CJProgressHUD *hud = (CJProgressHUD *)subview;
//            if (hud.hasFinished == NO) {
//                return hud;
//            }
//        }
//    }
//    return nil;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
