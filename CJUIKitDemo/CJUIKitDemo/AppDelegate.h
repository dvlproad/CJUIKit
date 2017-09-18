//
//  AppDelegate.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UIWindow *cjFloatingWindow; /**< 创建的window必须强制持有，且要想window一直不被释放，除了strong，还必须放在AppDelegate上 */


@end

