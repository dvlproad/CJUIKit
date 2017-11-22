//
//  PrivateSetting.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 14-11-6.
//  Copyright (c) 2014年 lichq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface PrivateSetting : NSObject

+ (void)customStatusBar;

+ (void)customNavigationBarAppearance;
+ (void)customizeAppearanceForMenuBar:(UINavigationBar *)navBar;

+ (void)hideStatusBar:(BOOL)isHide;


+ (void)startAnimating;
+ (void)finishAnimating;

@end
