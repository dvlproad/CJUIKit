//
//  UINavigationBar+CJChangeBG.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "UINavigationBar+CJChangeBG.h"
#import <objc/runtime.h>

@implementation UINavigationBar (CJChangeBG)

static NSString * const overlayKey = @"overlayKey";

#pragma mark - runtime
- (UIView *)overlay {
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay {
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/* 完整的描述请参见文件头部 */
- (void)cj_removeUnderline {
    [self setShadowImage:[[UIImage alloc] init]];
}

/* 完整的描述请参见文件头部 */
- (void)cj_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.bounds) + 20)];
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backgroundColor;
}

- (void)cj_setTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)cj_setElementsAlpha:(CGFloat)alpha
{
    //iOS11有bug,因为多了一个叫_UINavigationBarContentView的类。参考:[IOS11导航栏隐藏失效的问题](http://www.cocoachina.com/bbs/read.php?tid=1726064)
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

/* 完整的描述请参见文件头部 */
- (void)cj_reset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.overlay removeFromSuperview];
    self.overlay = nil;
}

@end
