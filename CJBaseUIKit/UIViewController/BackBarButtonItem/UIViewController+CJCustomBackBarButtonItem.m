//
//  UIViewController+CJCustomBackBarButtonItem.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/9/6.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "UIViewController+CJCustomBackBarButtonItem.h"
#import <objc/runtime.h>

@implementation UIViewController (CJCustomBackBarButtonItem)

#pragma mark - runtime
static NSString * const kcjCustomNavigationBackButtonKey = @"kcjCustomNavigationBackButtonKey";

- (UIButton *)cjCustomNavigationBackButton {
    return objc_getAssociatedObject(self, (__bridge const void *)(kcjCustomNavigationBackButtonKey));
}

- (void)setCjCustomNavigationBackButton:(UIButton *)cjCustomNavigationBackButton {
    objc_setAssociatedObject(self, (__bridge const void *)(kcjCustomNavigationBackButtonKey), cjCustomNavigationBackButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/* 完整的描述请参见文件头部 */
- (void)cj_setCustomBackBarButtonItemWithTarget:(id)target action:(SEL)action
{
    UIImage *normalImage = [UIImage imageNamed:@"cjBackBarButtonItem"];
    UIImage *highlightedImage = [UIImage imageNamed:@"cjBackBarButtonItem"];
    
    [self cj_setCustomBackBarButtonItemWithNormalImage:normalImage
                                      highlightedImage:nil
                                           normalTitle:nil
                                         selectedTitle:nil
                                              withSize:CGSizeZero
                                                target:target
                                                action:action];
}

/* 完整的描述请参见文件头部 */
- (void)cj_setCustomBackBarButtonItemWithNormalImage:(nullable UIImage *)normalImage
                                    highlightedImage:(nullable UIImage *)highlightedImage
                                         normalTitle:(nullable NSString *)normalTitle
                                       selectedTitle:(nullable NSString *)selectedTitle
                                            withSize:(CGSize)size
                                              target:(id)target
                                              action:(SEL)action
{
    //customBackBarButtonItem
    NSAssert(normalImage != nil || normalTitle != nil, @"请至少设置返回按钮的图片或者文字");
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0.0f, 0.0f, 25.0f, 25.0f)];
    [leftButton setImage:normalImage forState:UIControlStateNormal];
    [leftButton setImage:highlightedImage forState:UIControlStateHighlighted];
    [leftButton setTitle:normalTitle forState:UIControlStateNormal];
    [leftButton setTitle:selectedTitle forState:UIControlStateSelected];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    if (action) {
        [leftButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    if(!CGSizeEqualToSize(size, CGSizeZero)) {
        CGRect rectNow = leftButton.frame;
        rectNow.size = size;
        leftButton.frame = rectNow;
    }
    UIBarButtonItem *customBackBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    //fixedSpaceBarButtonItem
    UIBarButtonItem *fixedSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    fixedSpaceBarButtonItem.width = -10;
    
    self.navigationItem.leftBarButtonItems = @[fixedSpaceBarButtonItem,
                                               customBackBarButtonItem];
    self.cjCustomNavigationBackButton = leftButton;
}

//- (void)cjCustomBackBarButtonItemAction:(id)sender {
//    
//}

@end
