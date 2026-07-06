//
//  UIViewController+CQNavigationBar.m
//  CQDemoKit
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "UIViewController+CQNavigationBar.h"
#import <Masonry/Masonry.h>
#import <objc/runtime.h>

static NSString * const cqtsNavigationBackActionKey = @"cqts_touchUpInsideBlockKey";

@interface UIViewController () {
    
}
@property (nonatomic, copy) void (^cqtsNavigationBackAction)(UIButton *bButton);   /**< 返回按钮操作的事件 */


@end



@implementation UIViewController (CQNavigationBar)

#pragma mark - runtime

// cqtsNavigationBackAction
- (void (^)(UIButton * _Nonnull))cqtsNavigationBackAction {
    return objc_getAssociatedObject(self, (__bridge const void *)(cqtsNavigationBackActionKey));
}

- (void)setCqtsNavigationBackAction:(void (^)(UIButton * _Nonnull))cqtsNavigationBackAction {
    objc_setAssociatedObject(self, (__bridge const void *)(cqtsNavigationBackActionKey), cqtsNavigationBackAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setupNavigationBarColor:(UIColor *)bgColor
                          title:(NSString *)title
                    backButtonTitle:(NSString *)backTitle
//                         backAction:(SEL)backAction
                    backButtonAction:(void (^)(UIButton * _Nonnull))backButtonAction
{
    self.cqtsNavigationBackAction = backButtonAction;
    
    // 创建导航栏视图
    UIView *navigationBarView = [[UIView alloc] init];
    navigationBarView.backgroundColor = bgColor;
    [self.view addSubview:navigationBarView];

    // 适配 iOS 11 及以上的安全区域
    [navigationBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(0);
        } else {
            make.top.equalTo(self.topLayoutGuide.bottomAnchor).offset(0);
        }
        make.height.mas_equalTo(44);
        make.left.right.equalTo(self.view);
    }];

    // 创建返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [backButton setTitle:backTitle forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(__cqtsNavigationBackAction:) forControlEvents:UIControlEventTouchUpInside];
    [navigationBarView addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(navigationBarView).offset(10);
        make.width.mas_equalTo(80);
        make.top.bottom.equalTo(navigationBarView);
    }];

    // 创建标题 Label
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = title;
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [navigationBarView addSubview:titleLabel];

    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(navigationBarView);
        make.centerY.equalTo(navigationBarView);
    }];
}

#pragma mark - Private Method
// 按钮点击
- (void)__cqtsNavigationBackAction:(UIButton *)button {
    if (self.cqtsNavigationBackAction) {
        self.cqtsNavigationBackAction(button);
    }
}

@end
