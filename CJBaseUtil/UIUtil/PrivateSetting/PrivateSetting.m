//
//  PrivateSetting.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 14-11-6.
//  Copyright (c) 2014年 lichq. All rights reserved.
//

#import "PrivateSetting.h"

#define PRO_W6 @"HiraKakuProN-W6"
#define PRO_W3 @"HiraKakuProN-W3"

@implementation PrivateSetting

+ (void)customStatusBar{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

+ (void)customNavigationBarAppearance{
    UIColor *barTintColor = [UIColor colorWithRed:0xf0/255.0f green:0xf0/255.0f blue:0xf0/255.0f alpha:1];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        [[UINavigationBar appearance] setBarTintColor:barTintColor];
    }else{
        [[UINavigationBar appearance] setTintColor:barTintColor];
    }
//    [[UINavigationBar appearance] setTintColor:Color_Red];
    
//    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObject:Color_Red forKey:NSForegroundColorAttributeName]];
    /*
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName] forState:UIControlStateNormal];
    */
}

+ (void)customizeAppearanceForMenuBar:(UINavigationBar *)navBar{
    
//    if (SYSTEM_VERSION >= 7){
//        [navBar setBackgroundImage:[UIImage imageNamed:@"menuNav_BG64"] forBarMetrics:UIBarMetricsDefault];
//    }else {
//        [navBar setBackgroundImage:[UIImage imageNamed:@"menuNav_BG"] forBarMetrics:UIBarMetricsDefault];
//    }
    //lightGrayColor
    
    //为导航栏设置标题文本样式
    [navBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor whiteColor], NSForegroundColorAttributeName,
                                    [UIFont fontWithName:PRO_W6 size:18.0],NSFontAttributeName,
                                    nil]];
}


+ (void)hideStatusBar:(BOOL)isHide{

    [[UIApplication sharedApplication] setStatusBarHidden:isHide];
    
//    [self prefersStatusBarHidden];
//    [self setNeedsStatusBarAppearanceUpdate];

}


+ (void)startAnimating{
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    UIView *overlay = [[UIView alloc]initWithFrame:keywindow.bounds];
    overlay.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
    [keywindow addSubview:overlay];
    
    UIActivityIndicatorView *activityIndicatorV = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(100, 250, 110, 110)];
    [activityIndicatorV setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [overlay addSubview:activityIndicatorV];
    
    [activityIndicatorV startAnimating];
}

+ (void)finishAnimating{
//    [activityIndicatorV stopAnimating];
    
    UIWindow * keywindow = [[UIApplication sharedApplication] keyWindow];
    if (keywindow.subviews.count > 1) {
        UIView * overlay = [keywindow.subviews objectAtIndex:keywindow.subviews.count-1];
        [overlay removeFromSuperview];
    }
}



@end
