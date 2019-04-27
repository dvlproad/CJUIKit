//
//  UINavigationBar+CJChangeBG.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "UINavigationBar+CJChangeBG.h"
#import <objc/runtime.h>

@interface UINavigationBar ()

@property (nonatomic, strong) UIView *cjBackgroundColorOverlayView;

@end

@implementation UINavigationBar (CJChangeBG)

#pragma mark - runtime
- (UIView *)cjBackgroundColorOverlayView {
    return objc_getAssociatedObject(self, @selector(cjBackgroundColorOverlayView));
}

- (void)setCjBackgroundColorOverlayView:(UIView *)cjBackgroundColorOverlayView {
    objc_setAssociatedObject(self, @selector(cjBackgroundColorOverlayView), cjBackgroundColorOverlayView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - 背景色
/* 完整的描述请参见文件头部 */
- (void)cj_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.cjBackgroundColorOverlayView) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        
        CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
        CGFloat statusBarHeight = CGRectGetHeight(statusBarFrame);
        CGRect overlayViewFrame = CGRectMake(0, -statusBarHeight, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.bounds) + statusBarHeight);
        UIView *cjBackgroundColorOverlayView = [[UIView alloc] initWithFrame:overlayViewFrame];
        cjBackgroundColorOverlayView.userInteractionEnabled = NO;
        cjBackgroundColorOverlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:cjBackgroundColorOverlayView atIndex:0];
        
        self.cjBackgroundColorOverlayView = cjBackgroundColorOverlayView;
    }
    self.cjBackgroundColorOverlayView.backgroundColor = backgroundColor;
}

/* 完整的描述请参见文件头部 */
- (void)cj_resetBackgroundColor
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.cjBackgroundColorOverlayView removeFromSuperview];
    self.cjBackgroundColorOverlayView = nil;
}


#pragma mark - 导航栏最下面的横线
/* 完整的描述请参见文件头部 */
- (void)cj_hideUnderline:(BOOL)hide {
    if (hide) {
        [self setShadowImage:[[UIImage alloc] init]];
    } else {
        [self setShadowImage:nil];
    }
}

#pragma mark - 导航栏的位置
- (void)cj_setTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)cj_setElementsAlpha:(CGFloat)alpha
{
    //iOS11有bug,因为多了一个叫_UINavigationBarContentView的类。参考:[iOS11导航栏隐藏失效的问题](http://www.cocoachina.com/bbs/read.php?tid=1726064)
//    <__NSArrayM 0x600000449390>(
//                                <_UIBarBackground: 0x7ff541e0a4c0; frame = (0 -20; 414 64); userInteractionEnabled = NO; layer = <CALayer: 0x600000036fe0>>,
//                                <_UINavigationBarLargeTitleView: 0x7ff541d04f20; frame = (0 0; 0 44); clipsToBounds = YES; alpha = 0; hidden = YES; layer = <CALayer: 0x604000234100>>,
//                                <_UINavigationBarContentView: 0x7ff541e0bcf0; frame = (0 0; 414 44); clipsToBounds = YES; layer = <CALayer: 0x600000037340>>,
//                                <_UINavigationBarModernPromptView: 0x7ff541c11180; frame = (0 0; 0 44); alpha = 0; hidden = YES; layer = <CALayer: 0x6040002359e0>>
//                                )
    
    if (@available(iOS 11.0, *)) {
        NSLog(@"iOS11有bug,因为多了一个叫_UINavigationBarContentView的类。参考:[IOS11导航栏隐藏失效的问题](http://www.cocoachina.com/bbs/read.php?tid=1726064)");
    } else {
        [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
            view.alpha = alpha;
        }];
        
        [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
            view.alpha = alpha;
        }];
        
        UIView *titleView = [self valueForKey:@"_titleView"];
        titleView.alpha = alpha;
    }
}



@end
