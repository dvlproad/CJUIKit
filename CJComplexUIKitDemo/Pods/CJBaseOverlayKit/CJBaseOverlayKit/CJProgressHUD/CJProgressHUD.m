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

@end


@implementation CJProgressHUD


/*
*  初始化加载HUD
*
*  @param animationNamed    动画对应的json文件名
*  @param animationBundle   动画对应的json文件所在的bundle(如果是在MainBundle中，则可直接设为nil)
*
*  @return 加载HUD
*/
- (instancetype)initWithAnimationNamed:(NSString *)animationNamed
                              inBundle:(NSBundle *)animationBundle
{
    self = [super initWithFrame:CGRectZero];
    if(self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
        
        
        if (animationNamed == nil) {
            NSAssert(NO, @"Error: 请调[[CJHUDSettingManager sharedInstance] configHUDAnimationWithAnimationNamed: 来设置全局的ProgressHUD动画");
        }
        
        CGFloat lotAnimationViewHeight = 40;
        
        if (animationBundle) {
            _lotAnimationView = [LOTAnimationView animationNamed:animationNamed inBundle:animationBundle];
        } else {
            _lotAnimationView = [LOTAnimationView animationNamed:animationNamed];
        }
        
        //[_lotAnimationView setAnimationNamed:animationNamed inBundle:animationBundle];
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
