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

@property (nonatomic) UIColor *cjOldBackgroundColor;

@end

@implementation UINavigationBar (CJChangeBG)

#pragma mark - runtime
- (UIColor *)cjOldBackgroundColor {
    return objc_getAssociatedObject(self, @selector(cjOldBackgroundColor));
}

- (void)setCjOldBackgroundColor:(UIColor *)cjOldBackgroundColor {
    objc_setAssociatedObject(self, @selector(cjOldBackgroundColor), cjOldBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - 背景色
///设置导航栏的背景色为指定背景色backgroundColor
- (void)cj_setBackgroundColor:(UIColor *)backgroundColor
{
    UIImage *backgroundImage = [UINavigationBar imageWithColor:backgroundColor size:CGSizeMake(10, 10)];
    [self setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    self.backgroundColor = backgroundColor;
    
    // 状态栏颜色变化
    // info.plist文件中设置 View controller-based status bar appearance 为 NO
//    if (@available(iOS 13.0, *)) {
//        // iOS 13之后，苹果禁止KVC直接修改私有属性。以前用KVC修改状态栏背景色也会Crash。
//        CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
//        //CGRect statusBarFrame = [UIApplication sharedApplication].keyWindow.windowScene.statusBarManager.statusBarFrame;
//        
//        static UIWindow *newWindow;     // 加static的目的是让局部变量不要被释放掉
//        if (newWindow == nil) {
//            newWindow = [[UIWindow alloc] initWithFrame:statusBarFrame];
//        }
//        newWindow.windowLevel = UIWindowLevelStatusBar + 100;   // 大于UIWindowLevelStatusBar将会显示在statusBar的前面，后面隐藏的时候，需要将此值改为小于UIWindowLevelNormal
//        [newWindow makeKeyAndVisible];  // 作为关键Window并且显示，后面注意要把keyWindow替换回去，不然会影响正常的window的工作
//        
//        UIImageView *statusBar = [[UIImageView alloc] initWithFrame:statusBarFrame];
//        statusBar.image = backgroundImage;
//        //[[UIApplication sharedApplication].keyWindow addSubview:statusBar];
//        [newWindow addSubview:statusBar];
//
//    } else {
//        // Fallback on earlier versions
//        UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
//        if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
//            statusBar.backgroundColor = backgroundColor;
//        }
//    }
}

///还原导航栏的背景色为之前的设置
- (void)cj_resetBackgroundColor {
    [self cj_setBackgroundColor:self.cjOldBackgroundColor];
}


#pragma mark - 导航栏最下面的横线
/*
 *  是否隐藏导航栏最下面的横线
 *
 *  @param hide 是否隐藏
 */
- (void)cj_hideUnderline:(BOOL)hide {
    if (hide) {
        [self setShadowImage:[[UIImage alloc] init]];
    } else {
        [self setShadowImage:nil];
    }
}

#pragma mark - 导航栏的位置
/*
 *  设置导航栏的位置
 *
 *  @param translationY    translationY
 */
- (void)cj_setTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}


/*
 *  改变导航栏上左、右及titleView的alpha值
 *
 *  @param alpha    alpha
 */
- (void)cj_setElementsAlpha:(CGFloat)alpha
{
    //iOS11有bug,因为多了一个叫_UINavigationBarContentView的类。参考:[iOS11导航栏隐藏失效的问题](http://www.cocoachina.com/bbs/read.php?tid=1726064)
    //    <__NSArrayM 0x600000449390>(
    //                                <_UIBarBackground: 0x7ff541e0a4c0; frame = (0 -20; 414 64); userInteractionEnabled = NO; layer = <CALayer: 0x600000036fe0>>,
    //                                <_UINavigationBarLargeTitleView: 0x7ff541d04f20; frame = (0 0; 0 44); clipsToBounds = YES; alpha = 0; hidden = YES; layer = <CALayer: 0x604000234100>>,
    //                                <_UINavigationBarContentView: 0x7ff541e0bcf0; frame = (0 0; 414 44); clipsToBounds = YES; layer = <CALayer: 0x600000037340>>,
    //                                <_UINavigationBarModernPromptView: 0x7ff541c11180; frame = (0 0; 0 44); alpha = 0; hidden = YES; layer = <CALayer: 0x6040002359e0>>
    //                                )
    
//    if (@available(iOS 11.0, *)) {
//        NSLog(@"iOS11有bug,因为多了一个叫_UINavigationBarContentView的类。参考:[IOS11导航栏隐藏失效的问题](http://www.cocoachina.com/bbs/read.php?tid=1726064)");
//    } else {
//        [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
//            view.alpha = alpha;
//        }];
//        
//        [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
//            view.alpha = alpha;
//        }];
//        
//        UIView *titleView = [self valueForKey:@"_titleView"];
//        titleView.alpha = alpha;
//    }
}



#pragma mark - Private Method
/*
*  根据颜色创建图片(方法来源于cj_imageWithColor)
*
*  @param color 图片颜色
*  @param size  图片大小
*
*  @return 纯色的图片
*/
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}



@end
