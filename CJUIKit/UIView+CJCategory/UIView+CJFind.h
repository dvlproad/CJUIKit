//
//  UIView+CJFind.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/18.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CJFind)

/**
 *  获取view所属的viewController(通过view找到拥有这个View的Controller)
 */
- (nullable UIViewController *)belongViewController;

@end
