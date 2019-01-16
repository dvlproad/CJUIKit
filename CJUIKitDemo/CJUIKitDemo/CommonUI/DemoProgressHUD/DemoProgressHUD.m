//
//  DemoProgressHUD.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/20.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "DemoProgressHUD.h"

@interface DemoProgressHUD () {
    
}
@property (nonatomic, strong) UIImageView *lotAnimationView;
@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, assign, readonly) NSInteger callShowMethodCount;
@property (nonatomic, assign, readonly) NSInteger callDismissMethodCount;

@end


@implementation DemoProgressHUD


+ (DemoProgressHUD *)sharedInstance {
    static DemoProgressHUD *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
        
        UIImage *image = [UIImage imageNamed:@"icon.png"];
        _lotAnimationView = [[UIImageView alloc] initWithImage:image];
        _lotAnimationView.backgroundColor = [UIColor clearColor];
//        _lotAnimationView.loopAnimation = YES;
        [self addSubview:_lotAnimationView];
        
        CGFloat lotAnimationViewHeight = 40;
        _lotAnimationView.frame = CGRectMake(0, 0, lotAnimationViewHeight, lotAnimationViewHeight);
        
        CGFloat width = [[UIScreen mainScreen] bounds].size.width;
        CGFloat height = [[UIScreen mainScreen] bounds].size.height;
        CGFloat x = (width - lotAnimationViewHeight)/2;
        CGFloat y = (height- lotAnimationViewHeight)/2;
        self.frame = CGRectMake(x, y, lotAnimationViewHeight, lotAnimationViewHeight);
    }
    return self;
}

- (void)showInView:(UIView *)superView withShowBackground:(BOOL)showBackground {
    _callShowMethodCount++;
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if (superView == nil) {
        superView = keyWindow;
    } else {
        BOOL shouldTurnToWindowCenter = NO;
        if (shouldTurnToWindowCenter) {
            CGRect superViewConvertFrame = [superView convertRect:superView.frame toView:keyWindow];
            CGFloat offsetX = CGRectGetMinX(superViewConvertFrame)/2;
            CGFloat offsetY = CGRectGetMinY(superViewConvertFrame)/2;
            self.center = CGPointMake(CGRectGetMidX(superView.frame)-offsetX, CGRectGetMidY(superView.frame)-offsetY);
        }
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
//    [self.lotAnimationView play];
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
//        [self.lotAnimationView stop];
        [self removeFromSuperview];
        if (self.bgView) {
            [self.bgView removeFromSuperview];
        }
    }
    
    return shouldDismiss;
}



+ (void)show {
    [[DemoProgressHUD sharedInstance] showInView:nil withShowBackground:NO];
}

+ (void)dismiss {
    [[DemoProgressHUD sharedInstance] dismissWithForce:YES];
}

//+ (DemoProgressHUD *)HUDForView:(UIView *)view {
//    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
//    for (UIView *subview in subviewsEnum) {
//        if ([subview isKindOfClass:self]) {
//            DemoProgressHUD *hud = (DemoProgressHUD *)subview;
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
