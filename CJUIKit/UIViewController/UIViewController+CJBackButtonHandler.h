//
//  UIViewController+CJBackButtonHandler.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/6.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  设置自定义的返回按钮
 */
@interface UIViewController (CJBackButtonHandler) {
    
}
@property (nonatomic, strong) UIButton *cjCustomNavigationBackButton; /**< 自定义的返回Item上的按钮(只有设置了自定义的返回按钮，这个才会bushi不是nil) */


/**
 *  设置自定义的返回按钮（简单的自定义）
 *
 *  @param target           点击自定义的返回按钮要执行谁的的事件
 *  @param action           点击自定义的返回按钮要执行的事件
 */
- (void)cj_setCustomBackBarButtonItemWithTarget:(id)target action:(SEL)action;

/**
 *  设置自定义的返回按钮(包含复杂的的自定义)
 *
 *  @param normalImage      normalImage
 *  @param highlightedImage highlightedImage
 *  @param normalTitle      normalTitle
 *  @param selectedTitle    selectedTitle
 *  @param size             size
 *  @param target           点击自定义的返回按钮要执行谁的的事件
 *  @param action           点击自定义的返回按钮要执行的事件
 */
- (void)cj_setCustomBackBarButtonItemWithNormalImage:(UIImage *)normalImage
                                    highlightedImage:(UIImage *)highlightedImage
                                         normalTitle:(NSString *)normalTitle
                                       selectedTitle:(NSString *)selectedTitle
                                            withSize:(CGSize)size
                                              target:(id)target
                                              action:(SEL)action;

@end
